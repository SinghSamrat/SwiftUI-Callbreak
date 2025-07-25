//
//  GameManager.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 06/07/2025.
//

import SwiftUI
import SpriteKit

enum PlayerPosition: Int, CaseIterable {
    case bottom = 0
    case right = 1
    case top = 2
    case left = 3
}

extension Notification.Name {
    static let turnChanged = Notification.Name("turnChanged")
    static let cardPlayed = Notification.Name("cardPlayed")
}

class GameManager: ObservableObject {
    static let shared = GameManager()

    private init() {}
    
    var playerCards: [PlayerPosition: [CardNode]] = [:]
    var currentTurn: PlayerPosition = .bottom {
        didSet {
            NotificationCenter.default.post(name: .turnChanged, object: currentTurn)
            NotificationCenter.default.post(name: .cardPlayed, object: nil)
        }
    }
    
    @Published var playerScores: [PlayerPosition: Int] = [
        .bottom: 0,
        .right: 0,
        .top: 0,
        .left: 0
    ]

    func advanceTurnAnticlockwise() {
        let all = PlayerPosition.allCases
        if let index = all.firstIndex(of: currentTurn) {
            let prevIndex = (index - 1 + all.count) % all.count
            currentTurn = all[prevIndex]
        }
    }

    func isCurrentPlayersCard(_ card: CardNode) -> Bool {
        return card.owner == .bottom
    }
    
//    func setTurnStart(from player: PlayerPosition) {
//        currentTurn = player
//    }
    
    func handleBotTurn(for bot: PlayerPosition, in scene: SKScene, cards: [CardNode], lastPlayedCard: CardNode?) {
        let botCards = cards.filter { $0.owner == bot }

        guard !botCards.isEmpty else {
            return
        }

        let suitToMatch = lastPlayedCard?.suit.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        let rankToBeat = lastPlayedCard?.rank ?? 0

        var selectedCard: CardNode?

        if let suit = suitToMatch {
            let normalizedSuit = suit.uppercased().trimmingCharacters(in: .whitespacesAndNewlines)
            
            func effectiveRank(_ card: CardNode) -> Int {
                return card.rank == 1 ? 14 : card.rank
            }

            let higherRankCards = botCards.filter {
                $0.suit.uppercased() == normalizedSuit &&
                effectiveRank($0) > (rankToBeat == 1 ? 14 : rankToBeat)
            }

            if !higherRankCards.isEmpty {
                selectedCard = higherRankCards.randomElement()
            } else {
                let sameSuitCards = botCards.filter {
                    $0.suit.uppercased() == normalizedSuit
                }

                if !sameSuitCards.isEmpty {
                    selectedCard = sameSuitCards.randomElement()
                }
            }
        }

        // Fallback: any card
        if selectedCard == nil {
            selectedCard = botCards.first
        }

        guard let cardToPlay = selectedCard else {
            print("selectedCard still nil. Returning.")
            return
        }


        let endPosition = targetPosition(for: bot, in: scene)
        let moveAction = SKAction.move(to: endPosition, duration: 0.4)

        // Determine rotation angle based on bot seat
        let rotationAngle: CGFloat
        switch bot {
        case .top:
            rotationAngle = 0         // Facing downwards (default)
        case .right:
            rotationAngle = -.pi / 2  // Rotated 90° counter-clockwise
        case .bottom:
            rotationAngle = .pi       // Upside down
        case .left:
            rotationAngle = .pi / 2   // Rotated 90° clockwise
        default:
            rotationAngle = 0
        }

        let rotateAction = SKAction.rotate(toAngle: rotationAngle, duration: 0.4, shortestUnitArc: true)
        let moveAndRotate = SKAction.group([moveAction, rotateAction])
        cardToPlay.texture = cardToPlay.faceTexture

        let maxZ = selectedCard?.parent!.children.map { $0.zPosition }.max() ?? 0
        cardToPlay.zPosition = maxZ + 1

        cardToPlay.run(moveAndRotate) {
            NotificationCenter.default.post(name: .cardPlayed, object: cardToPlay)
        }

    }
    
