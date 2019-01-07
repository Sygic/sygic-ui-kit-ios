import Foundation

public class SYUIFontManager {
    public static let shared = SYUIFontManager()
    public var currentFontFamily: SYUIFontFamily = DefaultFontFamily()
    public var currentFontSize: SYUIFontSizeProtocol = DefaultFontSize()
    
    private init() {}
}
