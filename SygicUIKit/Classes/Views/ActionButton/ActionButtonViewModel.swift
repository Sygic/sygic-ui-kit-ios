import Foundation

public struct ActionButtonViewModel: SYUIActionButtonProperties {
    public var title: String?
    public var subtitle: String?
    public var icon: String?
    public var style: SYUIActionButtonStyle
    public var height: CGFloat
    public var titleSize: CGFloat?
    public var subtitleSize: CGFloat?
    public var iconSize: CGFloat
    public var iconAlignment: NSTextAlignment
    public var isEnabled: Bool
    public var countdown: TimeInterval?
    public var accessibilityIdentifier: String?
    
    public init(title: String? = nil,
                subtitle: String? = nil,
                icon: String? = nil,
                style: SYUIActionButtonStyle = .primary,
                height: CGFloat = SYUIActionButtonSize.normal.height,
                titleSize: CGFloat? = nil,
                subtitleSize: CGFloat? = nil,
                iconSize: CGFloat = 24.0,
                iconAlignment: NSTextAlignment = .right,
                accessibilityIdentifier: String? = nil,
                isEnabled: Bool = true,
                countdown: TimeInterval? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.style = style
        self.height = height
        self.titleSize = titleSize
        self.subtitleSize = subtitleSize
        self.iconSize = iconSize
        self.iconAlignment = iconAlignment
        self.isEnabled = isEnabled
        self.countdown = countdown
        self.accessibilityIdentifier = accessibilityIdentifier
    }
}
