//
//  Font.swift
//  FLPCore
//
//  Created by Ugur Cakmakci on 23.03.2024.
//

import UIKit


public enum Font {
    public struct FType: FontTypeProtocol {
        public static var extraLight: String { "Metropolis-ExtraLight" }
        public static var light: String { "Metropolis-Light" }
        public static var regular: String { "Metropolis-Regular" }
        public static var medium: String { "Metropolis-Medium" }
        public static var semiBold: String { "Metropolis-SemiBold" }
        public static var bold: String { "Metropolis-Bold" }
        public static var extraBold: String { "Metropolis-ExtraBold" }
    }
    
    public enum Size: CGFloat {
        case s12 = 12
        case s14 = 14
        case s16 = 16
        case s18 = 18
        case s20 = 20
        case s24 = 24
        case s32 = 32
        case s40 = 40
        case s42 = 42
        case s44 = 44
        case s48 = 48
    }
    
    public static func configure() {
        register(with: Font.FType.extraLight)
        register(with: Font.FType.light)
        register(with: Font.FType.regular)
        register(with: Font.FType.medium)
        register(with: Font.FType.semiBold)
        register(with: Font.FType.bold)
        register(with: Font.FType.extraBold)
    }
    
    public static func checkFonts() {
        let allFonts = UIFont.familyNames.sorted()
        for familyName in allFonts {
            print("Font Family: \(familyName)")
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            for fontName in fontNames {
                print("   \(fontName)")
            }
        }
    }
    
    private static func register(with name: String) {
        let fontPath = Bundle.namaz!.path(forResource: name, ofType: "otf")
        let inData = NSData(contentsOfFile: fontPath!)
        var error: Unmanaged<CFError>?
        let provider = CGDataProvider(data: inData!)
        if let font = CGFont(provider!) {
            CTFontManagerRegisterGraphicsFont(font, &error)
            if error != nil { fatalError() }
        }
    }
}

extension UIFont {
    public class func extraLight(_ size: Font.Size) -> UIFont {
        return UIFont(name: Font.FType.extraLight, size: size.rawValue)!
    }
    
    public class func light(_ size: Font.Size) -> UIFont {
        return UIFont(name: Font.FType.light, size: size.rawValue)!
    }
    
    public class func regular(_ size: Font.Size) -> UIFont {
        return UIFont(name: Font.FType.regular, size: size.rawValue)!
    }
    
    public class func medium(_ size: Font.Size) -> UIFont {
        return UIFont(name: Font.FType.medium, size: size.rawValue)!
    }
    
    public class func semiBold(_ size: Font.Size) -> UIFont {
        return UIFont(name: Font.FType.semiBold, size: size.rawValue)!
    }
    
    public class func bold(_ size: Font.Size) -> UIFont {
        return UIFont(name: Font.FType.bold, size: size.rawValue)!
    }
    
    public class func extraBold(_ size: Font.Size) -> UIFont {
        return UIFont(name: Font.FType.extraBold, size: size.rawValue)!
    }
    
    // Computed property for extra light font with size 12
    public class var xs4ExtraLight: UIFont {
        return extraLight(.s12)
    }
    
    // Computed property for light font with size 12
    public class var xs4Light: UIFont {
        return light(.s12)
    }
    
    // Computed property for regular font with size 12
    public class var xs4Regular: UIFont {
        return regular(.s12)
    }
    
    // Computed property for medium font with size 12
    public class var xs4Medium: UIFont {
        return medium(.s12)
    }
    
    // Computed property for semi-bold font with size 12
    public class var xs4SemiBold: UIFont {
        return semiBold(.s12)
    }
    
    // Computed property for bold font with size 12
    public class var xs4Bold: UIFont {
        return bold(.s12)
    }
    
    // Computed property for extra-bold (heavy) font with size 12
    public class var xs4ExtraBold: UIFont {
        return extraBold(.s12)
    }
    
    // Computed property for extra light font with size 14
    public class var xs3ExtraLight: UIFont {
        return extraLight(.s14)
    }
    
    // Computed property for light font with size 14
    public class var xs3Light: UIFont {
        return light(.s14)
    }
    
    // Computed property for regular font with size 14
    public class var xs3Regular: UIFont {
        return regular(.s14)
    }
    
    // Computed property for medium font with size 14
    public class var xs3Medium: UIFont {
        return medium(.s14)
    }
    
    // Computed property for semi-bold font with size 14
    public class var xs3SemiBold: UIFont {
        return semiBold(.s14)
    }
    
    // Computed property for bold font with size 14
    public class var xs3Bold: UIFont {
        return bold(.s14)
    }
    
    // Computed property for extra-bold (heavy) font with size 14
    public class var xs3ExtraBold: UIFont {
        return extraBold(.s14)
    }
    
    // Computed property for extra light font with size 16
    public class var xs2ExtraLight: UIFont {
        return extraLight(.s16)
    }
    
    // Computed property for light font with size 16
    public class var xs2Light: UIFont {
        return light(.s16)
    }
    
