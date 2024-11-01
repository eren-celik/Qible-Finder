//
//  File.swift
//
//
//  Created by Ugur Cakmakci on 22.04.2024.
//

import UIKit

extension UILabel {
    
    public func setAttributedText(mainText: String, mainFont: UIFont, mainColor: UIColor, secondaryText: String, secondaryFont: UIFont, secondaryColor: UIColor) {
        // Create attributed string for main text with main font and color
        let attributedString = NSMutableAttributedString(string: mainText, attributes: [.font: mainFont, .foregroundColor: mainColor])
        
        // Find range of secondary text within main text
        let range = (mainText as NSString).range(of: secondaryText)
        
        // Apply secondary font and color to the range of secondary text
        attributedString.addAttributes([.font: secondaryFont, .foregroundColor: secondaryColor], range: range)
        
        // Set attributed text to the label
        self.attributedText = attributedString
    }
}
