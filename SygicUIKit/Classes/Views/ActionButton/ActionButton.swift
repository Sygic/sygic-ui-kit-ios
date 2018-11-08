import UIKit

@objc public enum ActionButtonStyle: Int {
    /// Primary action.
    case primary
    /// Secondary action.
    case secondary
    /// Can be used over content (e.g. map, camera)
    case blurred
    /// Loading state used for inactive buttons with `UIActivityIndicatorView` as `rightAccessoryView`.
    case loading
    /// Less important action. Clear `backgroundColor`.
    case plain
    /// In case of error occured
    case error
    /// In case of alert
    case alert
}

public enum ActionButtonSize: CGFloat {
    case normal = 56.0
    case compact = 40.0
    
    public var height: CGFloat {
        return self.rawValue
    }
}

///General purpose action button. Configurable with `ActionButtonViewModel`.
public class ActionButton: UIButton {
    
    public var action: (() -> Void)?
    public var title = UILabel()
    public var subtitle = UILabel()
    public var rightIcon = UILabel()
    public var countdown: TimeInterval? = nil {
        didSet {
            addCountdownViewsIfNeeded()
        }
    }
    
    public var rightAccessoryView: UIView? {
        willSet {
            if let view = newValue {
                rightAccessoryView?.removeFromSuperview()
                rightAccessoryPlaceholder.addSubview(view)
                view.translatesAutoresizingMaskIntoConstraints = false
                view.coverWholeSuperview()
                rightAccessoryPlaceholder.bringSubview(toFront: view)
                rightIcon.isHidden = true
            } else if let view = rightAccessoryView {
                view.removeFromSuperview()
                rightIcon.isHidden = rightIcon.text == nil
            }
        }
    }
    
    public var style = ActionButtonStyle.primary {
        didSet {
            blur?.removeFromSuperview()
            var textColor: UIColor = .textInvert
            
            switch style {
            case .primary:
                backgroundColor = .action
                borderView.isHidden = true
                rightAccessoryView = nil
            case .secondary:
                backgroundColor = .background
                textColor = .action
                borderView.isHidden = false
                rightAccessoryView = nil
            case .loading:
                backgroundColor = .border
                borderView.isHidden = true
                let indicator = UIActivityIndicatorView()
                indicator.startAnimating()
                rightAccessoryView = indicator
            case .plain:
                backgroundColor = .clear
                textColor = .action
                borderView.isHidden = true
                rightAccessoryView = nil
            case .error:
                backgroundColor = .error
                borderView.isHidden = true
                rightAccessoryView = nil
            case .alert:
                backgroundColor = .background
                textColor = .error
                borderView.isHidden = false
                rightAccessoryView = nil
            case .blurred:
                backgroundColor = .clear
                title.isHidden = true
                subtitle.isHidden = true
                rightIcon.textColor = .textInvert
                borderView.isHidden = true
                rightAccessoryView = nil
                blur = addBlurViewWithMapControlsBlurStyle()
            }
            
            borderView.backgroundColor = .iconBackground
            title.textColor = textColor
            subtitle.textColor = textColor
            rightIcon.textColor = textColor
            setTitleLabelFont(for: style)
            setSubtitleLabelFont(for: style)
            setShadow(for: style)
        }
    }
    
    public override var backgroundColor: UIColor? {
        didSet {
            originalBackgroundColor = backgroundColor
            backgroundView.backgroundColor = backgroundColor
        }
    }
    
    private var hasTitle: Bool {
        guard let titleText = title.text else { return false }
        
        return !titleText.isEmpty
    }
    
    private var hasSubtitle: Bool {
        guard let subtitleText = subtitle.text else { return false }
        
        return !subtitleText.isEmpty
    }
    
    private var hasRightIcon: Bool {
        guard let rightIconText = rightIcon.text else { return false }
        
        return !rightIconText.isEmpty
    }
    
    private var hasOnlyIcon: Bool {
        return !hasTitle && !hasSubtitle && hasRightIcon && rightAccessoryView == nil
    }
    
    private var shouldCapitalizeTitle: Bool {
        return hasTitle && !hasRightIcon && rightAccessoryView == nil && style != .plain
    }
    
    override public var isHighlighted: Bool {
        didSet {
            guard let backgroundColor = originalBackgroundColor, isHighlighted != oldValue else { return }
            if style == .plain {
                title.textColor = isHighlighted ? UIColor.action.adjustBrightness(with: ColorSchemeManager.sharedInstance.brightnessMultiplier.lighter) : .action
            } else if style == .blurred {
                rightIcon.textColor = isHighlighted ? UIColor.textInvert.adjustBrightness(with: ColorSchemeManager.sharedInstance.brightnessMultiplier.darker) : .textInvert
            } else {
                let multiplier = ColorSchemeManager.sharedInstance.brightnessMultiplier(for: backgroundColor, foregroundColor: title.textColor)
                let highlightedColor = isHighlighted ? backgroundColor.adjustBrightness(with: multiplier) : backgroundColor
                
                backgroundView.highlightColor = highlightedColor
                backgroundView.showHighlight(true)
            }
        }
    }
    
