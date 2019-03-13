//// SYUIFont.swift
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

public class SYUIFontSize {
    public static var body: CGFloat { return SYUIFontManager.shared.currentFontSize.body }
    public static var heading: CGFloat { return SYUIFontManager.shared.currentFontSize.heading }
    public static var poiIcon: CGFloat { return SYUIFontManager.shared.currentFontSize.poiIcon }
    public static var buttonIcon: CGFloat { return SYUIFontManager.shared.currentFontSize.buttonIcon }
    public static var buttonIconLarge: CGFloat { return SYUIFontManager.shared.currentFontSize.buttonIconLarge }
    
    // MARK: - Old font sizes, will be replaced setp by step in the future
    public static var headingOld: CGFloat { return SYUIFontManager.shared.currentFontSize.headingOld }
    public static var bodyOld: CGFloat { return SYUIFontManager.shared.currentFontSize.bodyOld }
}

public class SYUIFont {
    public static var bold: String { return SYUIFontManager.shared.currentFontFamily.bold }
    public static var boldItalic: String { return SYUIFontManager.shared.currentFontFamily.boldItalic }
    public static var extraBold: String { return SYUIFontManager.shared.currentFontFamily.extraBold }
    public static var extraBoldItalic: String { return SYUIFontManager.shared.currentFontFamily.extraBoldItalic }
    public static var italic: String { return SYUIFontManager.shared.currentFontFamily.italic }
    public static var light: String { return SYUIFontManager.shared.currentFontFamily.light }
    public static var lightItalic: String { return SYUIFontManager.shared.currentFontFamily.lightItalic }
    public static var regular: String { return SYUIFontManager.shared.currentFontFamily.regular }
    public static var semiBold: String { return SYUIFontManager.shared.currentFontFamily.semiBold }
    public static var semiBoldItalic: String { return SYUIFontManager.shared.currentFontFamily.semiBoldItalic }
    public static var iconFont: String { return SYUIFontManager.shared.currentFontFamily.iconFont }
    
    public static func with(_ name: String, size: CGFloat) -> UIFont? {
        return UIFont(name: name, size: CGFloat(size))
    }
    
    public static func iconFontWith(size: CGFloat) -> UIFont? {
        return SYUIFont.with(iconFont, size: size)
    }
}
