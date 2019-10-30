//// SYUIFontSize.swift
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
    var bodyOld: CGFloat { return 13.0 }
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
