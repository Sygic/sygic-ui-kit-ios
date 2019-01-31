import UIKit


/// Compass arrow drawn with `UIBezierPath`
class SYUICompassArrow: UIView {
    
    override func draw(_ rect: CGRect) {
        //// north Drawing
        let northPath = UIBezierPath()
        northPath.move(to: CGPoint(x: CGFloat(rect.minX + 0.41304 * rect.width), y: CGFloat(rect.minY + 0.50000 * rect.height)))
        northPath.addLine(to: CGPoint(x: CGFloat(rect.minX + 0.50000 * rect.width), y: CGFloat(rect.minY + 0.10870 * rect.height)))
        northPath.addLine(to: CGPoint(x: CGFloat(rect.minX + 0.58696 * rect.width), y: CGFloat(rect.minY + 0.50000 * rect.height)))
        northPath.addLine(to: CGPoint(x: CGFloat(rect.minX + 0.41304 * rect.width), y: CGFloat(rect.minY + 0.50000 * rect.height)))
        northPath.close()
        UIColor.error.setFill()
        northPath.fill()
        //// south Drawing
        let southPath = UIBezierPath()
        southPath.move(to: CGPoint(x: CGFloat(rect.minX + 0.41304 * rect.width), y: CGFloat(rect.minY + 0.50000 * rect.height)))
        southPath.addLine(to: CGPoint(x: CGFloat(rect.minX + 0.50000 * rect.width), y: CGFloat(rect.minY + 0.89130 * rect.height)))
        southPath.addLine(to: CGPoint(x: CGFloat(rect.minX + 0.58696 * rect.width), y: CGFloat(rect.minY + 0.50000 * rect.height)))
        southPath.addLine(to: CGPoint(x: CGFloat(rect.minX + 0.41304 * rect.width), y: CGFloat(rect.minY + 0.50000 * rect.height)))
        southPath.close()
        UIColor.border.setFill()
        southPath.fill()
    }
    
}
