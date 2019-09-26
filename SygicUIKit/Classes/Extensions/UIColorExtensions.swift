//// UIColorExtensions.swift
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

import UIKit

public extension UIColor {
    
    /// Use for general views & cells background.
    static var background:       UIColor { return SYUIColorSchemeManager.shared.currentColorPalette.background }
    /// Use for launch screen and map's background
    static var mapBackground:    UIColor { return SYUIColorSchemeManager.shared.currentColorPalette.mapBackground }
    /// Use for UITableView background.
    static var tableBackground:  UIColor { return SYUIColorSchemeManager.shared.currentColorPalette.tableBackground }
    /// Use for texts on colorful (not white) background.
    static var textInvert:       UIColor { return SYUIColorSchemeManager.shared.currentColorPalette.textInvert }
    /// Use for bar background (UINavigationBar, UIToolbar)
    static var bar:              UIColor { return SYUIColorSchemeManager.shared.currentColorPalette.bar }
    /// Use for UITableView separator color, secondary actions, foreground color for views on `border` background (Search field in Search bar, SegmentedView in Navigation bar, etc.).
    static var border:           UIColor { return SYUIColorSchemeManager.shared.currentColorPalette.border }
    /// Use for general text color.
    static var textBody:         UIColor { return SYUIColorSchemeManager.shared.currentColorPalette.textBody }
    /// Use for main, highlighted text color (titles, emphasized texts)
    static var textTitle:        UIColor { return SYUIColorSchemeManager.shared.currentColorPalette.textTitle }
    /// Use for primary action views.
    static var action:           UIColor { return SYUIColorSchemeManager.shared.currentColorPalette.action }
    /// Use for error views, destruction actions.
    static var error:            UIColor { return SYUIColorSchemeManager.shared.currentColorPalette.error }
    /// Use for less warnings and less important errors.
    static var warning:          UIColor { return SYUIColorSchemeManager.shared.currentColorPalette.warning }
    /// Use for success information texts.
    static var success:          UIColor { return SYUIColorSchemeManager.shared.currentColorPalette.success }
    /// Use for rating views.
    static var rating:           UIColor { return SYUIColorSchemeManager.shared.currentColorPalette.rating }
    
    /// Use for texts on light background.
    static var textSign:           UIColor { return SYUIColorSchemeManager.shared.currentColorPalette.textSign }
    /// Use for icon background, map controls border.
    static var iconBackground:     UIColor { return SYUIColorSchemeManager.shared.currentColorPalette.iconBackground }
    /// Use for shadows.
    static var shadow:             UIColor { return SYUIColorSchemeManager.shared.currentColorPalette.shadow }
    /// Use for bar shadows (UINavigationBar, ...) and border shadows.
    static var barShadow:          UIColor { return SYUIColorSchemeManager.shared.currentColorPalette.barShadow }
    /// Use for action indicators and disclosure indicators in cells.
    static var actionIndicator:    UIColor { return SYUIColorSchemeManager.shared.currentColorPalette.actionIndicator }
    /// Use for background color for overlay views (Fancy modals, popups, ...).
    static var overlay:            UIColor { return SYUIColorSchemeManager.shared.currentColorPalette.overlay }
    /// Use for default blur color.
    static var mapInfoBackground:  UIColor { return SYUIColorSchemeManager.shared.currentColorPalette.mapInfoBackground }
    
    /// Use for secondary texts on colorful (not white) background.
    static var textInvertSecondary:  UIColor { return SYUIColorSchemeManager.shared.currentColorPalette.textInvertSecondary }
    /// Use for subtitle (less important) texts on colorful (not white) background.
    static var textInvertSubtitle:   UIColor { return SYUIColorSchemeManager.shared.currentColorPalette.textInvertSubtitle }
    
    /// Use for shadows for primary action views.
    static var actionShadow: UIColor { return SYUIColorSchemeManager.shared.currentColorPalette.actionShadow }
    static var errorShadow: UIColor { return SYUIColorSchemeManager.shared.currentColorPalette.errorShadow }

