//// InfiniteCountdownActivityIndicator.swift
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


private typealias floatfloatBlock = (_: CGFloat) -> CGFloat
private typealias floatColorBlock = (_: CGFloat) -> UIColor

public class InfiniteCountdownActivityIndicator: UIView {
    
    // MARK: - Public Properties
    
    /// Color of a circle.
    public var color: UIColor? {
        didSet {
            if let color = color {
                countdownLabel.textColor = color
            }
            circleImageView?.image = circleImage(with: bounds.size)
        }
    }
    
    /// Width of a circle.
    public var circleWidth: CGFloat = 0.0
    
    override public var isHidden: Bool {
        didSet {
            if isHidden {
                stopAnimating()
            } else {
                startAnimating()
            }
        }
    }
    
    // MARK: - Private Properties
    
    private var circleSubdivCount: Int = 0
    private var circleImageView: UIImageView?
    private var countdownLabel = UILabel()
    private let ActivityIndicatorAnimationKey = "rotationAnimation"
    private let ActivityIndicatorDurationPerTurn: TimeInterval = 1.0
    
    // MARK: - Public Methods
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        initDefaultLayout()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initDefaultLayout()
        
    }
    
    override public func layoutSubviews() {
        if !frame.size.equalTo(CGSize.zero) {
            circleImageView?.image = circleImage(with: bounds.size)
            if !isHidden {
                startAnimating()
            }
        }
        super.layoutSubviews()
    }
    
    override public func draw(_ rect: CGRect) {
        #if !TARGET_INTERFACE_BUILDER
        if circleImageView?.image == nil {
            circleImageView?.image = circleImage(with: CGSize(width: rect.size.width, height: rect.size.height))
        }
        #else
        renderCircleImage(to: rect)
        #endif
    }
    
    /// Update countdown text of a label.
    ///
    /// - Parameter secondsRemaining: countdown seconds remaining.
    public func updateCountdown(_ secondsRemaining: Int) {
        countdownLabel.text = "\(secondsRemaining)"
    }
    
    // MARK: - Private Methods
    
    private func initDefaultLayout() {
        backgroundColor = UIColor.clear
        color = .textInvert
        circleWidth = 2
        circleSubdivCount = 360
        initCircleImageViewHolder()
        initCountdownLabel()
    }
    
    private func initCircleImageViewHolder() {
        let tmpImageView = UIImageView()
        tmpImageView.translatesAutoresizingMaskIntoConstraints = false
        tmpImageView.backgroundColor = UIColor.clear
        tmpImageView.contentMode = .scaleAspectFit
        circleImageView = tmpImageView
        addSubview(tmpImageView)
        tmpImageView.coverWholeSuperview()
    }
    
    private func initCountdownLabel() {
        countdownLabel.translatesAutoresizingMaskIntoConstraints = false
        countdownLabel.font = SYUIFont.with(.semiBold, size: SYUIFontSize.headingOld)
        countdownLabel.textAlignment = .center
        countdownLabel.textColor = color
        countdownLabel.minimumScaleFactor = 0.5
        countdownLabel.adjustsFontSizeToFitWidth = true
        countdownLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        addSubview(countdownLabel)
        countdownLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        countdownLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        let leadingAnchor = countdownLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 3.0)
        leadingAnchor.priority = UILayoutPriority(rawValue: 600)
        leadingAnchor.isActive = true
        let trailingAnchor = countdownLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -3.0)
        trailingAnchor.priority = UILayoutPriority(rawValue: 600)
        trailingAnchor.isActive = true
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=0)-[countdownLabel]-(>=0)-|", options: [], metrics: nil, views: ["countdownLabel": countdownLabel]))
    }
    
    // MARK: Circle drawing
    private func pointForTrapezoid(withAngle a: CGFloat, andRadius r: CGFloat, forCenter p: CGPoint) -> CGPoint {
        return CGPoint(x: p.x + r * cos(a), y: p.y + r * sin(a))
    }
    
    private func drawGradient(in ctx: CGContext, startingAngle a: CGFloat, endingAngle b: CGFloat, intRadius intRadiusBlock: floatfloatBlock, outRadius outRadiusBlock: floatfloatBlock, withGradientBlock colorBlock: floatColorBlock, withSubdiv subdivCount: Int, withCenter center: CGPoint, withScale scale: CGFloat) {
        let angleDelta = CGFloat((b - a) / CGFloat(subdivCount))
        let fractionDelta = CGFloat(1.0 / Double(subdivCount))
        var p0: CGPoint
        var p1: CGPoint
        var p2: CGPoint
        var p3: CGPoint
        var p4: CGPoint
        var p5: CGPoint
        var currentAngle = CGFloat(a)
        p0 = pointForTrapezoid(withAngle: currentAngle, andRadius: intRadiusBlock(0), forCenter: center)
        p4 = p0
        p3 = pointForTrapezoid(withAngle: currentAngle, andRadius: outRadiusBlock(0), forCenter: center)
        p5 = p3
        let innerEnveloppe = CGMutablePath()
        let outerEnveloppe = CGMutablePath()
        outerEnveloppe.move(to: CGPoint(x: p3.x, y: p3.y))
        innerEnveloppe.move(to: CGPoint(x: p0.x, y: p0.y))
        ctx.saveGState()
        ctx.setLineWidth(1)
        for i in 0..<subdivCount {
            let fraction = CGFloat(i) / CGFloat(subdivCount)
            currentAngle = CGFloat(a + fraction * (b - a))
            let trapezoid = CGMutablePath()
            p1 = pointForTrapezoid(withAngle: currentAngle + angleDelta, andRadius: intRadiusBlock(fraction + fractionDelta), forCenter: center)
            p2 = pointForTrapezoid(withAngle: currentAngle + angleDelta, andRadius: outRadiusBlock(fraction + fractionDelta), forCenter: center)
            trapezoid.move(to: CGPoint(x: p0.x, y: p0.y))
            trapezoid.addLine(to: CGPoint(x: p1.x, y: p1.y))
            trapezoid.addLine(to: CGPoint(x: p2.x, y: p2.y))
            trapezoid.addLine(to: CGPoint(x: p3.x, y: p3.y))
            trapezoid.closeSubpath()
            let centerofTrapezoid = CGPoint(x: (p0.x + p1.x + p2.x + p3.x) / 4, y: (p0.y + p1.y + p2.y + p3.y) / 4)
            let t = CGAffineTransform(translationX: -centerofTrapezoid.x, y: -centerofTrapezoid.y)
            let s = CGAffineTransform(scaleX: scale, y: scale)
            var concat = t.concatenating(s.concatenating(t.inverted()))
            if let scaledPath = trapezoid.copy(using: &concat) {
                ctx.addPath(scaledPath)
            }
            ctx.setFillColor(colorBlock(fraction).cgColor)
            ctx.setStrokeColor(colorBlock(fraction).cgColor)
            ctx.setMiterLimit(0)
            ctx.drawPath(using: .fillStroke)
            p0 = p1
            p3 = p2
            outerEnveloppe.addLine(to: CGPoint(x: p3.x, y: p3.y))
            innerEnveloppe.addLine(to: CGPoint(x: p0.x, y: p0.y))
        }
        ctx.setLineWidth(0)
        ctx.setLineJoin(.round)
        ctx.setStrokeColor(UIColor.textTitle.cgColor)
        ctx.addPath(outerEnveloppe)
        ctx.addPath(innerEnveloppe)
        ctx.move(to: CGPoint(x: p0.x, y: p0.y))
        ctx.addLine(to: CGPoint(x: p3.x, y: p3.y))
        ctx.move(to: CGPoint(x: p4.x, y: p4.y))
        ctx.addLine(to: CGPoint(x: p5.x, y: p5.y))
        ctx.strokePath()
    }

    private func circleImage(with size: CGSize) -> UIImage? {
        if size.equalTo(CGSize.zero) {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        renderCircleImage(to: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let circle: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return circle
    }
    
    private func renderCircleImage(to rect: CGRect) {
        guard let color = color, let ctx = UIGraphicsGetCurrentContext() else { return }
        
        UIColor.clear.setFill()
        UIRectFill(rect)
        var newRect = rect
        if rect.width > rect.height {
            newRect.size.width = rect.size.height
        } else {
            newRect.size.height = rect.size.width
        }
        let radius = CGFloat(newRect.size.width / 2)
        drawGradient(in: ctx, startingAngle: 0, endingAngle: 2 * .pi, intRadius: {(_ f: CGFloat) -> CGFloat in
            return radius - self.circleWidth
        }, outRadius: {(_ f: CGFloat) -> CGFloat in
            return radius
        }, withGradientBlock: {(_ f: CGFloat) -> UIColor in
            return color.withAlphaComponent(CGFloat(f))
        }, withSubdiv: circleSubdivCount, withCenter: CGPoint(x: rect.midX, y: rect.midY), withScale: 0.5)
    }
    
    // MARK: Animations
    private func startAnimating() {
        guard let circleImageView = circleImageView else { return }
        if circleImageView.layer.animation(forKey: ActivityIndicatorAnimationKey) != nil || circleImageView.image == nil {
            return
        }
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = .pi * 2.0
        rotationAnimation.duration = CFTimeInterval(ActivityIndicatorDurationPerTurn)
        rotationAnimation.repeatCount = .greatestFiniteMagnitude
        circleImageView.layer.add(rotationAnimation, forKey: ActivityIndicatorAnimationKey)
    }
    
    private func stopAnimating() {
        circleImageView?.layer.removeAllAnimations()
    }
}
