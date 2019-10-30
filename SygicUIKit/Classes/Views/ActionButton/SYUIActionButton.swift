//// SYUIActionButton.swift
//
// Copyright (c) 2019 Sygic a.s.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit


/// Action button properties protocol.
public protocol SYUIActionButtonProperties {
    var title: String? { get }
    var subtitle: String? { get }
    var icon: String? { get }
    var style: SYUIActionButtonStyle { get }
    var height: CGFloat { get }
    var titleSize: CGFloat? { get }
    var subtitleSize: CGFloat? { get }
    var iconSize: CGFloat { get }
    var iconAlignment: NSTextAlignment { get }
    var isEnabled: Bool { get }
    var countdown: TimeInterval? { get }
    var accessibilityIdentifier: String? { get }
    var isHidden: Bool { get set }
}

/// Style of action button.
@objc public enum SYUIActionButtonStyle: Int {
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
    /// In case of error occured.
    case error
    /// In case of alert.
    case alert
    /// Primary action
    case primary13
    /// Secondary action.
    case secondary13
    /// In case of error occured.
    case error13
}

/// Action button sizes.
public enum SYUIActionButtonSize: CGFloat {
    /// Normal size.
    case normal = 56.0
    /// Infobar size.
    case infobar = 48.0
    /// Compact size.
    case compact = 40.0
    
    /// Height raw value.
    public var height: CGFloat {
        return self.rawValue
    }
}

public typealias SYUIActionBlock = (_ sender: Any)->()

///General purpose action button. Configurable with `SYUIActionButtonProperties`.
public class SYUIActionButton: UIButton, SYUIActionButtonProperties {
    
    // MARK: - Public Properties
    
