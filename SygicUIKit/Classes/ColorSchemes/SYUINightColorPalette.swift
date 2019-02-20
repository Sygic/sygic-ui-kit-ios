import Foundation

/// Night color palette. Scheme manager using this palette as default palette for night.
public struct SYUINightColorPalette: SYUIColorPalette {

    public init() {}
    
    public var background:      UIColor { return SYUIDefaultColorPalette().textTitle }
    public var tableBackground: UIColor { return UIColor(argb: 0xff242933) }
    public var textInvert:      UIColor { return UIColor(argb: 0xffe1e7f2) }
    public var bar:             UIColor { return UIColor(argb: 0xff2d3340) }
    public var border:          UIColor { return UIColor(argb: 0xff3d424d) }
    public var textBody:        UIColor { return UIColor(argb: 0xff9da4b3) }
    public var textTitle:       UIColor { return UIColor(argb: 0xffe1e7f2) }
    public var action:          UIColor { return UIColor(argb: 0xff3687d9) }
    public var error:           UIColor { return UIColor(argb: 0xffbf3939) }
    public var warning:         UIColor { return UIColor(argb: 0xffd98736) }
    public var success:         UIColor { return UIColor(argb: 0xff5c993d) }
    public var rating:          UIColor { return UIColor(argb: 0xffa6874b) }
    
    public var textSign:           UIColor { return SYUIDefaultColorPalette().textSign }
    public var mapInfoBackground:  UIColor { return SYUIDefaultColorPalette().mapInfoBackground }
    public var barShadow:          UIColor { return SYUIDefaultColorPalette().textTitle.withAlphaComponent(0.5) }
    public var overlay:            UIColor { return textTitle.withAlphaComponent(0.1) }
    
    public var actionShadow:    UIColor { return background.withAlphaComponent(0.5) }
    public var shadow:          UIColor { return background.withAlphaComponent(0.5) }
    public var errorShadow:     UIColor { return background.withAlphaComponent(0.5) }
}
