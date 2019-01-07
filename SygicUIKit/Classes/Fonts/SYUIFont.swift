import UIKit

public class SYUIFontSize {
    public static var body: CGFloat { return SYUIFontManager.shared.currentFontSize.body }
    public static var heading: CGFloat { return SYUIFontManager.shared.currentFontSize.heading }
    public static var poiIcon: CGFloat { return SYUIFontManager.shared.currentFontSize.poiIcon }
    public static var buttonIcon: CGFloat { return SYUIFontManager.shared.currentFontSize.buttonIcon }
    public static var buttonIconLarge: CGFloat { return SYUIFontManager.shared.currentFontSize.buttonIconLarge }
    
    // MARK: - Old font sizes, will be replaced setp by step in the future
    public static var headingOld: CGFloat { return SYUIFontManager.shared.currentFontSize.headingOld }
    public static var bodyOld: CGFloat { return SYUIFontManager.shared.currentFontSize.bodyOld }
}

public class SYUIFont {
    public static var bold: String { return SYUIFontManager.shared.currentFontFamily.bold }
    public static var boldItalic: String { return SYUIFontManager.shared.currentFontFamily.boldItalic }
    public static var extraBold: String { return SYUIFontManager.shared.currentFontFamily.extraBold }
    public static var extraBoldItalic: String { return SYUIFontManager.shared.currentFontFamily.extraBoldItalic }
    public static var italic: String { return SYUIFontManager.shared.currentFontFamily.italic }
    public static var light: String { return SYUIFontManager.shared.currentFontFamily.light }
    public static var lightItalic: String { return SYUIFontManager.shared.currentFontFamily.lightItalic }
    public static var regular: String { return SYUIFontManager.shared.currentFontFamily.regular }
    public static var semiBold: String { return SYUIFontManager.shared.currentFontFamily.semiBold }
    public static var semiBoldItalic: String { return SYUIFontManager.shared.currentFontFamily.semiBoldItalic }
    public static var iconFont: String { return SYUIFontManager.shared.currentFontFamily.iconFont }
    
    public static func with(_ name: String, size: CGFloat) -> UIFont? {
        return UIFont(name: name, size: CGFloat(size))
    }
    
    public static func iconFontWith(size: CGFloat) -> UIFont? {
        return SYUIFont.with(iconFont, size: size)
    }
}