    override public var isEnabled: Bool {
        didSet {
            if isEnabled {
                let style = self.style
                self.style = style
            } else {
                backgroundColor = .iconBackground
                title.textColor = .mapInfoBackground
                rightIcon.textColor = .mapInfoBackground
                if let activityIndicator = rightAccessoryView as? UIActivityIndicatorView {
                    activityIndicator.color = .mapInfoBackground
                }
                borderView.isHidden = true
                setShadow(for: .plain)
            }
        }
    }
    
    private var horizontalMargin: CGFloat = 16.0 {
        didSet {
            leftMarginConstraint?.constant = horizontalMargin
            rightMarginConstraint?.constant = -horizontalMargin
        }
    }
    
    private var viewModel: ActionButtonViewModel?
    private var originalBackgroundColor: UIColor?
    private var leftMarginConstraint: NSLayoutConstraint?
    private var rightMarginConstraint: NSLayoutConstraint?
    private var iconCenterXConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    private var widthConstraint: NSLayoutConstraint?
    private var rightIconFontSize: CGFloat = 24.0
    private let backgroundView = FadingHighlightedBackgroundView(frame: .zero)
    private let rightAccessoryPlaceholder = UIView()
    private let borderView = UIView()
    private var blur: UIView?
    private var countdownRoundView: CirclePathCountdownView?
    private var countdownBarView: BarPathCountdownView?
    private let stackView = UIStackView()
    private let labelsStackView = UIStackView()
    
