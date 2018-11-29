import Foundation
import UIKit

public class SYUICompass: UIView {
    private let COMPASS_BACKGROUND_SIZE = 44.0
    private let COMPASS_BORDER_SIZE = 46.0
    private let compassArrow = SYUICompassArrow()
    private let backgroundView = UIView()
    private let borderView = UIView()
    
    public init() {
        super.init(frame: CGRect.zero)
        initDefault()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView.fullRoundCorners()
        borderView.fullRoundCorners()
    }
    
    public func rotateArrow(_ rotation: CGFloat) {
        compassArrow.layer.setAffineTransform(CGAffineTransform(rotationAngle: rotation))
    }
    
    public func animateVisibility(_ visible: Bool) {
        if visible && alpha == 0.0  {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut, .beginFromCurrentState], animations: {
                self.alpha = 1.0
            })
        } else if !visible && alpha == 1.0 {
            UIView.animate(withDuration: 0.2, delay: 1.0, options: [.curveEaseInOut, .beginFromCurrentState], animations: {
                self.alpha = 0.0
            })
        }
    }
    
    //MARK: - UI
    private func initDefault() {
        alpha = 1
        accessibilityLabel = "native.compas"
        translatesAutoresizingMaskIntoConstraints = false
        let compassSize = CGSize(width: COMPASS_BACKGROUND_SIZE, height: COMPASS_BACKGROUND_SIZE)
        NSLayoutConstraint.activate(widthAndHeightConstraints(with: compassSize))
        createBorderView()
        createBackgroundView()
        createCompassArrow()
        
        self.borderView.backgroundColor = UIColor(red:0.09, green:0.11, blue:0.15, alpha:0.1)
        self.backgroundView.backgroundColor = .white
        self.compassArrow.setNeedsDisplay()
        self.setupDefaultShadow()
    }
    
    private func createBackgroundView() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = .background
        addSubview(backgroundView)
        backgroundView.coverWholeSuperview()
    }
    
    private func createBorderView() {
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.backgroundColor = .iconBackground
        addSubview(borderView)
        borderView.coverWholeSuperview(withMargin: -1.0)
    }
    
    private func createCompassArrow() {
        compassArrow.translatesAutoresizingMaskIntoConstraints = false
        compassArrow.layer.shouldRasterize = true
        compassArrow.backgroundColor = .clear
        
        addSubview(compassArrow)
        compassArrow.coverWholeSuperview()
    }
    
    // MARK: - UIViewGeometry
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if (alpha == 0) {
            return false
        }
        var bounds: CGRect = self.bounds
        let hitOffset = CGFloat(10.0)
        bounds = CGRect(x: CGFloat(bounds.origin.x - hitOffset), y: CGFloat(bounds.origin.y - hitOffset), width: CGFloat(bounds.size.width + 2 * hitOffset), height: CGFloat(bounds.size.height + 2 * hitOffset))
        return bounds.contains(point)
    }
}
