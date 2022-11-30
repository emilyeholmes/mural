//
//  UIColorExtensions.swift
//  Mural
//
//  Created by Ethan Kuo on 11/29/22.
//

import Foundation
import UIKit

public extension UIImage {
    func mergeWith(topImage: UIImage) -> UIImage {
        let bottomImage = self

        UIGraphicsBeginImageContext(size)


        let areaSize = CGRect(x: 0, y: 0, width: bottomImage.size.width, height: bottomImage.size.height)
        bottomImage.draw(in: areaSize)

        topImage.draw(in: areaSize, blendMode: .normal, alpha: 1.0)

        let mergedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return mergedImage
    }
    
    func resizeImageTo(size: CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
