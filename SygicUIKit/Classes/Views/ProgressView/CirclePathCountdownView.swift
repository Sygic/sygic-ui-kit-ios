import UIKit

public class CirclePathCountdownView: PathProgressView {

    override var path: UIBezierPath {
        return UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - PathProgressView.lineWidth)/2, startAngle: CGFloat(.pi * -0.5), endAngle: CGFloat(.pi * 1.5), clockwise: true)
    }
}

public class CirclePathProgressView: PathProgressView {
    
    override var path: UIBezierPath {
        return UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - PathProgressView.lineWidth)/2, startAngle: CGFloat(.pi * -0.5), endAngle: CGFloat(.pi * -2.5), clockwise: false)
    }
}
