//
//  CGSizeHelper.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 05/07/2025.
//

import SwiftUI

public class CardLayoutHelper {
    public static var cardTextureSizeOriginal: CGSize = .zero {
        didSet {
            computeCardLayouts()
        }
    }

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

    private static func computeCardLayouts() {
        let original = cardTextureSizeOriginal
        let width = original.width
        let height = original.height

        cardSizeNormal = CGSize(width: width * 0.35, height: height * 0.35)
        cardSizeThrown = CGSize(width: cardSizeNormal.width * 1.05, height: cardSizeNormal.height * 1.05)
        cardSizeSelf = CGSize(width: cardSizeNormal.width * 1.2, height: cardSizeNormal.height * 1.2)
        cardSizeSelfTouched = CGSize(width: cardSizeSelf.width * 1.32, height: cardSizeSelf.height * 1.32)
        cardSizeOpponent = CGSize(width: cardSizeNormal.width * 0.4, height: cardSizeNormal.height * 0.4)

        cardScaleNormal = cardSizeNormal.width / width
        cardScaleThrown = cardSizeThrown.width / width
        cardScaleSelf = cardSizeSelf.width / width
        cardScaleSelfTouched = cardSizeSelfTouched.width / width
        cardScaleOpponent = cardSizeOpponent.width / width
        
    }
}
