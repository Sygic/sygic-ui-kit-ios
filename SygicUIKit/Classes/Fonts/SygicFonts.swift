import UIKit

public class SygicFontSize: NSObject {
    public static var body: CGFloat { return FontManager.shared.currentFontSize.body }
    public static var heading: CGFloat { return FontManager.shared.currentFontSize.heading }
    public static var poiIcon: CGFloat { return FontManager.shared.currentFontSize.poiIcon }
    public static var buttonIcon: CGFloat { return FontManager.shared.currentFontSize.buttonIcon }
    public static var buttonIconLarge: CGFloat { return FontManager.shared.currentFontSize.buttonIconLarge }
    
    // MARK: - Old font sizes, will be replaced setp by step in the future
    public static var headingOld: CGFloat { return FontManager.shared.currentFontSize.headingOld }
    public static var bodyOld: CGFloat { return FontManager.shared.currentFontSize.bodyOld }
}

@objc public class SygicFonts: NSObject {
    public static var bold: String { return FontManager.shared.currentFontFamily.bold }
    public static var boldItalic: String { return FontManager.shared.currentFontFamily.boldItalic }
    public static var extraBold: String { return FontManager.shared.currentFontFamily.extraBold }
    public static var extraBoldItalic: String { return FontManager.shared.currentFontFamily.extraBoldItalic }
    public static var italic: String { return FontManager.shared.currentFontFamily.italic }
    public static var light: String { return FontManager.shared.currentFontFamily.light }
    public static var lightItalic: String { return FontManager.shared.currentFontFamily.lightItalic }
    public static var regular: String { return FontManager.shared.currentFontFamily.regular }
    public static var semiBold: String { return FontManager.shared.currentFontFamily.semiBold }
    public static var semiBoldItalic: String { return FontManager.shared.currentFontFamily.semiBoldItalic }
    public static var iconFont: String { return FontManager.shared.currentFontFamily.iconFont }
    
    public static func with(_ name: String, size: CGFloat) -> UIFont? {
        return UIFont(name: name, size: CGFloat(size))
    }
    
    public static func iconFontWith(size: CGFloat) -> UIFont? {
        return SygicFonts.with(iconFont, size: size)
    }
}
