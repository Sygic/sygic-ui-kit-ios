//// SYUICircleGradientProgressView.swift
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


/// Circular progress view with customizable dashed gradient layer
public class SYUICircleGradientProgressView: UIView {
    
    // MARK: - Public properties
    
    /// Length of one dash in progress (in points)
    public var dashLength: NSNumber = 5 {
        didSet {
            dashedBackground.lineDashPattern = dashPattern
            dashedBorder.lineDashPattern = dashPattern
        }
    }
    
    /// Length of space between dashes (in points)
    public var dashSpace: NSNumber = 2 {
        didSet {
            dashedBackground.lineDashPattern = dashPattern
            dashedBorder.lineDashPattern = dashPattern
        }
    }
    
    /// Width of progress dashes
    public var dashWidth: CGFloat = 5 {
        didSet {
            dashedBackground.lineWidth = dashWidth
            dashedBorder.lineWidth = dashWidth
        }
    }
    
    /// Cap type of dashes lines
    public var dashCap: CAShapeLayerLineCap = .butt {
        didSet {
            dashedBackground.lineCap = dashCap
            dashedBorder.lineCap = dashCap
        }
    }
    
    /// Progress value [0...1]
    public var progress: CGFloat = 0 {
        didSet {
            updateProgress()
        }
    }
    
    /// Offset sets size of the circle segment that is not drawn [0...1].
    /// 0 ... whole circle is drawn, 0.5 ... only upper half of circle is drawn
    public var progressOffset: CGFloat = 0 {
        didSet {
            updateProgressOffset()
        }
    }
    
    /// Gradient layer colors
    public var gradientColors: [CGColor] = [
        UIColor.green.cgColor,
        UIColor.green.cgColor,
        UIColor.green.cgColor,
        UIColor.orange.cgColor,
        UIColor.red.cgColor
        ] {
        didSet {
            gradient.colors = gradientColors
        }
    }
    
    public let dashedBackground = CAShapeLayer()
    public let dashedBorder = CAShapeLayer()
    public let gradient = CAGradientLayer()
    
    // MARK: - Private properties
    
    private var dashPattern: [NSNumber] {
        return [dashLength, dashSpace]
    }
    
    // MARK: - Public methods
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateLayers()
    }
    
    // MARK: - Private methods
    
    private func setup() {
        backgroundColor = .clear
        setupDashShapeLayer(dashedBackground)
        setupDashShapeLayer(dashedBorder)
        updateProgressOffset()
        setupGradientLayer()
        gradient.mask = dashedBorder
        layer.addSublayer(dashedBackground)
        layer.addSublayer(gradient)
    }
    
    private func setupDashShapeLayer(_ shapeLayer: CAShapeLayer) {
        shapeLayer.lineDashPattern = dashPattern
        shapeLayer.lineWidth = dashWidth
        shapeLayer.lineCap = dashCap
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.black.cgColor
        
        let rotatateTr = CATransform3DRotate(CATransform3DIdentity, .pi/2.0, 0, 0, 1)
        shapeLayer.transform = rotatateTr
    }
    
    private func setupGradientLayer() {
        if #available(iOS 12.0, *) {
            gradient.type = .conic
        }
        gradient.colors = gradientColors
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
    }
    
    private func updateDashShapeLayer(_ shapeLayer: CAShapeLayer, frame: CGRect, path: UIBezierPath) {
        shapeLayer.frame = frame
        shapeLayer.path = path.cgPath
    }
    
    private func updateProgress() {
        let roundProgress = CGFloat.minimum(CGFloat.maximum(progress, 0), 1)
        dashedBorder.strokeEnd = progressOffset/2.0 + roundProgress*(1-progressOffset)
    }
    
    private func updateProgressOffset() {
        let offset = progressOffset/2.0
        dashedBackground.strokeStart = offset
        dashedBorder.strokeStart = offset
        dashedBackground.strokeEnd = 1-offset
        dashedBorder.strokeEnd = 1-offset
        updateProgress()
    }
    
    private func updateLayers() {
        let ovalRect = CGRect(x: dashWidth/2, y: 0, width: bounds.size.width-dashWidth, height: bounds.size.height-dashWidth)
        let ovalPath = UIBezierPath(ovalIn: ovalRect)
        
        updateDashShapeLayer(dashedBackground, frame: ovalRect, path: ovalPath)
        updateDashShapeLayer(dashedBorder, frame: ovalRect, path: ovalPath)
        
        gradient.frame = bounds
    }
}
