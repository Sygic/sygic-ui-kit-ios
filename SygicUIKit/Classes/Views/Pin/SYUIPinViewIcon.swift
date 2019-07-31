//// SYUIPinViewIcon.swift
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


/// View class that manages pin icon.
class SYUIPinViewIcon: UIView {
    
    // MARK: - Public Properties
    
    /// Font string value of an icon.
    public var icon: String? {
        didSet {
            iconLabel.text = icon
            iconLabel.font = SYUIFont.with(.icon, size: SYUIFontSize.poiIcon)
        }
    }
    
    /// Color of an icon.
    public var iconColor: UIColor? {
        didSet {
            if isSelected {
                iconLabel.textColor = iconColor
                backgroundColor = .textInvert
            }
            else {
                iconLabel.textColor = .textInvert
                backgroundColor = iconColor
            }
        }
    }
    
    /// Boolean value whether pin icon is selected or not.
    public var isSelected: Bool {
        set {
            if newValue {
                backgroundColor = .textInvert
                iconLabel.textColor = iconColor
            }
            else {
                backgroundColor = iconColor
                iconLabel.textColor = .textInvert
            }
        }
        get { return iconLabel.textColor == iconColor }
    }
    
    /// Boolean value whether icon sould show shadow or not.
    public var shouldShowShadow: Bool {
        set { layer.shadowOpacity = newValue ? 1 : 0 }
        get { return layer.shadowOpacity > 0 }
    }
    
    public var iconLabel: UILabel = UILabel()
    
    // MARK: - Public Methods
    
    // MARK: Life cycle
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .textInvert
        clipsToBounds = false
        layer.cornerRadius = bounds.width/2
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        setupShadow(with: 8)

        iconLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        iconLabel.autoresizingMask = []
        iconLabel.backgroundColor = .clear
        iconLabel.textColor = .textBody
        iconLabel.textAlignment = .center
        iconLabel.numberOfLines = 1
        addSubview(iconLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
