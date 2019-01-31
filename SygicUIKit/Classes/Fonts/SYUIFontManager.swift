import Foundation


/// Singleton manager for font handling.
public class SYUIFontManager {
    
    // MARK: - Public Properties
    
    /// Singleton.
    public static let shared = SYUIFontManager()
    
    /// Current using font family.
    public var currentFontFamily: SYUIFontFamily = DefaultFontFamily()
    
    /// Current using font size.
    public var currentFontSize: SYUIFontSizeProtocol = DefaultFontSize()
    
    // MARK: - Private Methods
    
    private init() {}
    
}
