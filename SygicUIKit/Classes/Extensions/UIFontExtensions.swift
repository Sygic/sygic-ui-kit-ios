import UIKit


public extension UIFont {
    
    public var monospacedDigitFont: UIFont {
        let fontDescriptorAttributes = [UIFontDescriptor.AttributeName.featureSettings: [[UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType,
                                                                                          UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector]]]
        return UIFont(descriptor: fontDescriptor.addingAttributes(fontDescriptorAttributes), size: 0)
    }
    
    public static func scaleFactor(for fontSize: CGFloat, minimalDesiredFontSize: CGFloat) -> CGFloat {
        return minimalDesiredFontSize / fontSize
    }
    
    static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) -> Bool {
        for oldFontFamily in UIFont.familyNames {
            for oldFontName in UIFont.fontNames(forFamilyName: oldFontFamily) {
                if oldFontName == fontName {
                    // font already registerd
                    return true
                }
            }
        }
        
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension) else {
            fatalError("Couldn't find font \(fontName)")
        }
        
        guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL) else {
            fatalError("Couldn't load data from the font \(fontName)")
        }
        
        guard let font = CGFont(fontDataProvider) else {
            fatalError("Couldn't create font from data")
        }
        
        var error: Unmanaged<CFError>?
        let success = CTFontManagerRegisterGraphicsFont(font, &error)
        guard success else {
            print("Error registering font: maybe it was already registered.")
            return false
        }
        
        return true
    }
    
}