    // MARK: - Overrides
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        createDefaultUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        createDefaultUI()
    }
    
    override public func layoutSubviews() {
        //was not possible to change the title.isHidden value after it was set to true only with this hack
        DispatchQueue.main.async {
            self.title.isHidden = self.title.text == nil
        }
        let alignment: NSTextAlignment = (rightIcon.text?.isEmpty ?? true && rightAccessoryView == nil) ? .center : .left
        title.textAlignment = alignment
        subtitle.textAlignment = alignment
        
        rightAccessoryPlaceholder.isHidden = rightIcon.text?.isEmpty ?? true && rightAccessoryView == nil
        rightIcon.textAlignment = .center
        title.baselineAdjustment = .alignCenters
        subtitle.baselineAdjustment = .alignCenters
        
        super.layoutSubviews()

        fullRoundCorners()
        backgroundView.fullRoundCorners()
        borderView.fullRoundCorners()
        
        
        blur?.fullRoundCorners()
        blur?.clipsToBounds = true
        
        if let countdownRoundView = countdownRoundView {
            addProgressSubview(countdownRoundView)
        } else if let countdownBarView = countdownBarView {
            addProgressSubview(countdownBarView)
        }
    }
    
    override public func setTitle(_ title: String?, for state: UIControlState) {
        self.title.text = title
        
        addCountdownViewsIfNeeded()
        capitalizeTitleIfNeeded()
        layoutSubviews()
    }
    
    // MARK: - Public
    
    public func setup(with viewModel: ActionButtonViewModel) {
        self.viewModel = viewModel
        
        title.text = viewModel.title
        subtitle.text = viewModel.subtitle
        rightIcon.text = viewModel.icon
        style = viewModel.style
        accessibilityIdentifier = viewModel.accessibilityIdentifier ?? "actionButton"
        rightIcon.font = SygicFonts.with(SygicFonts.iconFont, size: viewModel.iconSize)
        rightIcon.textAlignment = viewModel.iconAlignment
        isEnabled = viewModel.isEnabled
        countdown = viewModel.countdown
        
        capitalizeTitleIfNeeded()
        
        heightConstraint?.constant = viewModel.height
        
        let enableSideMargins = hasTitle
        leftMarginConstraint?.isActive = enableSideMargins
        rightMarginConstraint?.isActive = enableSideMargins
        widthConstraint?.isActive = !enableSideMargins
        
        stackView.spacing = hasTitle ? 8 : 0
        setNeedsLayout()
    }
    
    /**
     Modify the margins of the button contents by left or right insets
     - Parameter insets: Used left and right values only
     */
    public func setContentsMargin(with insets:UIEdgeInsets){
        leftMarginConstraint?.constant = insets.left
        rightMarginConstraint?.constant = -insets.right
        setNeedsLayout()
    }
    
    // MARK: - Default UI
    
    private func createDefaultUI() {
        setupBorder()
        setupBackgroundView()
        rightIcon.font = SygicFonts.with(SygicFonts.iconFont, size: rightIconFontSize)
        title.setContentCompressionResistancePriority(.required, for: .horizontal)
        title.minimumScaleFactor = 0.6
        title.adjustsFontSizeToFitWidth = true
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8.0
        stackView.isUserInteractionEnabled = false
        
        backgroundView.addSubview(stackView)
        stackView.centerInSuperview()
        
        leftMarginConstraint = stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalMargin)
        leftMarginConstraint?.priority = .required
        leftMarginConstraint?.isActive = true
        
        rightMarginConstraint = stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalMargin)
        rightMarginConstraint?.priority = .required
        rightMarginConstraint?.isActive = true
        
        labelsStackView.axis = .vertical
        labelsStackView.alignment = .fill
        labelsStackView.distribution = .fillProportionally
        
        labelsStackView.addArrangedSubview(title)
        labelsStackView.addArrangedSubview(subtitle)
        
        stackView.addArrangedSubview(labelsStackView)
        stackView.addArrangedSubview(rightAccessoryPlaceholder)
        
        rightAccessoryPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        rightAccessoryPlaceholder.widthAnchor.constraint(equalToConstant: CGFloat(rightIconFontSize)).isActive = true

        rightAccessoryPlaceholder.addSubview(rightIcon)
        rightIcon.translatesAutoresizingMaskIntoConstraints = false
        rightIcon.coverWholeSuperview()
        
        heightConstraint = heightAnchor.constraint(equalToConstant: 56.0)
        heightConstraint?.isActive = true
        
        widthConstraint = widthAnchor.constraint(equalTo: heightAnchor) // width constraint should activates only when button has icon and no title
    }
    
    private func setupBackgroundView() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundView)
        backgroundView.coverWholeSuperview()
    }
    
    private func setupBorder() {
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.isUserInteractionEnabled = false
        borderView.isHidden = true
        addSubview(borderView)
        borderView.coverWholeSuperview(withMargin: -1.0)
    }
    
    private func setShadow(for style: ActionButtonStyle) {
        switch style {
        case .plain, .loading:
            layer.shadowOpacity = 0.0
        case .primary:
            layer.shadowOpacity = 1.0
            layer.shadowColor = UIColor.actionShadow.cgColor
            layer.shadowRadius = 8.0
            layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        case .secondary, .alert, .blurred:
            layer.shadowOpacity = 1.0
            layer.shadowColor = UIColor.shadow.cgColor
            layer.shadowRadius = 10.0
            layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        case .error:
            layer.shadowOpacity = 1.0
            layer.shadowColor = UIColor.errorShadow.cgColor
            layer.shadowRadius = 12.0
            layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        }
    }
    
    private func setTitleLabelFont(for style: ActionButtonStyle) {
        let titleSize = viewModel?.titleSize ?? SygicFontSize.heading
        title.font = SygicFonts.with(SygicFonts.semiBold, size: titleSize)
    }
    
    private func setSubtitleLabelFont(for style: ActionButtonStyle) {
        let subtitleSize = viewModel?.subtitleSize ?? SygicFontSize.body
        subtitle.font = SygicFonts.with(SygicFonts.semiBold, size: subtitleSize)
    }
    
    private func capitalizeTitleIfNeeded() {
        
        if shouldCapitalizeTitle {
            title.text = title.text?.uppercased()
        }
    }
    
    private func removeCountdownViews() {
        countdownBarView?.removeFromSuperview()
        countdownRoundView?.removeFromSuperview()
        
        countdownBarView = nil
        countdownRoundView = nil
    }
    
    private func addCountdownViewsIfNeeded() {
        removeCountdownViews()
        guard let countdown = countdown else { return }
        
        if (hasOnlyIcon) {
            countdownRoundView = CirclePathCountdownView()
            countdownRoundView?.setup(with: countdown, strokeColor: title.textColor)
        } else {
            countdownBarView = BarPathCountdownView()
            countdownBarView?.setup(with: countdown, strokeColor: title.textColor)
        }
        setNeedsLayout()
    }
    
    private func addProgressSubview(_ view: PathProgressView) {
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.removeFromSuperview()
        backgroundView.layer.masksToBounds = true
        backgroundView.addSubview(view)
        view.coverWholeSuperview()
    }
}

// MARK: - Optional subviews
extension ActionButton {
    
    public func setupCountdownActivityIndicator(size: CGSize) -> InfiniteCountdownActivityIndicator {
        let activityIndicator = InfiniteCountdownActivityIndicator()
        activityIndicator.color = .action
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundView.addSubview(activityIndicator)
        NSLayoutConstraint.activate(activityIndicator.widthAndHeightConstraints(with: size))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:[activityIndicator]-(14.0)-|", options: [], metrics: nil, views: ["activityIndicator": activityIndicator]))
        activityIndicator.centerVerticallyInSuperview()
        
        return activityIndicator
    }
    
}