    /// Action block triggered on touchUpInside button event
    public var action: SYUIActionBlock? {
        didSet {
            addTarget(self, action: #selector(actionBlockSelector(_:)), for: .touchUpInside)
        }
    }
    
    /// Title of an action button.
    public var title: String? {
        didSet {
            updateLayout()
        }
    }

    /// Subtitle of an action button.
    public var subtitle: String? {
        didSet {
            updateLayout()
        }
    }
    
    /// Icon of an action button.
    public var icon: String? {
        didSet {
            updateLayout()
        }
    }
    
    /// Image icon of an action button.
    public var iconImage: UIImage? {
        didSet {
            updateLayout()
        }
    }
    
    /// Height of an action button.
    public var height: CGFloat = SYUIActionButtonSize.normal.height {
        didSet {
            updateLayout()
        }
    }
    
    /// Title size of an action button.
    public var titleSize: CGFloat? {
        didSet {
            updateLayout()
        }
    }
    
    /// Subtitle size of an action button.
    public var subtitleSize: CGFloat? {
        didSet {
            updateLayout()
        }
    }
    
    /// Icon size of an action button.
    public var iconSize: CGFloat = 24.0 {
        didSet {
            updateLayout()
        }
    }
    
    /// Icon alignment of an action button. Default is `NSTextAlignment.right`.
    public var iconAlignment: NSTextAlignment = .right {
        didSet {
            updateLayout()
        }
    }
    
    /// Style of an action button. Default is `SYUIActionButtonStyle.primary`.
    public var style = SYUIActionButtonStyle.primary {
        didSet {
            updateLayout()
        }
    }
    
    /// Overrided titleLabel to return action button title label.
    override public var titleLabel: UILabel? {
        return customTitleLabel
    }
    
    /// Overrided subtitleLabel to return action button subtitle label.
    public var subtitleLabel: UILabel {
        return customSubtitleLabel
    }
    
    /// Set countdown to show countdown indicator in action button.
    public var countdown: TimeInterval? = nil {
        didSet {
            addCountdownViewsIfNeeded()
        }
    }
    
    /// Right accessory view of an action button.
    public var rightAccessoryView: UIView? {
        willSet {
            if let view = newValue {
                rightAccessoryView?.removeFromSuperview()
                rightAccessoryPlaceholder.addSubview(view)
                view.translatesAutoresizingMaskIntoConstraints = false
                view.coverWholeSuperview()
                rightAccessoryPlaceholder.bringSubviewToFront(view)
                rightIcon.isHidden = true
                iconImageView.isHidden = true
            } else if let view = rightAccessoryView {
                view.removeFromSuperview()
                rightIcon.isHidden = rightIcon.text == nil
                iconImageView.isHidden = iconImage == nil
            }
        }
    }
    
    /// Corner radius of button.
    /// Affects only not fully rounded button styles: primary13, secondary13, error13
    public var partialCornerRadius: CGFloat = 16 {
        didSet {
            updateRoundedCorners()
        }
    }
    
    public override var backgroundColor: UIColor? {
        didSet {
            originalBackgroundColor = backgroundColor
            backgroundView.backgroundColor = backgroundColor
        }
    }
    
    public override var tintColor: UIColor! {
        didSet {
            customTitleLabel.textColor = tintColor
            customSubtitleLabel.tintColor = tintColor
            rightIcon.textColor = tintColor
            iconImageView.tintColor = tintColor
        }
    }
    
    public override var isHighlighted: Bool {
        didSet {
            guard let backgroundColor = originalBackgroundColor, isHighlighted != oldValue else { return }
            if style == .plain {
                customTitleLabel.textColor = isHighlighted ? UIColor.action.adjustBrightness(with: SYUIColorSchemeManager.shared.brightnessMultiplier.lighter) : .action
            } else if style == .blurred {
                let color = isHighlighted ? UIColor.textInvert.adjustBrightness(with: SYUIColorSchemeManager.shared.brightnessMultiplier.darker) : .textInvert
                rightIcon.textColor = color
                iconImageView.tintColor = color
            } else {
                let multiplier = SYUIColorSchemeManager.shared.brightnessMultiplier(for: backgroundColor, foregroundColor: customTitleLabel.textColor)
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
                let disabledColor: UIColor = .mapInfoBackground
                backgroundColor = .iconBackground
                layer.borderColor = disabledColor.cgColor
                customTitleLabel.textColor = disabledColor
                let iconColor: UIColor = disabledColor
                rightIcon.textColor = iconColor
                iconImageView.tintColor = iconColor
                if let activityIndicator = rightAccessoryView as? UIActivityIndicatorView {
                    activityIndicator.color = disabledColor
                }
                borderView.isHidden = true
                setShadow(for: .plain)
            }
        }
    }
    
    // MARK: - Private Properties
    
    private var originalBackgroundColor: UIColor?
    private var leftMarginConstraint: NSLayoutConstraint?
    private var rightMarginConstraint: NSLayoutConstraint?
    private var iconCenterXConstraint: NSLayoutConstraint?
    private var iconImageViewWidthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    private var widthConstraint: NSLayoutConstraint?
    private var rightIconFontSize: CGFloat { iconSize }
    private let backgroundView = FadingHighlightedBackgroundView(frame: .zero)
    private let rightAccessoryPlaceholder = UIView()
    private let borderView = UIView()
    private var blur: UIView?
    private var countdownRoundView: CirclePathCountdownView?
    private var countdownBarView: BarPathCountdownView?
    private let customTitleLabel = UILabel()
    private let customSubtitleLabel = UILabel()
    private let rightIcon = UILabel()
    private let iconImageView = UIImageView()
    private let stackView = UIStackView()
    private let labelsStackView = UIStackView()

    private var hasTitle: Bool {
        guard let titleText = customTitleLabel.text else { return false }
        
        return !titleText.isEmpty
    }
    
    private var hasSubtitle: Bool {
        guard let subtitleText = customSubtitleLabel.text else { return false }
        
        return !subtitleText.isEmpty
    }
    
    private var hasRightIcon: Bool {
        if let rightIconText = rightIcon.text, !rightIconText.isEmpty {
            return true
        }
        return iconImageView.image != nil
    }
    
    private var hasOnlyIcon: Bool {
        return !hasTitle && !hasSubtitle && hasRightIcon && rightAccessoryView == nil
    }
    
    private var shouldCapitalizeTitle: Bool {
        return hasTitle && !hasRightIcon && rightAccessoryView == nil && style != .plain && style != .primary13 && style != .secondary13 && style != .error13
    }
    
    private var horizontalMargin: CGFloat = 16.0 {
        didSet {
            leftMarginConstraint?.constant = horizontalMargin
            rightMarginConstraint?.constant = -horizontalMargin
        }
    }
    
    // MARK: - Public Methods
    
    // MARK: Overrides
    
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
            self.customTitleLabel.isHidden = self.customTitleLabel.text == nil
        }
        let alignment: NSTextAlignment = (!hasRightIcon && rightAccessoryView == nil) ? .center : .left
        customTitleLabel.textAlignment = alignment
        customSubtitleLabel.textAlignment = alignment
        
