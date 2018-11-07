import UIKit

public class BarPathCountdownView: PathProgressView {
    
    override var path: UIBezierPath {
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

public class BarPathProgressView: PathProgressView {
    
    override var path: UIBezierPath {
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