    // Computed property for regular font with size 16
    public class var xs2Regular: UIFont {
        return regular(.s16)
    }
    
    // Computed property for medium font with size 16
    public class var xs2Medium: UIFont {
        return medium(.s16)
    }
    
    // Computed property for semi-bold font with size 16
    public class var xs2SemiBold: UIFont {
        return semiBold(.s16)
    }
    
    // Computed property for bold font with size 16
    public class var xs2Bold: UIFont {
        return bold(.s16)
    }
    
    // Computed property for extra-bold (heavy) font with size 16
    public class var xs2ExtraBold: UIFont {
        return extraBold(.s16)
    }
    
    // Computed property for extra light font with size 18
    public class var xsExtraLight: UIFont {
        return extraLight(.s18)
    }
    
    // Computed property for light font with size 18
    public class var xsLight: UIFont {
        return light(.s18)
    }
    
    // Computed property for regular font with size 18
    public class var xsRegular: UIFont {
        return regular(.s18)
    }
    
    // Computed property for medium font with size 18
    public class var xsMedium: UIFont {
        return medium(.s18)
    }
    
    // Computed property for semi-bold font with size 18
    public class var xsSemiBold: UIFont {
        return semiBold(.s18)
    }
    
    // Computed property for bold font with size 18
    public class var xsBold: UIFont {
        return bold(.s18)
    }
    
    // Computed property for extra-bold (heavy) font with size 18
    public class var xsExtraBold: UIFont {
        return extraBold(.s18)
    }
    
    // Computed property for extra light font with size 20
    public class var smExtraLight: UIFont {
        return extraLight(.s20)
    }
    
    // Computed property for light font with size 20
    public class var smLight: UIFont {
        return light(.s20)
    }
    
    // Computed property for regular font with size 20
    public class var smRegular: UIFont {
        return regular(.s20)
    }
    
    // Computed property for medium font with size 20
    public class var smMedium: UIFont {
        return medium(.s20)
    }
    
    // Computed property for semi-bold font with size 20
    public class var smSemiBold: UIFont {
        return semiBold(.s20)
    }
    
    // Computed property for bold font with size 20
    public class var smBold: UIFont {
        return bold(.s20)
    }
    
    // Computed property for extra-bold (heavy) font with size 20
    public class var smExtraBold: UIFont {
        return extraBold(.s20)
    }
    
    // Computed property for extra light font with size 24
    public class var mdExtraLight: UIFont {
        return extraLight(.s24)
    }
    
    // Computed property for light font with size 24
    public class var mdLight: UIFont {
        return light(.s24)
    }
    
    // Computed property for regular font with size 24
    public class var mdRegular: UIFont {
        return regular(.s24)
    }
    
    // Computed property for medium font with size 24
    public class var mdMedium: UIFont {
        return medium(.s24)
    }
    
    // Computed property for semi-bold font with size 24
    public class var mdSemiBold: UIFont {
        return semiBold(.s24)
    }
    
    // Computed property for bold font with size 24
    public class var mdBold: UIFont {
        return bold(.s24)
    }
    
    // Computed property for extra-bold (heavy) font with size 24
    public class var mdExtraBold: UIFont {
        return extraBold(.s24)
    }
    
    // Computed property for extra light font with size 32
    public class var lgExtraLight: UIFont {
        return extraLight(.s32)
    }
    
    // Computed property for light font with size 32
    public class var lgLight: UIFont {
        return light(.s32)
    }
    
    // Computed property for regular font with size 32
    public class var lgRegular: UIFont {
        return regular(.s32)
    }
    
    // Computed property for medium font with size 32
    public class var lgMedium: UIFont {
        return medium(.s32)
    }
    
    // Computed property for semi-bold font with size 32
    public class var lgSemiBold: UIFont {
        return semiBold(.s32)
    }
    
    // Computed property for bold font with size 32
    public class var lgBold: UIFont {
        return bold(.s32)
    }
    
    // Computed property for extra-bold (heavy) font with size 32
    public class var lgExtraBold: UIFont {
        return extraBold(.s32)
    }
    
    // Computed property for extra light font with size 40
    public class var xlExtraLight: UIFont {
        return extraLight(.s40)
    }
    
    // Computed property for light font with size 40
    public class var xlLight: UIFont {
        return light(.s40)
    }
    
    // Computed property for regular font with size 40
    public class var xlRegular: UIFont {
        return regular(.s40)
    }
    
    // Computed property for medium font with size 40
    public class var xlMedium: UIFont {
        return medium(.s40)
    }
    
    // Computed property for semi-bold font with size 40
    public class var xlSemiBold: UIFont {
        return semiBold(.s40)
    }
    
    // Computed property for bold font with size 40
    public class var xlBold: UIFont {
        return bold(.s40)
    }
    
    // Computed property for extra-bold (heavy) font with size 40
    public class var xlExtraBold: UIFont {
        return extraBold(.s40)
    }
    
    // Computed property for bold font with size 40
    public class var xl4Bold: UIFont {
        return bold(.s48)
    }
}
