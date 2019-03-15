//// SYUIColorSchemeManager.swift
//
// Copyright (c) 2019 Sygic a.s.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

/**
    Protocol for updating colors for current color palette.
 
    Adapt this protocol in class, where you want to update your color based on color scheme.
    Then register ColorPaletteChangedNotification to setupColors method:
    ```
    NotificationCenter.default.addObserver(self, selector: #selector(setupColors), name: Notification.Name(ColorPaletteChangedNotification), object: nil)
    ```
*/
@objc public protocol SYUIColorUpdate {
    @objc func setupColors()
}

/// Available color schemes.
public enum ColorScheme {
    /// Color scheme for a day.
    case day
    /// Color scheme for a night.
    case night
}

/// Notification you need to observe for listening on change of color palette. So you can update UI.
public let ColorPaletteChangedNotification: String = "ColorPaletteChangedNotification"


/// Singleton. Handles color scheme switching between day and night color palletes.
public class SYUIColorSchemeManager {
    
    // MARK: - Public Properties

    public static let shared = SYUIColorSchemeManager()
    
    /// Color palette currently in use
    public var currentColorPalette: SYUIColorPalette = SYUIDefaultColorPalette() {
        didSet {
            NotificationCenter.default.post(name: Notification.Name(rawValue: ColorPaletteChangedNotification), object: currentColorPalette)
        }
    }
    
    /// Color scheme currently in use (default is day)
    public var currentColorScheme: ColorScheme = .day {
        didSet {
            if nightColorPalette == nil || dayColorPalette == nil {
                setColorPalettes(dayColorPalette: dayColorPalette, nightColorPalette: nightColorPalette)
            }
            guard let nightPalette = nightColorPalette, let dayPalette = dayColorPalette else { return }
            currentColorPalette = isNight ? nightPalette : dayPalette
        }
    }
    
    /// Multiplier for color adjustment for highlighted states
    public let brightnessMultiplier: (lighter: CGFloat, darker: CGFloat) = (lighter: 1.25, darker: 0.9)
    
    /// Returns alpha value for highlighted state on custom navigation bar items
    public let highlightedNavigationBarButtonAlpha: CGFloat = 0.3
    
    /// Returns if current color scheme is night
    public var isNight: Bool {
        return currentColorScheme == .night
    }
    
    // MARK: - Private Properties
    
    private var dayColorPalette: SYUIColorPalette?
    private var nightColorPalette: SYUIColorPalette?
    
    private init() {}
    
    // MARK: - Public Methods

    // MARK: Setting Day & Night palettes
    
    /// Set color palettes to default palattes, both day and night color palette.
    public func setDefaultColorPalettes() {
        setColorPalettes()
    }

    /// Set color palettes for day and night.
    ///
    /// - Parameters:
    ///   - dayColorPalette: color palette for a day.
    ///   - nightColorPalette: color palette for a night
    public func setColorPalettes(dayColorPalette: SYUIColorPalette? = SYUIDefaultColorPalette(), nightColorPalette: SYUIColorPalette? = SYUINightColorPalette()) {
        self.dayColorPalette = dayColorPalette
        self.nightColorPalette = nightColorPalette
        setNewColorScheme(currentColorScheme)
    }
    
    // MARK: Brightness
    
    /// Compares which color is ligther and returns correct brightness multiplier.
    ///
    /// - Parameters:
    ///   - backgroundColor: background color to compare.
    ///   - foregroundColor: foreground color to compare.
    /// - Returns: Multiplier for darker color if background is lighter and vice versa.
    public func brightnessMultiplier(for backgroundColor: UIColor, foregroundColor: UIColor) -> CGFloat {
        return backgroundColor.isLighter(than: foregroundColor) ? brightnessMultiplier.darker : brightnessMultiplier.lighter
    }
    
    // MARK: - Private Methods
    
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
