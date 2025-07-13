//
//  GameSceneView.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 05/07/2025.
//

import SpriteKit
import SwiftUI

let CARD_Y_POSITION_NORMAL = 30
let CARD_Y_POSITION_LEGAL = 50


extension CGFloat {
    static func degreesToRadians(_ degrees: CGFloat) -> CGFloat {
        return degrees * .pi / 180
    }
}

struct GameplayView: View {
    @ObservedObject var gameManager = GameManager.shared
    @State private var scene: GameScene = GameScene()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            
            SpriteView(scene: scene)
                .ignoresSafeArea()
                .background(Color.clear)
                .onAppear{
                    gameManager.reset()
                    let newScene = GameScene()
                    newScene.size = CGSize(width: 390, height: 844)
                    newScene.scaleMode = .resizeFill
                    self.scene = newScene
                }
            
            VStack {
                BotInGameHUD(name: "Bot 2", score: gameManager.playerScores[.top]!) // Top
                Spacer()
            }
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                PlayerInGameHUD() // Bottom
            }
            .ignoresSafeArea()
            
            HStack {
                BotInGameHUD(name: "Bot 1", score: gameManager.playerScores[.left]!) // Left
                Spacer()
            }
            
            HStack {
                Spacer()
                BotInGameHUD(name: "Bot 3", score: gameManager.playerScores[.right]!) // Right
            }
        }
        .overlay(alignment: .topTrailing) {
            QuitButtonView {
                dismiss()
            }
        }
    }
}

class GameScene: SKScene {
    var lastPlayedCard: CardNode? = nil
    var playedCardsThisRound: [CardNode] = []
    
