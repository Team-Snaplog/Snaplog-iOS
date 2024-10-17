//
//  UIImage+Extension.swift
//  Utility
//
//  Created by 강민성 on 9/22/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit

//extension UIImage {
//    public func resize(targetSize: CGSize) -> UIImage? {
//        let newRect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height).integral
//        UIGraphicsBeginImageContextWithOptions(newRect.size, true, 0)
//        guard let context = UIGraphicsGetCurrentContext() else { return nil }
//        context.interpolationQuality = .high
//        draw(in: newRect)
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return newImage
//    }
//}
