//
//  CardNode.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 05/07/2025.
//

import SpriteKit

class CardNode: SKSpriteNode {
    let rank: Int
    let suit: String
    var owner: PlayerPosition
    private var originalPosition: CGPoint = .zero
    
    public static private(set) var cardSizeNormal: CGSize = .zero
    public static private(set) var cardSizeThrown: CGSize = .zero
    public static private(set) var cardSizeSelf: CGSize = .zero
    public static private(set) var cardSizeSelfTouched: CGSize = .zero
    public static private(set) var cardSizeOpponent: CGSize = .zero

    public static private(set) var cardScaleNormal: CGFloat = 0
    public static private(set) var cardScaleThrown: CGFloat = 0
    public static private(set) var cardScaleSelf: CGFloat = 0
    public static private(set) var cardScaleSelfTouched: CGFloat = 0
    public static private(set) var cardScaleOpponent: CGFloat = 0
    
    init(rank: Int, suit: String, owner: PlayerPosition) {
        self.rank = rank
        self.suit = suit
        self.owner = owner
        print("owner: ", owner)
        
        var texture = CardNode.getCardTexture(rank: self.rank, suit: self.suit.first ?? "S");
        if rank == 0 && suit == "b" {
            texture = CardNode.getCardBackTexture()
        }
        
        super.init(texture: texture, color: .clear, size: CGSize(width: 191, height: 262))
        
        if self.owner != .bottom {
            self.isUserInteractionEnabled = false
        } else {
            self.isUserInteractionEnabled = true
        }
            
        let original = texture.size()
        let width = original.width
        let height = original.height
        
        CardNode.cardSizeNormal = CGSize(width: width * 0.35, height: height * 0.35)
        CardNode.cardSizeThrown = CGSize(width: CardNode.cardSizeNormal.width * 1.05, height: CardNode.cardSizeNormal.height * 1.05)
        CardNode.cardSizeSelf = CGSize(width: CardNode.cardSizeNormal.width * 1.2, height: CardNode.cardSizeNormal.height * 1.2)
        CardNode.cardSizeSelfTouched = CGSize(width: CardNode.cardSizeSelf.width * 1.32, height: CardNode.cardSizeSelf.height * 1.32)
        CardNode.cardSizeOpponent = CGSize(width: CardNode.cardSizeNormal.width * 0.4, height: CardNode.cardSizeNormal.height * 0.4)

        CardNode.cardScaleNormal = CardNode.cardSizeNormal.width / width
        CardNode.cardScaleThrown = CardNode.cardSizeThrown.width / width
        CardNode.cardScaleSelf = CardNode.cardSizeSelf.width / width
        CardNode.cardScaleSelfTouched = CardNode.cardSizeSelfTouched.width / width
        CardNode.cardScaleOpponent = CardNode.cardSizeOpponent.width / width

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard GameManager.shared.currentTurn == self.owner else { return }
        originalPosition = position
        self.size = CardNode.cardSizeSelfTouched
        self.zPosition = 100
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard GameManager.shared.currentTurn == self.owner else { return }
        if let touch = touches.first {
           let location = touch.location(in: parent!)
           self.position = location
           let thresholdY: CGFloat = 100
           if location.y > thresholdY {
               self.size = CardNode.cardSizeThrown
           }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.zPosition = 1
        guard GameManager.shared.currentTurn == self.owner else { return }
        guard let touch = touches.first, let parent = self.parent else { return }
        let location = touch.location(in: parent)
        
        let thresholdY: CGFloat = 100
        if location.y > thresholdY {
            let centerPoint = CGPoint(x: parent.frame.midX, y: parent.frame.midY)
            let moveToCenter = SKAction.move(to: centerPoint, duration: 0.3)
            self.run(moveToCenter)
            self.size = CardNode.cardSizeThrown
            self.isUserInteractionEnabled = false
            NotificationCenter.default.post(name: .cardPlayed, object: self)
        } else {
            let moveBack = SKAction.move(to: originalPosition, duration: 0.3)
            self.run(moveBack)
            self.size = CardNode.cardSizeSelf
        }
    }
    
    static func getCardTexture(rank: Int, suit: Character) -> SKTexture {
        let spriteSheet = SKTexture(imageNamed: "classic_card_spritesheet")
        spriteSheet.filteringMode = .nearest
        
        let columns = 13
        let rows = 5

        let suitRow: [Character: Int] = [
            "D": 0,
            "C": 1,
            "H": 2,
            "S": 3
        ]

        guard let row = suitRow[suit], rank >= 1 && rank <= 13 else {
            fatalError("Invalid rank or suit")
        }
        
        let column: Int = (rank == 1) ? 12 : rank - 2

        let frameWidth = 1.0 / CGFloat(columns)
        let frameHeight = 1.0 / CGFloat(rows)

        let rect = CGRect(
            x: frameWidth * CGFloat(column),
            y: frameHeight * CGFloat((rows - 1) - row),
            width: frameWidth,
            height: frameHeight
        )

        return SKTexture(rect: rect, in: spriteSheet)
    }
    
    static func getCardBackTexture() -> SKTexture {
        let spriteSheet = SKTexture(imageNamed: "classic_card_spritesheet")
        spriteSheet.filteringMode = .nearest

        let columns = 13
        let rows = 5

        let column = 0 // 1st card in the row
        let row = 4    // 5th row (0-indexed)

        let frameWidth = 1.0 / CGFloat(columns)
        let frameHeight = 1.0 / CGFloat(rows)

        let rect = CGRect(
            x: frameWidth * CGFloat(column),
            y: frameHeight * CGFloat((rows - 1) - row),
            width: frameWidth,
            height: frameHeight
        )

        return SKTexture(rect: rect, in: spriteSheet)
    }
    
    func animateToPosition(position: CGPoint) {
        let moveAction = SKAction.moveTo(y: CGFloat(position.y), duration: 0.3)
        self.run(moveAction)
    }

}