    // MARK: - POI group colors
    static var poiGroupTourism          : UIColor {  return SYUIColorSchemeManager.shared.currentColorPalette.poiGroupTourism }
    static var poiGroupFoodDrink        : UIColor {  return SYUIColorSchemeManager.shared.currentColorPalette.poiGroupFoodDrink }
    static var poiGroupAccomodation     : UIColor {  return SYUIColorSchemeManager.shared.currentColorPalette.poiGroupAccomodation }
    static var poiGroupParking          : UIColor {  return SYUIColorSchemeManager.shared.currentColorPalette.poiGroupParking }
    static var poiGroupPetrolStation    : UIColor {  return SYUIColorSchemeManager.shared.currentColorPalette.poiGroupPetrolStation }
    static var poiGroupTransportation   : UIColor {  return SYUIColorSchemeManager.shared.currentColorPalette.poiGroupTransportation }
    static var poiGroupBank             : UIColor {  return SYUIColorSchemeManager.shared.currentColorPalette.poiGroupBank }
    static var poiGroupShopping         : UIColor {  return SYUIColorSchemeManager.shared.currentColorPalette.poiGroupShopping }
    static var poiGroupVehicleServices  : UIColor {  return SYUIColorSchemeManager.shared.currentColorPalette.poiGroupVehicleServices }
    static var poiGroupSocialLife       : UIColor {  return SYUIColorSchemeManager.shared.currentColorPalette.poiGroupSocialLife }
    static var poiGroupSvcEducation     : UIColor {  return SYUIColorSchemeManager.shared.currentColorPalette.poiGroupSvcEducation }
    static var poiGroupSport            : UIColor {  return SYUIColorSchemeManager.shared.currentColorPalette.poiGroupSport }
    static var poiGroupGuides           : UIColor {  return SYUIColorSchemeManager.shared.currentColorPalette.poiGroupGuides }
    static var poiGroupEmergency        : UIColor {  return SYUIColorSchemeManager.shared.currentColorPalette.poiGroupEmergency }
    
    static var signpostDefaultBackground: UIColor {  return SYUIColorSchemeManager.shared.currentColorPalette.signpostDefaultBackground }
    
    static var accentPrimary: UIColor {  return SYUIColorSchemeManager.shared.currentColorPalette.accentPrimary }
    static var accentSecondary: UIColor {  return SYUIColorSchemeManager.shared.currentColorPalette.accentSecondary }
    static var accentBackground: UIColor {  return SYUIColorSchemeManager.shared.currentColorPalette.accentBackground }
    static var veryLightPink: UIColor {  return SYUIColorSchemeManager.shared.currentColorPalette.veryLightPink }
    
}

public extension UIColor {
    
    /// Initializes and returns UIColor object from HSL color space. All parameters should be in range <0,1>.
    convenience init(hue h: CGFloat, saturation s: CGFloat, lightness l: CGFloat, alpha a: CGFloat) {
        let h = max(0, min(1, h))
        let s = max(0, min(1, s))
        let l = max(0, min(1, l))
        let a = max(0, min(1, a))
        
        let m2 = l <= 0.5 ? l * (s + 1) : (l + s) - (l * s)
        let m1 = (l * 2) - m2
        
        let r = UIColor.hueToRGB(m1: m1, m2: m2, h: h + 1 / 3)
        let g = UIColor.hueToRGB(m1: m1, m2: m2, h: h)
        let b = UIColor.hueToRGB(m1: m1, m2: m2, h: h - 1 / 3)
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    /// Returns 1x1 point UIImage with given color.
    var image: UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /// Hue, saturation, lightness and alpha channels in <0,1>.
    var hsla: (hue: CGFloat, saturation: CGFloat, lightness: CGFloat, alpha: CGFloat)? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        guard getRed(&red, green: &green, blue: &blue, alpha: &alpha) else { return nil }
        
        let min = Swift.min(red, green, blue)
        let max = Swift.max(red, green, blue)
        
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        let lightness: CGFloat = (max + min) / 2.0
        
        let maxMinDiff = max - min
        if maxMinDiff != 0 {
            // we got saturated color -> color has also hue
            
            saturation = lightness < 0.5 ? maxMinDiff / (max + min) : maxMinDiff / (2 - max - min)
            
            switch max {
            case red:
                hue = (green - blue) / maxMinDiff
            case green:
                hue = 2 + (blue - red) / maxMinDiff
            case blue:
                hue = 4 + (red - green) / maxMinDiff
            default:
                break
            }
            
            hue /= 6 // normalize to <0,1>
        }
        
        return (hue, saturation, lightness, alpha)
    }
    
    /// Lightness parameter in HSL color space in range <0,1>. Nil if color couldn't be converted.
    var lightnessInHSL: CGFloat? {
        return hsla?.lightness
    }
    
    /// Returns a color with lighntess changed by the given amount. (HSL color space)
    /// - parameter amount: CGFloat between -1.0 and 1.0
    func adjustLightness(by amount: CGFloat) -> UIColor? {
        guard let hsla = hsla else { return nil }
        
        return UIColor(hue: hsla.hue, saturation: hsla.saturation, lightness: hsla.lightness + amount, alpha: hsla.alpha)
    }
    
