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
    var bold: String? { get }
    var boldItalic: String? { get }
    var extraBold: String? { get }
    var extraBoldItalic: String? { get }
    var italic: String? { get }
    var light: String? { get }
    var lightItalic: String? { get }
    var regular: String? { get }
    var semiBold: String? { get }
    var semiBoldItalic: String? { get }
    var iconFont: String? { get }
}

// MARK: - Default values

public extension SYUIFontFamily {
    var bold: String? { nil }
    var boldItalic: String? { nil }
    var extraBold: String? { nil }
    var extraBoldItalic: String? { nil }
    var italic: String? { nil }
    var light: String? { nil }
    var lightItalic: String? { nil }
    var regular: String? { nil }
    var semiBold: String? { nil }
    var semiBoldItalic: String? { nil }
    var iconFont: String? { return "SYUISygicIcons" }
}

public struct DefaultFontFamily: SYUIFontFamily {
    public init() {
        guard let fontBundle = Bundle.fontBundle else { return }
        _ = UIFont.registerFont(bundle: fontBundle, fontName: self.iconFont!, fontExtension: "ttf")
    }
}

extension Bundle {
    static var fontBundle: Bundle? {
        return Bundle(for: SYUIFont.self)
    }
}
