//// SYUIGradientView.swift
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


public class SYUIGradientView: UIView {
    
    /// An optional array of NSNumber objects defining the location of each
    /// gradient stop as a value in the range [0,1]. The values must be
    /// gradient stop as a value in the range [0,1]. The values must be
    /// assumed to spread uniformly across the [0,1] range. When rendered,
    /// assumed to spread uniformly across the [0,1] range. When rendered,
    /// interpolated. Defaults to nil. Animatable.
    public var locations: [NSNumber]? {
        didSet {
            gradientLayer.locations = locations
        }
    }
    
    /// The array of CGColorRef objects defining the color of each gradient
    /// stop. Defaults to nil. Animatable.
    public var colors = [UIColor]() {
        didSet {
            gradientLayer.colors = colors.map { $0.cgColor }
        }
    }
    
    public let gradientLayer = CAGradientLayer()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(gradientLayer)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