    /// Returns `true` if `color` is lighter than receiver.
    func isLighter(than color: UIColor) -> Bool {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        var r2: CGFloat = 0
        var g2: CGFloat = 0
        var b2: CGFloat = 0
        var a2: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        return r+g+b > r2+g2+b2
    }
    
    /// Returns `true` if `color` is darker than receiver.
    func isDarker(than color: UIColor) -> Bool {
        return !isLighter(than: color)
    }
    
    /// Returns a color with brightness changed by the given multiplier. (HSB color space)
    /// - parameter multiplier: CGFloat greater than zero.
    func adjustBrightness(with multiplier: CGFloat) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            var saturationMultiplier: CGFloat = 1
            if multiplier > 1 && b == 1 {
                saturationMultiplier = 2-multiplier
            }
            return UIColor(hue: h, saturation: max(min(s*saturationMultiplier, 1), 0), brightness: max(min(b*multiplier, 1), 0), alpha: a)
        }
        return self
    }
    
    // MARK: - helpers
    
    private static func hueToRGB(m1: CGFloat, m2: CGFloat, h: CGFloat) -> CGFloat {
        let hue = (h.truncatingRemainder(dividingBy: 1) + 1).truncatingRemainder(dividingBy: 1)
        
        if hue * 6 < 1 {
            return m1 + (m2 - m1) * hue * 6
        }
        else if hue * 2 < 1 {
            return CGFloat(m2)
        }
        else if hue * 3 < 1.9999 {
            return m1 + (m2 - m1) * (2 / 3 - hue) * 6
        }
        
        return CGFloat(m1)
    }
}

public extension UIColor {
    convenience init(red: UInt32, green: UInt32, blue: UInt32, alpha: UInt32) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
    }
    
    convenience init(argb rgbaValue: UInt32) {
        self.init(red: (rgbaValue & 0xff0000) >> 16,
                  green: (rgbaValue & 0xff00) >> 8,
                  blue: rgbaValue & 0xff,
                  alpha: (rgbaValue & 0xff000000) >> 24)
    }
    
    convenience init?(fromHexString hexString: String) {
        if let hexValue = UInt32(String(hexString.suffix(6)), radix: 16) {
            self.init(argb: hexValue)
        }
        return nil
    }
    
    func color(withOffset colorOffset: CGFloat) -> UIColor {
        return color(withOffset: colorOffset, alpha: -1)
    }
    
    func color(withOffset colorOffset: CGFloat, alpha: CGFloat) -> UIColor {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var a: CGFloat = 0.0
        getRed(&red, green: &green, blue: &blue, alpha: &a)
        var newAlpha = alpha
        if newAlpha == -1 {
            newAlpha = a
        }
        return UIColor(red: red + colorOffset, green: green + colorOffset, blue: blue + colorOffset, alpha: newAlpha)
    }
    
    func color(withBrightnessMultiplier multiplier: CGFloat) -> UIColor? {
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            var saturationMultiplier: CGFloat = 1
            if multiplier > 1 && brightness == 1 {
                saturationMultiplier = 2 - multiplier
            }
            return UIColor(hue: hue, saturation: max(min(saturation * saturationMultiplier, 1.0), 0.0), brightness: max(min(brightness * multiplier, 1.0), 0.0), alpha: alpha)
        }
        return nil
    }
    
    func color(withBrightnessChange amount: CGFloat) -> UIColor? {
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            brightness += amount - 1.0
            brightness = max(min(brightness, 1.0), 0.0)
            return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
        }
        var white: CGFloat = 0.0
        if getWhite(&white, alpha: &alpha) {
            white += amount - 1.0
            white = max(min(white, 1.0), 0.0)
            return UIColor(white: white, alpha: alpha)
        }
        return nil
    }
    
    func inverseColor() -> UIColor {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: 1.0 - red, green: 1.0 - green, blue: 1.0 - blue, alpha: alpha)
    }
    
    func contrastingTextColor() -> UIColor {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let yiq: CGFloat = (((red * 255) * 299) + ((green * 255) * 587) + ((blue * 255) * 114)) / 1000
        return (yiq >= 128.0) ? .textTitle : .textInvert
    }
    
    func hexString() -> String? {
        guard let components = cgColor.components else { return nil }
        let red = CGFloat(components[0])
        let green = CGFloat(components[1])
        let blue = CGFloat(components[2])
        return String(format: "#%02lX%02lX%02lX", Float(red * 255).rounded(), Float(green * 255).rounded(), Float(blue * 255).rounded())
    }
}