    override func didMove(to view: SKView) {
        print("didMove")
        NotificationCenter.default.addObserver(self, selector: #selector(turnChanged(_:)), name: .turnChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cardPlayed(_:)), name: .cardPlayed, object: nil)
        backgroundColor = .clear
        
        let background = SKSpriteNode(imageNamed: "theme_modern")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.size = size
        background.zPosition = -1 // behind everything else
        addChild(background)
        
        distributeCards()
    }
    
    @objc func cardPlayed(_ notification: Notification) {
        if let card = notification.object as? CardNode {
            lastPlayedCard = card
            playedCardsThisRound.append(card)
            
            if var cards = GameManager.shared.playerCards[card.owner] {
                if let index = cards.firstIndex(of: card) {
                    cards.remove(at: index)
                    GameManager.shared.playerCards[card.owner] = cards
                }
            }
            
            for card_item in GameManager.shared.playerCards[.bottom]! {
                if card_item != lastPlayedCard {
                    card_item.animateToPosition(position: CGPoint(x: card_item.position.x, y: CGFloat(CARD_Y_POSITION_NORMAL))) // highlight legal cards
                }
            }
            
            if playedCardsThisRound.count == 4 {
                removePlayedCardsAfterDelay()
                return
            }
            
            GameManager.shared.advanceTurnAnticlockwise()
        }
    }
    
    @objc func turnChanged(_ notification: Notification) {
        guard let player = notification.object as? PlayerPosition else { return }
        
        // highlight current player, update HUD
        
        if GameManager.shared.currentTurn != .bottom {
            run(SKAction.wait(forDuration: 0.1)) {
                GameManager.shared.handleBotTurn(
                    for: GameManager.shared.currentTurn,
                    in: self,
                    cards: GameManager.shared.playerCards[player]!,
                    lastPlayedCard: self.lastPlayedCard
                )
            }
            
        } else {
            let legalCards: [CardNode] = GameManager.shared.getLegalCards(from: GameManager.shared.playerCards[.bottom]!, playedCards: self.playedCardsThisRound)
            for card in GameManager.shared.playerCards[.bottom]! {
                if legalCards.contains(card) {
                    card.isUserInteractionEnabled = true
                    card.animateToPosition(position: CGPoint(x: card.position.x, y: CGFloat(CARD_Y_POSITION_LEGAL))) // highlight legal cards
                } else {
                    card.isUserInteractionEnabled = false
                }
                
            }
        }
    }
    
    func distributeCards() {
        CardDistributor.distributeCards(from: .bottom, to: [.left, .top, .right, .bottom], in: self) { playerCards in
            CardDistributor.layoutBottomPlayerCards(cards: playerCards[.bottom]!, in: self)
        }
    }
    
    func removePlayedCardsAfterDelay() {
        run(SKAction.wait(forDuration: 0.8)) { [weak self] in
            guard let self = self else { return }
            
            guard self.playedCardsThisRound.count == 4 else { return }
            
            // 1. Determine the winning card
            _ = self.playedCardsThisRound.first?.suit
            //            let candidates = self.playedCardsThisRound.filter { $0.suit == leadSuit }
            let winningCard = determineHandWinner(from: playedCardsThisRound)
            
            guard let winner = winningCard?.owner else {
                print("Could not determine winner.")
                return
            }
            
            // 2. Determine exit direction based on winner
            let exitPoint: CGPoint = {
                switch winner {
                case .bottom: return CGPoint(x: self.size.width / 2, y: -200)
                case .top:    return CGPoint(x: self.size.width / 2, y: self.size.height + 200)
                case .left:   return CGPoint(x: -200, y: self.size.height / 2)
                case .right:  return CGPoint(x: self.size.width + 200, y: self.size.height / 2)
                }
            }()
            
            // 3. Move played cards toward winner
            for card in self.playedCardsThisRound {
                let moveOut = SKAction.move(to: exitPoint, duration: 0.4)
                let fadeOut = SKAction.fadeOut(withDuration: 0.2)
                let remove = SKAction.removeFromParent()
                card.run(SKAction.sequence([moveOut, fadeOut, remove]))
            }
            
            print("Winner of hand: \(winner)")
            
            // 4. Reset state
            self.playedCardsThisRound.removeAll()
            self.lastPlayedCard = nil
            
            print(GameManager.shared.playerCards[.left]!.isEmpty)
            GameManager.shared.playerScores[winner, default: 0] += 1
            if GameManager.shared.playerCards[.left]!.isEmpty {
                let label = SKLabelNode(text: "\(determineRoundWinner()) Wins!")
                label.fontName = "AvenirNext-Bold"
                label.fontSize = 36
                label.fontColor = .white
                label.position = CGPoint(x: size.width / 2, y: size.height / 2)
                label.zPosition = 100
                addChild(label)
            }
            
            self.run(SKAction.wait(forDuration: 1.5)) {
                GameManager.shared.currentTurn = winner
            }
        }
    }
    
    func determineHandWinner(from playedCards: [CardNode]) -> CardNode? {
        func effectiveRank(_ card: CardNode) -> Int {
            return card.rank == 1 ? 14 : card.rank
        }
        
        let spades = playedCards.filter { $0.suit.uppercased() == "S" }
        
        if !spades.isEmpty {
            return spades.max(by: { effectiveRank($0) < effectiveRank($1) })
        }
        
        guard let leadSuit = playedCards.first?.suit.uppercased() else {
            return nil
        }
        
        let sameSuit = playedCards.filter { $0.suit.uppercased() == leadSuit }
        return sameSuit.max(by: { effectiveRank($0) < effectiveRank($1) })
    }
    
    func determineRoundWinner() -> PlayerPosition {
        if let winnerPos = GameManager.shared.playerScores.max(by: { $0.value < $1.value }) {
            print("Winner: \(winnerPos.key) with score: \(winnerPos.value)")
            return winnerPos.key
        }
        
        return .bottom
    }
}

class CardDistributor {
    static func distributeCards(
        from dealerPosition: PlayerPosition,
        to players: [PlayerPosition],
        in scene: SKScene,
        completion: @escaping ([PlayerPosition: [CardNode]]) -> Void
    ) {
        let positions = getSeatPositions(in: scene)
        guard let dealerPoint = positions[dealerPosition] else { return }

        let totalRounds = 13
        var totalDelay: TimeInterval = 0
        
        
        let allRanks: Array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13].shuffled()
        let allSuits: Array = ["D", "C", "H", "S"].shuffled()
        
        var deck: [(rank: Int, suit: String)] = []

        for suit in allSuits {
            for rank in allRanks {
                deck.append((rank, suit))
            }
        }

        // 2. Shuffle the deck
        deck.shuffle()

