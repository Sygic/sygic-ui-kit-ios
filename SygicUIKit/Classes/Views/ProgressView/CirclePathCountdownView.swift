import UIKit


/**
 Circle path view with countdown.
 
 To set countdown and stroke color call
 ```
 public func setup(with countdownDuration: TimeInterval, strokeColor: UIColor = .action)
 ```
 */
public class CirclePathCountdownView: PathProgressView {

    override public var path: UIBezierPath {
        return UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - PathProgressView.lineWidth)/2, startAngle: CGFloat(.pi * -0.5), endAngle: CGFloat(.pi * 1.5), clockwise: true)
    }
    
}

/**
 Circle path view with progress.
 
 To set progress and stroke color call
 ```
 public func setup(progress: CGFloat, strokeColor: UIColor = .action)
 ```
 */
public class CirclePathProgressView: PathProgressView {
    
    override public var path: UIBezierPath {
        return UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - PathProgressView.lineWidth)/2, startAngle: CGFloat(.pi * -0.5), endAngle: CGFloat(.pi * -2.5), clockwise: false)
    }
    
}
