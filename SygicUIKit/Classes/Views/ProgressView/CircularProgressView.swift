//// CircularProgressView.swift
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

import CoreGraphics
import UIKit


public class CircularProgressView: UIView {
    
    // MARK: - Public Properties
    
    public let button = UIButton()
    
    public var progress: CGFloat? = nil {
        willSet {
            guard var newValue = newValue else { return }
            if !newValue.isLess(than: 1.0) {
                newValue = 1.0
            } else if newValue.isLess(than: 0.0) {
                newValue = 0.0
            }
        }
        
        didSet {
            setNeedsDisplay()
            progress == nil || progress == 0.0 ? startInfiniteAnimation() : stopInfiniteAnimation()
        }
    }
    
    public override var isHidden: Bool {
        didSet {
            setNeedsDisplay()
            progress == nil || progress == 0.0 ? startInfiniteAnimation() : stopInfiniteAnimation()
        }
    }
    
    // MARK: - Private Properties
    
    private let color = UIColor.action
    private let animationKey = "rotationAnimation"

    // MARK: - Public Methods
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    /// Hit test fails whether the view is hidden or point is outside its UIButton
    /// Should not be called outside of the view
    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let converted = convert(point, to: button)
        if converted.x >= 0 && !isHidden {
            return button
        }

        return super.hitTest(point, with: event)
    }
    
    /// Public override of draw and shouldn't be used outside of the view
    override public func draw(_ rect: CGRect) {
        let round = rect.insetBy(dx: 1, dy: 1)
        
        color.setStroke()
        color.setFill()
        
        if let progress = progress {
            let outerCircle = UIBezierPath(ovalIn: round)
            outerCircle.lineWidth = 1
            outerCircle.stroke()
            
            let inset = rect.size.width*0.33
            
            let innerRect = UIBezierPath(rect: rect.insetBy(dx: inset, dy: inset))
            innerRect.fill()
            
            let angle = -(CGFloat.pi/2) + progress * 2.0 * CGFloat.pi
            
            let outerProgress = UIBezierPath(arcCenter: CGPoint(x: rect.size.width/2, y: rect.size.height/2), radius: (round.size.height/2-1), startAngle: -(CGFloat.pi / 2), endAngle: angle, clockwise: true)
            outerProgress.lineWidth = 2
            outerProgress.stroke()
            
        } else {
            let angleStart = 2.0 * CGFloat.pi
            let angleEnd = angleStart - CGFloat.pi / 8.0
            
            let outerProgress = UIBezierPath(arcCenter: CGPoint(x: rect.size.width/2, y: rect.size.height/2), radius: (round.size.height/2-1), startAngle: angleStart, endAngle: angleEnd, clockwise: true)
            outerProgress.lineWidth = 1
            outerProgress.stroke()
        }
        
    }

    // MARK: - Private Methods

    private func setupUI() {
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        button.coverWholeSuperview(withMargin: -20)
    }

    private func startInfiniteAnimation() {
        if layer.animation(forKey: animationKey) != nil {
            return
        }

        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = Double.pi * 2.0
        rotationAnimation.duration = 1.0
        rotationAnimation.repeatCount = .greatestFiniteMagnitude

        layer.add(rotationAnimation, forKey: animationKey)
    }
    
    private func stopInfiniteAnimation() {
        guard layer.animation(forKey: animationKey) is CABasicAnimation else { return }
        layer.removeAnimation(forKey: animationKey)
    }
   
}
