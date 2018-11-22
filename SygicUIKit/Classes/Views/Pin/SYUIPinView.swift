import UIKit
import QuartzCore

public protocol SYUIPinViewProperties {
    var icon: String? { get }
    var color: UIColor? { get }
    var isSelected: Bool { get }
    var animated: Bool { get }
}

public protocol SYUIPinViewDelegate: class {
    func pinStateHasChanged(_ pin: SYUIPinView, isSelected: Bool)
    func pinWasTapped(_ pin: SYUIPinView)
}

public class SYUIPinView: UIView {
    public var viewModel: SYUIPinViewProperties! {
        didSet {
            if let iconString = viewModel.icon, iconString.isLetterAtoZ, !iconView.isKind(of: SYUIPinViewLetter.self) {
                iconView.removeFromSuperview()
                iconView = SYUIPinViewLetter()
                addIconView()
            }
            
            if viewModel.icon != oldValue.icon {
                iconView.icon = viewModel.icon
            }
            
            if viewModel.color != oldValue.color {
                backgroundView.pinColor = viewModel.color
                iconView.iconColor = viewModel.color
            }
            
            if viewModel.isSelected != oldValue.isSelected {
                setSelected(viewModel.isSelected, animated: viewModel.animated)
            }
        }
    }
    
    private static let pinSize = CGSize(width: 48.0, height: 48.0)
    
    private var backgroundView = SYUIPinViewBackground()
    private var iconView = SYUIPinViewIcon()
    private var actionButton = UIButton()
    
    override public var frame: CGRect {
        get {
            if let model = self.viewModel, model.isSelected {
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
    
    public weak var delegate: SYUIPinViewDelegate?
    
    // MARK: - Life cycle
    
    required public init() {
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
        viewModel = SYUIPinViewViewModel()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addIconView() {
        iconView.center = CGPoint(x: bounds.width/2.0, y: bounds.height/2.0)
        addSubview(iconView)
    }
    
    // MARK: - State configuration
    
    public func shouldShowNormalState() -> Bool {
        return true
    }

    public func shouldShowSelectedState() -> Bool {
        return true
    }

    // MARK: - Selection handling

    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.viewModel.isSelected, backgroundView.frame.contains(point) {
            return actionButton
        }
        
        return super.hitTest(point, with: event)
    }
    
    public func setSelected(_ selected: Bool, animated: Bool, completion: (() -> Void)? = nil) {
        delegate?.pinStateHasChanged(self, isSelected: selected)
        
        if selected {
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
    
    public override func imageFromView() -> UIImage? {
        var size = frame.size
        //shadows
        
        size.height += 8.0
        if !viewModel.isSelected {
            size.width += 10.0
            size.height += 6.0
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        var image: UIImage? = nil
        if let context = UIGraphicsGetCurrentContext() {
            if viewModel.isSelected {
                context.translateBy(x: 16.0, y: 48.0)
            } else {
                context.translateBy(x: 5.0, y: 7.0)
            }
            layer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        
        UIGraphicsEndImageContext()
        return image
    }
}
