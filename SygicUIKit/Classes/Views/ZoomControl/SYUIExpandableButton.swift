
public enum SYUIExpandableButtonRotationDirection {
    case left
    case right
}

public enum SYUIExpandableButtonType {
    case text
    case icon
}

public class SYUIExpandableButton: UIButton {
    
    private static let animationHelpLabelTag = 34562
    private static let sizePortrait: CGFloat = 52.0
    private static let sizeLandscape: CGFloat = 44.0
    private static let iconSizePortrait: CGFloat = 36.0
    private static let iconSizeLandscape: CGFloat = 30.0
    public static var iconSize: CGFloat {
        return SYUIDeviceOrientationUtils.orientationSize(for: SYUIExpandableButton.iconSizePortrait, landscape: SYUIExpandableButton.iconSizeLandscape)
    }
    public static var size: CGFloat {
        return SYUIDeviceOrientationUtils.orientationSize(for: SYUIExpandableButton.sizePortrait, landscape: SYUIExpandableButton.sizeLandscape)
    }
    
    var widthConstrait = NSLayoutConstraint()
    var iconColor = UIColor()
    var iconLabel = UILabel()
    var type: SYUIExpandableButtonType = .text
    var blurView: UIView?
    
    override public var isHighlighted: Bool {
        didSet {
            guard isHighlighted != oldValue else { return }
            iconLabel.textColor = isHighlighted ? iconColor.adjustBrightness(with: ColorSchemeManager.sharedInstance.brightnessMultiplier.darker) : iconColor
        }
    }
    
    public init(withType type: SYUIExpandableButtonType) {
        super.init(frame: CGRect.zero)
        self.type = type
        initDefaults()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        widthConstrait.constant = SYUIExpandableButton.size
        iconLabel.font = buttonFont()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        fullRoundShadowPath()
        blurView?.fullRoundCorners()
    }
    
    private func initDefaults() {
        iconColor = .textInvert
        blurView = addBlurViewWithMapControlsBlurStyle()
        setupDefaultShadow()
        iconLabel = createIconLabel()
        addSubview(iconLabel)
        iconLabel.coverWholeSuperview()
        widthConstrait = widthAnchor.constraint(equalToConstant: SYUIExpandableButton.size)
        widthConstrait.isActive = true
        widthAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    private func createIconLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = buttonFont()
        label.textColor = iconColor
        label.textAlignment = .center
        label.baselineAdjustment = .alignCenters
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }
    
    private func buttonFont() -> UIFont {
        switch type {
        case .icon:
            return SygicFonts.with(SygicFonts.iconFont, size: SYUIExpandableButton.iconSize)!
        case .text:
            return SygicFonts.with(SygicFonts.semiBold, size: SYUIExpandableButton.iconSize)!
        }
    }
    
    override public func setTitle(_ title: String?, for state: UIControlState) {
        iconLabel.text = title
    }
    
    override public func title(for state: UIControlState) -> String? {
        if let newLabel = viewWithTag(SYUIExpandableButton.animationHelpLabelTag) as? UILabel {
            return newLabel.text
        }
        return iconLabel.text
    }
    
    override public func setTitleColor(_ color: UIColor?, for state: UIControlState) {
        guard let color = color else { return }
        super.setTitleColor(color, for: state)
        iconColor = color
        iconLabel.textColor = color
    }
    
    public func animateTitleChange(to newTitle: String, withDuration duration: TimeInterval, andDirection direction: SYUIExpandableButtonRotationDirection) {
        if let oldLabel = viewWithTag(SYUIExpandableButton.animationHelpLabelTag) {
            oldLabel.alpha = 0.0
        }
        
        let animationLabel = createIconLabel()
        animationLabel.tag = SYUIExpandableButton.animationHelpLabelTag
        addSubview(animationLabel)
        animationLabel.coverWholeSuperview()
        animationLabel.text = newTitle
        animationLabel.alpha = 0.0
        
        switch direction {
        case .left:
            animationLabel.layer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat.pi / 2))
        case .right:
            animationLabel.layer.setAffineTransform(CGAffineTransform(rotationAngle: -CGFloat.pi / 2))
        }
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut, animations: {
            self.iconLabel.alpha = 0.0
            animationLabel.alpha = 1.0
            animationLabel.layer.setAffineTransform(.identity)
            switch direction {
            case .left:
                self.iconLabel.layer.setAffineTransform(CGAffineTransform(rotationAngle: -CGFloat.pi / 2))
            case .right:
                self.iconLabel.layer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat.pi / 2))
            }
        }) { (finished) in
            self.iconLabel.alpha = 1.0
            self.iconLabel.layer.setAffineTransform(.identity)
            self.iconLabel.text = newTitle
            animationLabel.removeFromSuperview()
        }
    }
    
    public func removeAllAnimations() {
        layer.removeAllAnimations()
        for view in subviews {
            view.layer.removeAllAnimations()
        }
    }
    
}
