//// UITableViewCellExtensions.swift
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

// MARK: - Highlighting

public extension UITableViewCell {
    
    internal var highlightingView: FadingHighlightedBackgroundView? {
        for subview in subviews {
            if let highView = subview as? FadingHighlightedBackgroundView {
                return highView
            }
        }
        return nil
    }
    
    func setupHighlightingView() {
        selectedBackgroundView = UIView()
        
        let highlightedView = FadingHighlightedBackgroundView(frame: .zero)
        highlightedView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(highlightedView)
        sendSubviewToBack(highlightedView)
        highlightedView.coverWholeSuperview()
    }
    
    func highlightCell(_ highlighted: Bool, backgroundColor: UIColor?, foregroundColor: UIColor?) {
        guard let backgroundColor = backgroundColor, let foregroundColor = foregroundColor, let highlightingView = highlightingView else { return }
        let multiplier = SYUIColorSchemeManager.shared.brightnessMultiplier(for: backgroundColor, foregroundColor: foregroundColor)
        highlightingView.highlightColor = backgroundColor.adjustBrightness(with: multiplier)
        highlightingView.showHighlight(highlighted)
    }
}
