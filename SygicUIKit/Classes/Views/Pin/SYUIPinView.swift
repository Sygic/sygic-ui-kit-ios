import UIKit
import QuartzCore


/// Pin view delegate protocol.
public protocol SYUIPinViewDelegate: class {
    
    /// Delegate information, that pin state has changed.
    ///
    /// - Parameters:
    ///   - pin: pin, that state has changed.
    ///   - isHighlighted: returns if pin is higligted.
    func pinStateHasChanged(_ pin: SYUIPinView, isHighlighted: Bool)
    
    /// Delegate informaion, that pin was tapped.
    ///
    /// - Parameter pin: pin, that was tapped.
    func pinWasTapped(_ pin: SYUIPinView)
}

/// Pin view class representing pin on a map.
public class SYUIPinView: UIView {
    
    // MARK: - Public Properties
    
    /// Icon showed in a pin.
    public var icon: String? {
        didSet {
            if let iconString = icon, iconString.isLetterAtoZ, !iconView.isKind(of: SYUIPinViewLetter.self) {
                iconView.removeFromSuperview()
                iconView = SYUIPinViewLetter()
                addIconView()
            }
            
            iconView.icon = icon
        }
    }

    /// Color of a pin.
    public var color: UIColor? {
        didSet {
            backgroundView.pinColor = color
            iconView.iconColor = color
        }
    }
    
    /// Sets or returns higlihted state of a pin.
    public var isHighlighted = false {
        didSet {
            setHighlighted(isHighlighted, animated: animatedHighlight)
        }
    }
    
    /// A Boolean value indicating whether highlight of a pin is animated or not.
    public var animatedHighlight = false
    
    override public var frame: CGRect {
        get {
            if isHighlighted {
                var selectedFrame = backgroundView.frame.union(iconView.frame)
                selectedFrame.origin = CGPoint(x: super.frame.origin.x + selectedFrame.origin.x, y: super.frame.origin.y + selectedFrame.origin.y)
                
                return selectedFrame
            } else {
                return super.frame
            }
        }
        
        set {
            super.frame = newValue
        }
    }
    
    /// Delegate of a pin view.
    public weak var delegate: SYUIPinViewDelegate?
    
    // MARK: - Private Properties
    
    private static let pinSize = CGSize(width: 48.0, height: 48.0)
    private var backgroundView = SYUIPinViewBackground()
    private var iconView = SYUIPinViewIcon()
    private var actionButton = UIButton()
    
    // MARK: - Public Methods
    
    // MARK: Life cycle
    
    required public init(icon: String? = nil, color: UIColor? = nil, highlighted: Bool = false, animatedHighlight: Bool = false) {
        super.init(frame: CGRect(x: 0, y: 0, width: SYUIPinView.pinSize.width, height: SYUIPinView.pinSize.height))
        
        autoresizingMask = []
        clipsToBounds = false
        
        backgroundView.center = CGPoint(x: bounds.width/2.0, y: bounds.height/2.0)
        addSubview(backgroundView)
        
        addIconView()
        
        actionButton.frame = backgroundView.frame.union(iconView.frame)
        actionButton.addTarget(self, action: #selector(handleTap), for: UIControlEvents.touchUpInside)
        addSubview(actionButton)
        
        backgroundView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        defer {
            self.icon = icon
            self.color = color
            self.isHighlighted = highlighted
            self.animatedHighlight = animatedHighlight
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: State configuration
    
    /// Returns whether pin should be shown in normal state (not selected).
    ///
    /// You can override this behaviour in inherited class.
    ///
    /// - Returns: If pin should be shown in normal state.
    public func shouldShowNormalState() -> Bool {
        return true
    }
    
    /// Returns whether pin should be shown in selected stata.
    ///
    /// You can override this behaviour in inherited class.
    ///
    /// - Returns: If pin should be shown in selected state.
    public func shouldShowSelectedState() -> Bool {
        return true
    }
    
    // MARK: Selection handling
    
    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if isHighlighted, backgroundView.frame.contains(point) {
            return actionButton
        }
        
        return super.hitTest(point, with: event)
    }
    
    /// Set, whether pin is higlighted (selected state) or not.
    ///
    /// - Parameters:
    ///   - highlighted: Boolean, whether pin is highligted or not.
    ///   - animated: Boolean, whether higlight is animated or not.
    ///   - completion: Completion block after pin is highligted.
    public func setHighlighted(_ highlighted: Bool, animated: Bool, completion: (() -> Void)? = nil) {
        delegate?.pinStateHasChanged(self, isHighlighted: highlighted)
        
        if highlighted {
            superview?.bringSubview(toFront: self)
            
            if animated {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.curveLinear, animations: {
                    self.selectedState()
                }, completion: { (_) in
                    completion?()
                })
            } else {
                selectedState()
                completion?()
            }
        } else {
            
            if animated {
                UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.deselectedState()
                }, completion: { (_) in
                    completion?()
                })
            } else {
                deselectedState()
                completion?()
            }
        }
    }
    
    /// Creates UIImage from pin UIView.
    ///
    /// - Returns: UIImage created from UIView.
    public override func imageFromView() -> UIImage? {
        var size = frame.size
        
        // shadows
        size.height += 8.0
        if isHighlighted {
            size.width += 10.0
            size.height += 6.0
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        var image: UIImage? = nil
        if let context = UIGraphicsGetCurrentContext() {
            if isHighlighted {
                context.translateBy(x: 21.0, y: 53.0)
            } else {
                context.translateBy(x: 5.0, y: 7.0)
            }
            layer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        
        UIGraphicsEndImageContext()
        return image
    }
    
    // MARK: - Private Methods
    
    private func addIconView() {
        iconView.center = CGPoint(x: bounds.width/2.0, y: bounds.height/2.0)
        addSubview(iconView)
    }
    
    private func selectedState() {
        backgroundView.alpha = shouldShowSelectedState() ? 1 : 0
        backgroundView.transform = CGAffineTransform.identity
        
        iconView.alpha = shouldShowSelectedState() ? 1 : 0
        iconView.transform = CGAffineTransform.identity
        iconView.center = CGPoint(x: bounds.width / 2.0, y: -22)
        iconView.isSelected = true
        iconView.shouldShowShadow = false
    }
    
    private func deselectedState() {
        backgroundView.alpha = 0
        backgroundView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        if shouldShowNormalState() {
            iconView.alpha = 1
        } else {
            iconView.alpha = 0
            iconView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }
        iconView.center = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
        iconView.isSelected = false
        iconView.shouldShowShadow = true
    }
    
    @objc private func handleTap(_ sender: UIButton) {
        delegate?.pinWasTapped(self)
    }
    
}
