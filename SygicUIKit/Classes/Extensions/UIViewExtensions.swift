import Foundation
import UIKit

public extension UIView {
    
    public class var statusBarHeight: CGFloat {
        if UIApplication.shared.isStatusBarHidden {
            return 0
        }
        
        let statusFrame = UIApplication.shared.statusBarFrame
        return min(statusFrame.height, statusFrame.width)
    }
    
    // MARK: - Centering View
    func centerInSuperview() {
        centerHorizontallyInSuperview()
        centerVerticallyInSuperview()
    }
    
    func centerHorizontallyInSuperview() {
        if superview == nil {
            return
        }
        if let aSuperview = superview {
            superview?.addConstraint(NSLayoutConstraint(item: aSuperview, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        }
    }
    
    func centerVerticallyInSuperview() {
        centerVerticallyInSuperview(withOffset: 0.0)
    }
    
    func centerVerticallyInSuperview(withOffset offset: CGFloat) {
        if superview == nil {
            return
        }
        if let aSuperview = superview {
            superview?.addConstraint(NSLayoutConstraint(item: aSuperview, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: offset))
        }
    }
    
    func alignHorizontalCenter(to view: UIView?) {
        let areSiblings: Bool = superview == view?.superview
        if superview == nil || !areSiblings {
            return
        }
        superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
    }
    
    func alignVerticalCenter(to view: UIView?) {
        let areSiblings: Bool = superview == view?.superview
        if superview == nil || !areSiblings {
            return
        }
        superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0))
    }
    
    func widthAndHeightConstraints(with size: CGSize) -> [NSLayoutConstraint] {
        let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: size.width)
        let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: size.height)
        return [widthConstraint, heightConstraint]
    }
    
    func coverWholeSuperview(withMargin margin: CGFloat = 0) {
        if superview == nil {
            return
        }
        let metrics = ["margin": margin]
        superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(margin)-[self]-(margin)-|", options: .alignAllCenterY, metrics: metrics, views: ["self": self]))
        superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(margin)-[self]-(margin)-|", options: .alignAllCenterX, metrics: metrics, views: ["self": self]))
    }
    
    // MARK: - Gettings constraints
    
    func topConstraint() -> NSLayoutConstraint? {
        let predicate1 = NSPredicate(format: "firstAttribute = %d AND firstItem = %@", NSLayoutAttribute.top.rawValue, self)
        let predicate2 = NSPredicate(format: "secondAttribute = %d AND secondItem = %@", NSLayoutAttribute.top.rawValue, self)
        let finalPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [predicate1, predicate2])
        let topConstraints: [NSLayoutConstraint]? = (superview?.constraints as NSArray?)?.filtered(using: finalPredicate) as? [NSLayoutConstraint]
        
        return topConstraints?.first
    }
    
    func bottomConstraint() -> NSLayoutConstraint? {
        let predicate1 = NSPredicate(format: "firstAttribute = %d AND firstItem = %@", NSLayoutAttribute.bottom.rawValue, self)
        let predicate2 = NSPredicate(format: "secondAttribute = %d AND secondItem = %@", NSLayoutAttribute.bottom.rawValue, self)
        let finalPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [predicate1, predicate2])
        let bottomConstraints: [NSLayoutConstraint]? = (superview?.constraints as NSArray?)?.filtered(using: finalPredicate) as? [NSLayoutConstraint]
        
        return bottomConstraints?.first
    }
    
    func trailingConstraint() -> NSLayoutConstraint? {
        let predicate1 = NSPredicate(format: "firstAttribute = %d AND firstItem = %@", NSLayoutAttribute.trailing.rawValue, self)
        let predicate2 = NSPredicate(format: "secondAttribute = %d AND secondItem = %@", NSLayoutAttribute.trailing.rawValue, self)
        let finalPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [predicate1, predicate2])
        let bottomConstraints: [NSLayoutConstraint]? = (superview?.constraints as NSArray?)?.filtered(using: finalPredicate) as? [NSLayoutConstraint]
        
        return bottomConstraints?.first
    }
    
    // MARK: - Safe areas
    
    public var safeLeadingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.leadingAnchor
        } else {
            return leadingAnchor
        }
    }
    
    public var safeTrailingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.trailingAnchor
        } else {
            return trailingAnchor
        }
    }
    
    public var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        } else {
            return topAnchor
        }
    }
    
    public var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        } else {
            return bottomAnchor
        }
    }
    
    public var validSafeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return self.safeAreaInsets
        } else {
            return UIEdgeInsets(top: UIView.statusBarHeight, left: 0, bottom: 0, right: 0)
        }
    }
    
    public var unsafeAreaStatusBarOffset: CGFloat {
        if #available(iOS 11.0, *) {
            // if using safeAreaLayoutGuide == we are safe
            return 0.0
        } else {
            if(UIApplication.shared.isStatusBarHidden) {
                return 0.0
            }
            let frame = UIApplication.shared.statusBarFrame
            return min(frame.size.width, frame.size.height)
        }
    }
}

// MARK: - Corners & Shadows
public extension UIView {
    
    private static let cornerRadius: CGFloat = 16.0
    private static let shadowRadius: CGFloat = 4.0
    
    // MARK: Corners
    
    /// Round corners by default corner radius.
    public func roundCorners() {
        layer.cornerRadius = UIView.cornerRadius
    }
    
    /// Round corners by half of the size to create fully rounded corners.
    public func fullRoundCorners() {
        let cornerRadius = min(bounds.width, bounds.height) / 2.0
        layer.cornerRadius = cornerRadius
    }
    
    // MARK: Shadows
    
    /// Creates `shadowPath` with default corner radius.
    public func roundShadowPath() {
        layer.shadowPath = UIBezierPath.init(roundedRect: bounds, cornerRadius: UIView.cornerRadius).cgPath
    }
    
    /// Creates `shadowPath` with fully rounded corners.
    public func fullRoundShadowPath() {
        let cornerRadius = min(bounds.width, bounds.height) / 2.0
        layer.shadowPath = UIBezierPath.init(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
    }
    
    /// Adds default shadow for "floating" controls
    public func setupDefaultShadow() {
        setupShadow(with: UIView.shadowRadius)
    }
    
    /// Adds shadow with specific radius
    public func setupShadow(with radius: CGFloat) {
        layer.shadowColor = UIColor.shadow.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowRadius = radius
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.masksToBounds = false
    }
    
    /// Adds default shadow as transparent border from bottom and right side
    public func setupShadowBorder() {
        layer.shadowColor = UIColor.barShadow.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.0
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.masksToBounds = false
    }
    
    /// Adds default shadow as transparent border from top and right side
    public func setupShadowTopBorder() {
        setupShadowBorder()
        layer.shadowOffset = CGSize(width: 1, height: -1)
    }
}
