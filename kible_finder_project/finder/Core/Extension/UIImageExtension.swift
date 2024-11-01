//
//  UIImageExtension.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 12.06.2024.
//

import UIKit

extension UIImage {
    static func namazAsset(named name: String, bundle: Bundle? = .namaz) -> UIImage? {
        guard let bundle else { return nil }
        return UIImage(named: name, in: bundle, compatibleWith: nil)
    }
    
    public convenience init?(color: UIColor, size: CGSize) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
