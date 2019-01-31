import CoreGraphics
import UIKit


/// A path view that depicts the progress of a task over time.
public class PathProgressView: UIView {
    
    // MARK: - Public Properties
    
    /// Width of a progress path line
    static let lineWidth: CGFloat = 4.0
    
    /// Progress path
    public var path: UIBezierPath {
        return UIBezierPath()
    }
    
    // MARK: - Private Properties
    
    private let barLayer: CAShapeLayer
    private var duration: TimeInterval = 0.0
    private var strokeColor: UIColor = .action
    
    // MARK: - Public Methods
    
    override public init(frame: CGRect) {
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
    
    /// Set up path with a countdown. So it will fulfill automatically.
    ///
    /// - Parameters:
    ///   - countdownDuration: Countdown duration of a path.
    ///   - strokeColor: Stroke color.
    public func setup(with countdownDuration: TimeInterval, strokeColor: UIColor = .action) {
        self.duration = countdownDuration
        self.strokeColor = strokeColor
    }

    /// Set up path with a progress. So path will be fill based on progress.
    ///
    /// - Parameters:
    ///   - progress: Progress value between 0.0 and 1.0.
    ///   - strokeColor: Stroke color.
    public func setup(progress: CGFloat, strokeColor: UIColor = .action) {
        self.duration = 0
        self.strokeColor = strokeColor
        barLayer.strokeEnd = progress
        setNeedsDisplay()
    }
    
    // MARK: - Private Methods
    
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
