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
}