        rightAccessoryPlaceholder.isHidden = !hasRightIcon && rightAccessoryView == nil
        rightIcon.textAlignment = .center
        customTitleLabel.baselineAdjustment = .alignCenters
        customSubtitleLabel.baselineAdjustment = .alignCenters
        
        super.layoutSubviews()

        updateRoundedCorners()
        
        if let countdownRoundView = countdownRoundView {
            addProgressSubview(countdownRoundView)
        } else if let countdownBarView = countdownBarView {
            addProgressSubview(countdownBarView)
        }
    }
    
    override public func setTitle(_ title: String?, for state: UIControl.State) {
        self.customTitleLabel.text = title
        
        addCountdownViewsIfNeeded()
        capitalizeTitleIfNeeded()
        layoutSubviews()
    }
    
    // MARK: Public Interface

    /// Modify the margins of the button contents by left or right insets.
    ///
    /// - Parameter insets: Used left and right values only.
    public func setContentsMargin(with insets:UIEdgeInsets){
        leftMarginConstraint?.constant = insets.left
        rightMarginConstraint?.constant = -insets.right
        setNeedsLayout()
    }
    
    // MARK: - Private Methods
    
    private func updateLayout() {
        customTitleLabel.text = title
        customSubtitleLabel.text = subtitle
        rightIcon.text = icon
        rightIcon.font = SYUIFont.with(.icon, size: iconSize)
        rightIcon.textAlignment = iconAlignment
        iconImageView.image = iconImage
        iconImageViewWidthConstraint?.constant = iconSize
        iconImageViewWidthConstraint?.isActive = iconImage != nil
        updateStyle()
        capitalizeTitleIfNeeded()
        if accessibilityIdentifier == nil {
            accessibilityIdentifier = "actionButton"
        }
        
        heightConstraint?.constant = height
        
        let enableSideMargins = hasTitle
        leftMarginConstraint?.isActive = enableSideMargins
        rightMarginConstraint?.isActive = enableSideMargins
        widthConstraint?.isActive = !enableSideMargins
        
        stackView.spacing = hasTitle ? 8 : 0
        setNeedsLayout()
    }
    
    private func updateRoundedCorners() {
        if style == .primary13 || style == .secondary13 || style == .error13 {
            layer.cornerRadius = partialCornerRadius
            backgroundView.layer.cornerRadius = partialCornerRadius
            borderView.layer.cornerRadius = partialCornerRadius
        } else {
            fullRoundCorners()
            backgroundView.fullRoundCorners()
            borderView.fullRoundCorners()
            blur?.fullRoundCorners()
            blur?.clipsToBounds = true
        }
    }
    
    // MARK: Default UI
    
    private func createDefaultUI() {
        setupBorder()
        setupBackgroundView()
        rightIcon.font = SYUIFont.with(.icon, size: rightIconFontSize)
        customTitleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        customTitleLabel.minimumScaleFactor = 0.6
        customTitleLabel.adjustsFontSizeToFitWidth = true
        
        setupConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setupColors), name: Notification.Name(ColorPaletteChangedNotification), object: nil)
    }
    
    private func setupConstraints() {
        customTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        customSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        labelsStackView.addArrangedSubview(customTitleLabel)
        labelsStackView.addArrangedSubview(customSubtitleLabel)
        
        stackView.addArrangedSubview(labelsStackView)
        stackView.addArrangedSubview(rightAccessoryPlaceholder)
        
        rightAccessoryPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        rightAccessoryPlaceholder.widthAnchor.constraint(equalToConstant: CGFloat(rightIconFontSize)).isActive = true

        rightIcon.translatesAutoresizingMaskIntoConstraints = false
        rightAccessoryPlaceholder.addSubview(rightIcon)
        rightIcon.coverWholeSuperview()
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        rightAccessoryPlaceholder.addSubview(iconImageView)
        iconImageView.centerInSuperview()
        iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor, multiplier: 1).isActive = true
        iconImageViewWidthConstraint = iconImageView.widthAnchor.constraint(equalToConstant: iconSize)
        
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
    
    private func setShadow(for style: SYUIActionButtonStyle) {
        switch style {
        case .plain, .loading, .primary13, .secondary13, .error13:
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
    
    private func setTitleLabelFont(for style: SYUIActionButtonStyle) {
        let titleSize = self.titleSize ?? SYUIFontSize.heading
        customTitleLabel.font = SYUIFont.with(.semiBold, size: titleSize)
    }
    
    private func setSubtitleLabelFont(for style: SYUIActionButtonStyle) {
        let subtitleSize = self.subtitleSize ?? SYUIFontSize.body
        customSubtitleLabel.font = SYUIFont.with(.semiBold, size: subtitleSize)
    }
    
    private func capitalizeTitleIfNeeded() {
        if shouldCapitalizeTitle {
            customTitleLabel.text = customTitleLabel.text?.uppercased()
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
            countdownRoundView?.setup(with: countdown, strokeColor: customTitleLabel.textColor)
        } else {
            countdownBarView = BarPathCountdownView()
            countdownBarView?.setup(with: countdown, strokeColor: customTitleLabel.textColor)
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
    
    private func updateStyle() {
        blur?.removeFromSuperview()
        var textColor: UIColor = .textInvert
        var borderColor: UIColor = .iconBackground
        var layerBorderWidth: CGFloat = 0
        
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
            customTitleLabel.isHidden = true
            customSubtitleLabel.isHidden = true
            rightIcon.textColor = .textInvert
            iconImageView.tintColor = .textInvert
            borderView.isHidden = true
            rightAccessoryView = nil
            blur = addBlurViewWithMapControlsBlurStyle()
        case .primary13:
            backgroundColor = .accentPrimary
            borderView.isHidden = true
            rightAccessoryView = nil
        case .secondary13:
            backgroundColor = .accentBackground
            textColor = .accentPrimary
            borderColor = .accentPrimary
            layerBorderWidth = 2
            borderView.isHidden = true
            rightAccessoryView = nil
        case .error13:
            backgroundColor = .red
            borderView.isHidden = true
            rightAccessoryView = nil
        }
        
        layer.borderWidth = layerBorderWidth
        layer.borderColor = borderColor.cgColor
        borderView.backgroundColor = borderColor
        customTitleLabel.textColor = textColor
        customSubtitleLabel.textColor = textColor
        rightIcon.textColor = textColor
        iconImageView.tintColor = textColor
        setTitleLabelFont(for: style)
        setSubtitleLabelFont(for: style)
        setShadow(for: style)
    }
    
    @objc private func actionBlockSelector(_ sender: SYUIActionButton) {
        action?(sender)
    }
}

// MARK: - Optional subviews
extension SYUIActionButton {
    
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

extension SYUIActionButton: SYUIColorUpdate {
    
    public func setupColors() {
        updateLayout()
    }
    
}
