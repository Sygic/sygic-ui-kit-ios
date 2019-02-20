
/// Rotation of button for proper animation rotation.
public enum SYUIExpandableButtonRotationDirection {
    /// Button is rotating to the left.
    case left
    /// Button is rotating to the right.
    case right
}

/// Title type of button.
public enum SYUIExpandableButtonType {
    /// Title is text.
    case text
    /// Title is icon.
    case icon
}

/**
    Expandable button class.
 
    Expandable buttons are used in `SYUIExpandableButtonsController`. It represents main button and also buttons which are expanded.
*/
public class SYUIExpandableButton: UIButton {
    
    // MARK: - Public Properties
    
    /// Font size of title in button based on device orientation.
    public static var fontSize: CGFloat {
        return SYUIDeviceOrientationUtils.orientationSize(for: SYUIExpandableButton.fontSizePortrait, landscape: SYUIExpandableButton.fontSizeLandscape)
    }
    
    /// Size of button based on device orientation.
    public static var size: CGFloat {
        return SYUIDeviceOrientationUtils.orientationSize(for: SYUIExpandableButton.sizePortrait, landscape: SYUIExpandableButton.sizeLandscape)
    }
    
    /// isHiglighted override for setting text color of label.
    override public var isHighlighted: Bool {
        didSet {
            guard isHighlighted != oldValue else { return }
            iconLabel.textColor = isHighlighted ? iconColor.adjustBrightness(with: SYUIColorSchemeManager.shared.brightnessMultiplier.darker) : iconColor
        }
    }
    
    // MARK: - Private Properties
    
    private static let animationHelpLabelTag = 34562
    private static let sizePortrait: CGFloat = 52.0
    private static let sizeLandscape: CGFloat = 44.0
    private static let fontSizePortrait: CGFloat = 36.0
    private static let fontSizeLandscape: CGFloat = 30.0
    
    private var widthConstrait = NSLayoutConstraint()
    private var iconColor = UIColor()
    private var iconLabel = UILabel()
    private var type: SYUIExpandableButtonType = .text
    private var blurView: UIView?
    
    // MARK: - Public Methods
    
    /// Expandable button init.
    ///
    /// - Parameter type: Type of the button.
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
    
    /// Animate title change of the button.
    ///
    /// - Parameters:
    ///   - newTitle: new title for the button.
    ///   - duration: duration of the animation.
    ///   - direction: direction of the animatio.
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
    
    /// Remove all actual animations.
    public func removeAllAnimations() {
        layer.removeAllAnimations()
        for view in subviews {
            view.layer.removeAllAnimations()
        }
    }
    
    // MARK: - Private Methods
    
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
            return SYUIFont.with(SYUIFont.iconFont, size: SYUIExpandableButton.fontSize)!
        case .text:
            return SYUIFont.with(SYUIFont.semiBold, size: SYUIExpandableButton.fontSize)!
        }
    }
    
}
