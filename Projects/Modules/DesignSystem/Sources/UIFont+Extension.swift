//
//  UIFont+Extension.swift
//  DesignSystem
//
//  Created by 강민성 on 9/4/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit

extension UIFont {
    enum FontFamily: String {
        case bold = "Pretendard-Bold" // 700
        case semiBold = "Pretendard-SemiBold" // 600
        case regular = "Pretendard-Regular" // 400

        var name: String {
            return self.rawValue
        }

        static func font(_ family: FontFamily, ofsize size: CGFloat) -> UIFont {
            return UIFont(name: family.rawValue, size: size)!
        }
    }
}

public struct FontProperty {
    let style: UIFont.FontFamily
    let size: CGFloat
    let lineHeight: CGFloat
}

public enum Fonts {
    case displayLarge, displayMedium, displaySmall // bold
    case headlineLarge, headlineMedium, headlineSmall // bold
    case titleLarge, titleMedium, titleSmall // semiBold
    case labelLarge, labelMedium, labelSmall // regular
    case buttonLarge, buttonMedium, buttonSmall // bold

    public var fontProperty: FontProperty {
        switch self {

        case .displayLarge:
            return FontProperty(style: .bold, size: 58, lineHeight: 64)

        case .displayMedium:
            return FontProperty(style: .bold, size: 44, lineHeight: 52)

        case .displaySmall:
            return FontProperty(style: .bold, size: 36, lineHeight: 44)

        case .headlineLarge:
            return FontProperty(style: .bold, size: 32, lineHeight: 40)

        case .headlineMedium:
            return FontProperty(style: .bold, size: 28, lineHeight: 36)

        case .headlineSmall:
            return FontProperty(style: .bold, size: 24, lineHeight: 32)

        case .titleLarge:
            return FontProperty(style: .semiBold, size: 22, lineHeight: 28)

        case .titleMedium:
            return FontProperty(style: .semiBold, size: 18, lineHeight: 24)

        case .titleSmall:
            return FontProperty(style: .semiBold, size: 14, lineHeight: 20)

        case .labelLarge:
            return FontProperty(style: .regular, size: 16, lineHeight: 24)

        case .labelMedium:
            return FontProperty(style: .regular, size: 14, lineHeight: 20)

        case .labelSmall:
            return FontProperty(style: .regular, size: 12, lineHeight: 16)

        case .buttonLarge:
            return FontProperty(style: .bold, size: 18, lineHeight: 24)

        case .buttonMedium:
            return FontProperty(style: .bold, size: 16, lineHeight: 24)

        case .buttonSmall:
            return FontProperty(style: .bold, size: 14, lineHeight: 16)
        }
    }
}

public extension Fonts {
    var font: UIFont {
        guard let font = UIFont(name: fontProperty.style.name, size: fontProperty.size) else {
            return UIFont()
        }
        return font
    }

//    var lineHeight: CGFloat {
//        return fontProperty.lineHeight
//    }
}
