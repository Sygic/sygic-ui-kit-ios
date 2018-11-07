import Foundation

public class FontManager {
    public static let shared = FontManager()
    public var currentFontFamily: FontFamily = DefaultFontFamily()
    public var currentFontSize: FontSize = DefaultFontSize()
}
