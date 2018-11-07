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
    public init() {}
}