        for round in 0..<totalRounds {
            for (index, player) in players.enumerated() {
                guard let targetPoint = positions[player] else { continue }
                
                let cardIndex = index * 13 + round
                let cardData = deck[cardIndex]
                
                let card = CardNode(rank: cardData.rank, suit: cardData.suit, owner: player)
                card.size = CardNode.cardSizeNormal
                
//                let card = SKSpriteNode(texture: card.texture)
                card.position = dealerPoint
                card.zPosition = 10
//                card.setScale(1.0)
                scene.addChild(card)
                
                GameManager.shared.playerCards[player, default: []].append(card)

                let delayBetweenCards = TimeInterval.random(in: 0.01...0.1)
                let delay = totalDelay
                totalDelay += delayBetweenCards
                
                let move = SKAction.move(to: targetPoint, duration: 0.3)
                let scale = SKAction.scale(to: CardNode.cardSizeNormal, duration: 0.2)
                
                let randomAngle = CGFloat.degreesToRadians(CGFloat.random(in: -15...15))
                let baseAngle: CGFloat = (player == .left || player == .right) ? .pi / 2 : 0
                let finalRotation = baseAngle + randomAngle
                let rotate = SKAction.rotate(toAngle: finalRotation, duration: 0.2, shortestUnitArc: true)
                
                let group = SKAction.group([move, scale, rotate])
                let wait = SKAction.wait(forDuration: delay)
                let sequence = SKAction.sequence([wait, group])

                card.run(sequence)
            }
        }

        scene.run(SKAction.wait(forDuration: totalDelay + 0.5)) {
            for player in players {
                if player != .bottom {
                    if let cards = GameManager.shared.playerCards[player] {
                        moveBotCardsBehind(cards, for: player, basePositions: positions, scene: scene)
                    }
                }
            }
            completion(GameManager.shared.playerCards)
        }
    }
    
    static func getSeatPositions(in scene: SKScene) -> [PlayerPosition: CGPoint] {
        let size = scene.size
        return [
            .bottom: CGPoint(x: size.width / 2, y: 80),
            .top: CGPoint(x: size.width / 2, y: size.height - 80),
            .left: CGPoint(x: 140, y: size.height / 2),
            .right: CGPoint(x: size.width - 140, y: size.height / 2)
        ]
    }
    
    static func layoutBottomPlayerCards(cards: [CardNode], in scene: SKScene) {
        let totalCards = cards.count
        let cardWidth = CardNode.cardSizeSelf.width
        let cardHeight = CardNode.cardSizeSelf.height
        let spacing: CGFloat = cardWidth / 1.5
        let totalWidth = CGFloat(totalCards - 1) * spacing + cardWidth
        let startX = (scene.size.width - totalWidth) / 1.4
        let yPosition: CGFloat = CGFloat(CARD_Y_POSITION_NORMAL)

        for (index, card) in cards.enumerated() {
            let xPosition = startX + CGFloat(index) * spacing
            let position = CGPoint(x: xPosition, y: yPosition)

            // Animate to position
            let moveAction = SKAction.move(to: position, duration: 0.3)
            let resizeAction = SKAction.resize(toWidth: cardWidth, height: cardHeight, duration: 0.2)
            let rotateAction = SKAction.rotate(toAngle: 0, duration: 0.2, shortestUnitArc: true)
            let showFaceAction = SKAction.run {
                /*card.showFace()*/ // or `card.isFaceUp = true` depending on your implementation
            }

            card.run(SKAction.sequence([moveAction, rotateAction, showFaceAction, resizeAction]))
        }
    }
    
    static func moveBotCardsBehind(_ cards: [SKNode], for player: PlayerPosition, basePositions: [PlayerPosition: CGPoint], scene: SKScene) {
        let targetPos = positionBehind(for: player, basePositions: basePositions)
        
        for card in cards {
            let moveAction = SKAction.move(to: targetPos, duration: 0.4)
            card.run(moveAction)
        }
    }
    
    static func positionBehind(for player: PlayerPosition, basePositions: [PlayerPosition: CGPoint], offsetAmount: CGFloat = 20) -> CGPoint {
        guard let basePos = basePositions[player] else { return .zero }
        
        switch player {
        case .left:
            return CGPoint(x: basePos.x - offsetAmount, y: basePos.y)
        case .right:
            return CGPoint(x: basePos.x + offsetAmount, y: basePos.y)
        case .top:
            return CGPoint(x: basePos.x, y: basePos.y + offsetAmount)
        default:
            // For bottom or unknown players, return base position
            return basePos
        }
    }
}
