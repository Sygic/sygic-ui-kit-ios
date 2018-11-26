import Foundation

public protocol FontFamily {
    var bold: String { get }
    var boldItalic: String { get }
    var extraBold: String { get }
    var extraBoldItalic: String { get }
    var italic: String { get }
    var light: String { get }
    var lightItalic: String { get }
    var regular: String { get }
    var semiBold: String { get }
    var semiBoldItalic: String { get }
    var iconFont: String { get }
}

// MARK: - Default values
public extension FontFamily {
    var bold: String { return "InterUI-Bold" }
    var boldItalic: String { return "InterUI-BoldItalic" }
    var extraBold: String { return "InterUI-Black" }
    var extraBoldItalic: String { return "InterUI-BlackItalic" }
    var italic: String { return "InterUI-Italic" }
    var light: String { fatalError("Not implemented font") }
    var lightItalic: String { fatalError("Not implemented font") }
    var regular: String { return "InterUI-Regular" }
    var semiBold: String { return "InterUI-Medium" }
    var semiBoldItalic: String { return "InterUI-MediumItalic" }
    var iconFont: String { return "SygicIcons" }
}

public struct DefaultFontFamily: FontFamily {
    public init() {
        guard let fontBundle = Bundle.fontBundle else { return }
        _ = UIFont.registerFont(bundle: fontBundle, fontName: self.bold, fontExtension: "ttf")
        _ = UIFont.registerFont(bundle: fontBundle, fontName: self.boldItalic, fontExtension: "ttf")
        _ = UIFont.registerFont(bundle: fontBundle, fontName: self.extraBold, fontExtension: "ttf")
        _ = UIFont.registerFont(bundle: fontBundle, fontName: self.extraBoldItalic, fontExtension: "ttf")
        _ = UIFont.registerFont(bundle: fontBundle, fontName: self.italic, fontExtension: "ttf")
        _ = UIFont.registerFont(bundle: fontBundle, fontName: self.regular, fontExtension: "ttf")
        _ = UIFont.registerFont(bundle: fontBundle, fontName: self.semiBold, fontExtension: "ttf")
        _ = UIFont.registerFont(bundle: fontBundle, fontName: self.semiBoldItalic, fontExtension: "ttf")
        _ = UIFont.registerFont(bundle: fontBundle, fontName: self.iconFont, fontExtension: "ttf")
    }
}

extension Bundle {
    static var fontBundle: Bundle? {
        let podBundle = Bundle(for: SygicFonts.self)
        if let resourcesBundleUrl = podBundle.url(forResource: "SygicUIKit", withExtension: "bundle") {
            return Bundle(url: resourcesBundleUrl)
        }
        return nil
    }
}
