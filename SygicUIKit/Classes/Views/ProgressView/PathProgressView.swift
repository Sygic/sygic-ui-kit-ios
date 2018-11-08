import CoreGraphics
import UIKit

public class PathProgressView: UIView {
    
    static let lineWidth: CGFloat = 4.0
    
    private let barLayer: CAShapeLayer
    private var duration: TimeInterval = 0.0
    private var strokeColor: UIColor = .action
    
    var path: UIBezierPath {
        return UIBezierPath()
    }
    
    override init(frame: CGRect) {
        barLayer = CAShapeLayer()
        barLayer.fillColor = UIColor.clear.cgColor
        barLayer.lineWidth = PathProgressView.lineWidth
        barLayer.strokeEnd = 0.0

        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        layer.addSublayer(barLayer)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        barLayer.path = path.cgPath
        barLayer.strokeColor = strokeColor.cgColor
        startAnimate()
    }
    
    public func setup(with countdownDuration: TimeInterval, strokeColor: UIColor = .action) {
        self.duration = countdownDuration
        self.strokeColor = strokeColor
    }
    
    /**
     
     */
    public func setup(progress: CGFloat, strokeColor: UIColor = .action) {
        self.duration = 0
        self.strokeColor = strokeColor
        barLayer.strokeEnd = progress
        setNeedsDisplay()
    }
    
    private func startAnimate() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        guard duration > 0 else { return }
        
        animation.duration = duration
        animation.fromValue = 1
        animation.toValue = 0
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        barLayer.strokeEnd = 0.0
        barLayer.removeAllAnimations()
        barLayer.add(animation, forKey: "animateCircle")
    }
}
