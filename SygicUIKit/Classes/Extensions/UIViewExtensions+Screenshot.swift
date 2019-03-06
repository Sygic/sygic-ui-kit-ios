//// UIViewExtensions+Screenshot.swift
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
    // MARK: - UIImageView creation
    class func grabScreenshot(for view: UIView, withTag tag: Int) -> UIImageView? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0.0)
        let context = UIGraphicsGetCurrentContext()
        let viewLayer = view.layer
        if let context = context {
            viewLayer.render(in: context)
        }
        let capturedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let imageViewOverlay = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: capturedImage?.size.width ?? 0.0, height: capturedImage?.size.height ?? 0.0))
        imageViewOverlay.image = capturedImage
        imageViewOverlay.tag = tag
        return imageViewOverlay
    }
    
    func grabScreenshot(for view: UIView?, withTag tag: Int) -> UIImageView {
        let rect: CGRect
        let viewLayer: CALayer
        if let view = view {
            rect = view.bounds
            viewLayer = view.layer
        } else {
            rect = bounds
            viewLayer = layer
        }
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0.0)
        let context = UIGraphicsGetCurrentContext()
        if let aContext = context {
            viewLayer.render(in: aContext)
        }
        let capturedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let imageViewOverlay = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: capturedImage?.size.width ?? 0.0, height: capturedImage?.size.height ?? 0.0))
        imageViewOverlay.image = capturedImage
        imageViewOverlay.tag = tag
        return imageViewOverlay
    }
    
    // MARK: - UIImage creation
    func imageFromLayer() -> UIImage? {
        return imageFromLayer(with: .zero)
    }
    
    func imageFromLayer(with insets: UIEdgeInsets) -> UIImage? {
        var contextSize: CGSize = bounds.size
        contextSize.width -= insets.left + insets.right
        contextSize.height -= insets.top + insets.bottom
        UIGraphicsBeginImageContextWithOptions(contextSize, false, 0)
        if let ctx = UIGraphicsGetCurrentContext() {
            ctx.translateBy(x: -insets.left, y: -insets.top)
            layer.render(in: ctx)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    @objc func imageFromView() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        if let aContext = UIGraphicsGetCurrentContext() {
            layer.render(in: aContext)
        }
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
