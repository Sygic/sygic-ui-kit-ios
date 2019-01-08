import Foundation

public protocol SYUIFontSizeProtocol {
    var bodyOld: CGFloat { get }
    var body: CGFloat { get }
    var headingOld: CGFloat { get }
    var heading: CGFloat { get }
    var poiIcon: CGFloat { get }
    var buttonIcon: CGFloat { get }
    var buttonIconLarge: CGFloat { get }
}

// MARK: - Default values
public extension SYUIFontSizeProtocol {
    var bodyOld: CGFloat { return 14.0 }
    var body: CGFloat { return 16.0 }
    var headingOld: CGFloat { return 17.0 }
    var heading: CGFloat { return 20.0 }
    var poiIcon: CGFloat { return 18.0 }
    var buttonIcon: CGFloat { return 24.0 }
    var buttonIconLarge: CGFloat { return 32.0 }
}

public struct DefaultFontSize: SYUIFontSizeProtocol {
    public init() {}
}
