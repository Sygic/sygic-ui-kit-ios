//// FadingHighlightedBackgroundView.swift
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


/// Fading highligted background.
internal class FadingHighlightedBackgroundView: UIView {
    
    // MARK: - Public Properties
    
    /// Value of higlighted color.
    public var highlightColor: UIColor?
    
    // MARK: - Public Methods
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// Shows highligted background.
    ///
    /// - Parameters:
    ///   - show: Boolean value, whether show highlight or not.
    ///   - animated: Boolean value, whether highlighting is animated or not.
    public func showHighlight(_ show: Bool, animated: Bool = true) {
        let color = show ? highlightColor : .clear
        if animated {
            UIView.animate(withDuration: SYUIConstants.highlightDuration) {
                self.backgroundColor = color
            }
        } else {
            backgroundColor = color
        }
    }
    
    /// Sets background color back to `UIColor.clear` value.
    public func reset() {
        backgroundColor = .clear
    }
}
