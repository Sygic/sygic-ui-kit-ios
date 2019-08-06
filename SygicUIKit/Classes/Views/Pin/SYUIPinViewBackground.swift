//// SYUIPinViewBackground.swift
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
import QuartzCore


/// Class managing background of a pin.
class SYUIPinViewBackground: UIView {
    
    // MARK: - Public Properties

    /// Color of a pin
    public var pinColor: UIColor?
    {
        didSet {
            pinLabel.textColor = pinColor
            dropShadowLabel.textColor = pinColor
        }
    }
    
    // MARK: - Private Properties
    
    private var pinLabel: UILabel = UILabel()
    private var dropShadowLabel: UILabel = UILabel()
    
    // MARK: - Public Methods
    
    // MARK: Life cycle
    
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 80, height: 72))
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        pinLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        pinLabel.autoresizingMask = []
        pinLabel.text = SYUIIcon.pin
        pinLabel.textColor = .textBody
        pinLabel.backgroundColor = .clear
        pinLabel.textAlignment = .center
        pinLabel.numberOfLines = 1
        pinLabel.alpha = 1
        pinLabel.font = SYUIFont.with(.icon, size: bounds.height)
        addSubview(pinLabel)
        
        addShadow(color: .shadow)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Shadow creation
    
    /// Add shadow to a pin.
    ///
    /// - Parameter color: color of a shadow.
    public func addShadow(color: UIColor) {
        pinLabel.layer.shadowColor = color.cgColor
        pinLabel.layer.shadowOffset = CGSize(width: 0.1, height: 1.1)
        pinLabel.layer.shadowOpacity = 1.0
        pinLabel.layer.shadowRadius = 2
        pinLabel.layer.shouldRasterize = true
        pinLabel.layer.rasterizationScale = UIScreen.main.scale
        
        dropShadowLabel.frame = CGRect(x: 0, y: 18, width: bounds.width, height: bounds.height)
        dropShadowLabel.autoresizingMask = []
        dropShadowLabel.text = SYUIIcon.pin
        dropShadowLabel.textColor = .textBody
        dropShadowLabel.backgroundColor = .clear
        dropShadowLabel.textAlignment = .center
        dropShadowLabel.numberOfLines = 1
        dropShadowLabel.font = pinLabel.font
        
        dropShadowLabel.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        dropShadowLabel.layer.shadowColor = color.cgColor
        dropShadowLabel.layer.shadowOffset = CGSize(width: 0.1, height: 44)
        dropShadowLabel.layer.shadowOpacity = 1.0
        dropShadowLabel.layer.shadowRadius = 6
        dropShadowLabel.transform = CGAffineTransform(scaleX: 0.98, y: 0.5)
        dropShadowLabel.layer.shouldRasterize = true
        dropShadowLabel.layer.rasterizationScale = UIScreen.main.scale
        
        insertSubview(dropShadowLabel, belowSubview: pinLabel)
    }
    
}
