import Foundation

public struct SYUIActionButtonViewModel: SYUIActionButtonProperties {
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
    
    public init(with properties: SYUIActionButtonProperties) {
        self.title = properties.title
        self.subtitle = properties.subtitle
        self.icon = properties.icon
        self.style = properties.style
        self.height = properties.height
        self.titleSize = properties.titleSize
        self.subtitleSize = properties.subtitleSize
        self.iconSize = properties.iconSize
        self.iconAlignment = properties.iconAlignment
        self.isEnabled = properties.isEnabled
        self.countdown = properties.countdown
        self.accessibilityIdentifier = properties.accessibilityIdentifier
    }
}
