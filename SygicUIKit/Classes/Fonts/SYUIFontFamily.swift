//// SYUIFontFamily.swift
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


/// Font family protocol for define Font.
public protocol SYUIFontFamily {
    var bold: String { get }
    var boldItalic: String { get }
    var extraBold: String { get }
    var extraBoldItalic: String { get }
    var italic: String { get }
    var light: String { get }
    var lightItalic: String { get }
    var regular: String { get }
    var semiBold: String { get }
    var semiBoldItalic: String { get }
    var iconFont: String { get }
}

// MARK: - Default values

public extension SYUIFontFamily {
    var bold: String { return "InterUI-Bold" }
    var boldItalic: String { return "InterUI-BoldItalic" }
    var extraBold: String { return "InterUI-Black" }
    var extraBoldItalic: String { return "InterUI-BlackItalic" }
    var italic: String { return "InterUI-Italic" }
    var light: String { fatalError("Not implemented font") }
    var lightItalic: String { fatalError("Not implemented font") }
    var regular: String { return "InterUI-Regular" }
    var semiBold: String { return "InterUI-Medium" }
    var semiBoldItalic: String { return "InterUI-MediumItalic" }
    var iconFont: String { return "SYUISygicIcons" }
}

public struct DefaultFontFamily: SYUIFontFamily {
    public init() {
        guard let fontBundle = Bundle.fontBundle else { return }
        _ = UIFont.registerFont(bundle: fontBundle, fontName: self.bold, fontExtension: "ttf")
        _ = UIFont.registerFont(bundle: fontBundle, fontName: self.boldItalic, fontExtension: "ttf")
        _ = UIFont.registerFont(bundle: fontBundle, fontName: self.extraBold, fontExtension: "ttf")
        _ = UIFont.registerFont(bundle: fontBundle, fontName: self.extraBoldItalic, fontExtension: "ttf")
        _ = UIFont.registerFont(bundle: fontBundle, fontName: self.italic, fontExtension: "ttf")
        _ = UIFont.registerFont(bundle: fontBundle, fontName: self.regular, fontExtension: "ttf")
        _ = UIFont.registerFont(bundle: fontBundle, fontName: self.semiBold, fontExtension: "ttf")
        _ = UIFont.registerFont(bundle: fontBundle, fontName: self.semiBoldItalic, fontExtension: "ttf")
        _ = UIFont.registerFont(bundle: fontBundle, fontName: self.iconFont, fontExtension: "ttf")
    }
}

extension Bundle {
    static var fontBundle: Bundle? {
        let podBundle = Bundle(for: SYUIFont.self)
        if let resourcesBundleUrl = podBundle.url(forResource: "SygicUIKit", withExtension: "bundle") {
            return Bundle(url: resourcesBundleUrl)
        }
        return nil
    }
}
