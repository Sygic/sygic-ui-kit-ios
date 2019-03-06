//// UIViewExtensions+Blur.swift
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

public extension UIView {
    
    @discardableResult public func blur(with color: UIColor?, style: UIBlurEffect.Style, margin: CGFloat = 0.0) -> UIVisualEffectView {
        let effectView = blurEffectView(with: style)
        if let color = color, color != .clear {
            let colorOverlay = colorOverlayView(with: color)
            effectView.contentView.addSubview(colorOverlay)
            colorOverlay.coverWholeSuperview()
        }
        addSubview(effectView)
        sendSubviewToBack(effectView)
        effectView.coverWholeSuperview(withMargin: margin)
        return effectView
    }
    
    public func addBlurViewWithMapControlsBlurStyle(margin: CGFloat = 0.0) -> UIVisualEffectView? {
        let effectView = blur(with: nil, style: .light, margin: margin)
        let colorOverlayView = self.colorOverlayView(with: .mapInfoBackground)
        colorOverlayView.backgroundColor = .mapInfoBackground
        effectView.contentView.addSubview(colorOverlayView)
        colorOverlayView.coverWholeSuperview()
        return effectView
    }
    
// MARK: Private
    private func blurEffectView(with style: UIBlurEffect.Style) -> UIVisualEffectView {
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: style))
        effectView.translatesAutoresizingMaskIntoConstraints = false
        effectView.contentView.layer.cornerRadius = layer.cornerRadius
        effectView.layer.cornerRadius = layer.cornerRadius
        effectView.clipsToBounds = true
        effectView.isUserInteractionEnabled = false
        return effectView
    }
    private func colorOverlayView(with color: UIColor) -> UIView {
        let transparentView = UIView()
        transparentView.translatesAutoresizingMaskIntoConstraints = false
        transparentView.layer.cornerRadius = layer.cornerRadius
        transparentView.backgroundColor = color
        transparentView.isUserInteractionEnabled = false
        return transparentView
    }
}