    func targetPosition(for playerSeat: PlayerPosition, in scene: SKScene) -> CGPoint {
        let center = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
        let offsetY: CGFloat = 40
        let offsetX: CGFloat = 50
        
        switch playerSeat {
        case .bottom:
            return CGPoint(x: center.x, y: center.y - offsetY)
        case .left:
            return CGPoint(x: center.x - offsetX, y: center.y)
        case .right:
            return CGPoint(x: center.x + offsetX, y: center.y)
        case .top:
            return CGPoint(x: center.x, y: center.y + offsetY)
        default:
            return center
        }
    }
    
    func getLegalCards(from handCards: [CardNode], playedCards: [CardNode]) -> [CardNode] {
        guard let playSuit = playedCards.first?.suit else {
            return handCards // fail-safe fallback
        }
        
        if playSuit == "S" {
            let spadeCards = getSuitCards(suit: "S", from: handCards)
            
            if spadeCards.isEmpty {
                return handCards
            } else {
                let highestSpade = getHighestRank(playedCardIDs: playedCards, suit: "S")
                let higherSpades = getHigherCards(cards: spadeCards, rank: highestSpade)
                
                if higherSpades.isEmpty {
                    return spadeCards
                } else {
                    return higherSpades
                }
            }
        } else {
            let trumped = isTrumped(playedCardIDs: playedCards)
            
            if trumped {
                let suitCards = getSuitCards(suit: playSuit, from: handCards)
                
                if suitCards.isEmpty {
                    let spadeCards = getSuitCards(suit: "S", from: handCards)
                    
                    if spadeCards.isEmpty {
                        return handCards
                    } else {
                        let highestSpade = getHighestRank(playedCardIDs: playedCards, suit: "S")
                        let higherSpades = getHigherCards(cards: spadeCards, rank: highestSpade)
                        
                        if higherSpades.isEmpty {
                            return handCards
                        } else {
                            return higherSpades
                        }
                    }
                } else {
                    return suitCards
                }
            } else {
                let suitCards = getSuitCards(suit: playSuit, from: handCards)
                
                if suitCards.isEmpty {
                    let spadeCards = getSuitCards(suit: "S", from: handCards)
                    
                    if spadeCards.isEmpty {
                        return handCards
                    } else {
                        return spadeCards
                    }
                } else {
                    let highestSuitRank = getHighestRank(playedCardIDs: playedCards, suit: playSuit)
                    let higherSuitCards = getHigherCards(cards: suitCards, rank: highestSuitRank)
                    
                    if higherSuitCards.isEmpty {
                        return suitCards
                    } else {
                        return higherSuitCards
                    }
                }
            }
        }
    }
    
    func isTrumped(playedCardIDs: [CardNode]) -> Bool {
        var isTrumped = false

        for (index, card) in playedCardIDs.enumerated() {
            if index == 0 {
                
            } else {
                if card.suit == "S" {
                    isTrumped = true
                    break
                }
            }
        }

        return isTrumped
    }
    
    func getHigherCards(cards: [CardNode], rank: Int) -> [CardNode] {
        var higherCards: [CardNode] = []
        
        for card in cards {
            if card.rank > rank {
                higherCards.append(card)
            }
        }
        
        return higherCards
    }

    
    func getHighestRank(playedCardIDs: [CardNode], suit: String) -> Int {
        precondition(!playedCardIDs.isEmpty, "Can't check highest rank from zero played cards.")

        var highestRank = -1
        
        for card in playedCardIDs {
            if card.suit == suit && card.rank > highestRank {
                highestRank = card.rank
            }
        }
        
        return highestRank
    }
    
    func getSuitCards(suit: String, from cards: [CardNode]) -> [CardNode] {
        var suitCards: [CardNode] = []
        
        for card in cards {
            if card.suit == suit {
                suitCards.append(card)
            }
        }
        
        return suitCards
    }
    
    func reset() {
            playerScores = [
                .bottom: 0,
                .right: 0,
                .top: 0,
                .left: 0
            ]
            playerCards = [:]
            currentTurn = .bottom
            // Reset any other state variables here
        }

}


