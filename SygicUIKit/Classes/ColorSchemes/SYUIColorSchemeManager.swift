import Foundation

@objc public protocol SYUIColorUpdate {
    @objc func setupColors()
}

public enum ColorScheme {
    case day
    case night
}

public let ColorPaletteChangedNotification: String = "ColorPaletteChangedNotification"

public class SYUIColorSchemeManager {

    public static let shared = SYUIColorSchemeManager()
    
    public var currentColorPalette: SYUIColorPalette = SYUIDefaultColorPalette() {
        didSet {
            NotificationCenter.default.post(name: Notification.Name(rawValue: ColorPaletteChangedNotification), object: currentColorPalette)
        }
    }
    
    public var currentColorScheme: ColorScheme = .day {
        didSet {
            currentColorPalette = isNight ? nightColorPalette! : dayColorPalette!
        }
    }
    
    public let brightnessMultiplier: (lighter: CGFloat, darker: CGFloat) = (lighter: 1.25, darker: 0.9)
    public let highlightedNavigationBarButtonAlpha: CGFloat = 0.3
    public var isNight: Bool {
        return currentColorScheme == .night
    }
    
    private var dayColorPalette: SYUIColorPalette?
    private var nightColorPalette: SYUIColorPalette?

    // MARK: - Setting Day & Night palettes
    
    public func setDefaultColorPalettes(dayColorPalette: SYUIColorPalette? = SYUIDefaultColorPalette(), nightColorPalette: SYUIColorPalette? = SYUINightColorPalette()) {
        self.dayColorPalette = dayColorPalette
        self.nightColorPalette = nightColorPalette
        
        setNewColorScheme(currentColorScheme)
    }
    
    // MARK: - Brightness
    
    public func brightnessMultiplier(for backgroundColor: UIColor, foregroundColor: UIColor) -> CGFloat {
        return backgroundColor.isLighter(than: foregroundColor) ? brightnessMultiplier.darker : brightnessMultiplier.lighter
    }
    
    // MARK: Setting new scheme
    
    private func setNewColorScheme(_ colorScheme: ColorScheme) {
        setCurrentColorPalette(for: colorScheme)
        
        if colorScheme != currentColorScheme {
            currentColorScheme = colorScheme
        }
    }
    
    private func setCurrentColorPalette(for colorScheme: ColorScheme) {
        if colorScheme == .day, let newColorPalette = dayColorPalette {
            currentColorPalette = newColorPalette
        } else if colorScheme == .night, let newColorPalette = nightColorPalette {
            currentColorPalette = newColorPalette
        }
    }
}
