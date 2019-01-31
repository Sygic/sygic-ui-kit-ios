import UIKit


/**
 Bar path view with countdown.
 
 To set countdown and stroke color call
 ```
 public func setup(with countdownDuration: TimeInterval, strokeColor: UIColor = .action)
 ```
 */
public class BarPathCountdownView: PathProgressView {
    
    override public var path: UIBezierPath {
        let path = UIBezierPath()
        var start = frame.origin
        start.y += frame.size.height - PathProgressView.lineWidth/2
        var end = start
        end.x += frame.size.width
        
        path.move(to: end)
        path.addLine(to: start)
        return path
    }
}


/**
 Bar path view with progress.
 
 To set progress and stroke color call
 ```
 public func setup(progress: CGFloat, strokeColor: UIColor = .action)
 ```
 */
public class BarPathProgressView: PathProgressView {
    
    override public var path: UIBezierPath {
        let path = UIBezierPath()
        var start = frame.origin
        start.y += frame.size.height - PathProgressView.lineWidth/2
        var end = start
        end.x += frame.size.width
        
        path.move(to: start)
        path.addLine(to: end)
        return path
    }
}
