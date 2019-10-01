//// SYUIBubbleView.swift
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

public class SYUIBubbleView: UIView {

    // MARK: Public properties
    
    public static let margin: CGFloat = 8
    
    public lazy var headerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    public var widthConstraint: NSLayoutConstraint?
    public var trailingConstraint: NSLayoutConstraint?
    
    public let contentContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    public lazy var contentActionsContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = margin
        return stack
    }()
    
    // MARK: Private properties
    
    private var margin: CGFloat { SYUIBubbleView.margin }
    private var minConstant: CGFloat { margin * 2 }
    private var maxConstant: CGFloat { contentHeight == 0 ? minConstant : contentHeight + minConstant*2 }
    private var contentHeight: CGFloat { contentContainer.bounds.size.height }
    private var startOffset: CGFloat = 0
    private var variableConstraint: NSLayoutConstraint?
    
    private let dragIndicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 3
        view.widthAnchor.constraint(equalToConstant: 82).isActive = true
        view.heightAnchor.constraint(equalToConstant: 6).isActive = true
        return view
    }()
    
    private lazy var buttonsContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = margin
        return stack
    }()
    
    private let gradient = SYUIGradientView()
    
    // MARK: Public methods
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        dragIndicator.isHidden = contentHeight == 0
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        let isLandscape = SYUIDeviceOrientationUtils.isLandscapeLayout(traitCollection)
        updateConstraints(landscapeLayout: isLandscape)
        updateGradientColors()
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        updateDragIndicatorColor(true)
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        updateDragIndicatorColor(false)
    }
    
    public func addHeader(with title: String?, _ description: String?) {
        let header = SYUIBubbleHeader()
        header.titleLabel.text = title
        header.descriptionLabel.text = description
        headerStackView.addArrangedSubview(header)
    }
    
    public func addContentActionButton(title: String, icon: UIImage?, enabled isEnabled: Bool, action: SYUIBubbleContentActionButton.Action?) {
        let button = SYUIBubbleContentActionButton()
        button.titleLabel.text = title
        button.imageView.image = icon
        button.isEnabled = isEnabled
        button.action = action
        if contentActionsContainer.arrangedSubviews.count == 0 {
            contentContainer.setCustomSpacing(margin, after: contentActionsContainer)
        }
        contentActionsContainer.addArrangedSubview(button)
    }
    
    public func addContent(with icon: UIImage, title: String, subtitle: String?) {
        let view = BubbleContentRow(with: icon, title: title, subtitle: subtitle)
        contentContainer.addArrangedSubview(view)
    }
    
    public func addActionButton(_ button: SYUIActionButton) {
        buttonsContainer.addArrangedSubview(button)
    }
    
    // MARK: Private methods
    
    private func setupUI() {
        backgroundColor = .accentBackground
        layer.cornerRadius = 24
        clipsToBounds = true
        layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        addSubview(dragIndicator)
        dragIndicator.topAnchor.constraint(equalTo: topAnchor, constant: margin).isActive = true
        dragIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        updateDragIndicatorColor(false)
        
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerStackView)
        headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        headerStackView.topAnchor.constraint(equalTo: topAnchor, constant: margin*3).isActive = true
        
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentContainer)
        contentContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
        contentContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
        contentContainer.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: minConstant).isActive = true
        sendSubviewToBack(contentContainer)
        contentContainer.addArrangedSubview(contentActionsContainer)
            
        buttonsContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonsContainer)
        buttonsContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
        buttonsContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
        buttonsContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin).isActive = true
        variableConstraint = buttonsContainer.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: minConstant)
        variableConstraint?.isActive = true
        
        gradient.locations = [0, 1]
        gradient.translatesAutoresizingMaskIntoConstraints = false
        updateGradientColors()
        addSubview(gradient)
        gradient.heightAnchor.constraint(equalToConstant: margin*2).isActive = true
        gradient.bottomAnchor.constraint(equalTo: buttonsContainer.topAnchor).isActive = true
        gradient.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        gradient.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        
        let contentCover = UIView()
        contentCover.backgroundColor = .accentBackground
        contentCover.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentCover)
        contentCover.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentCover.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        contentCover.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentCover.topAnchor.constraint(equalTo: buttonsContainer.topAnchor).isActive = true
        
        bringSubviewToFront(buttonsContainer)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized(_:)))
        addGestureRecognizer(panGestureRecognizer)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognized(_:)))
        headerStackView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func tapGestureRecognized(_ recognizer: UITapGestureRecognizer) {
        guard let constraint = variableConstraint else { return }
        let expanded = constraint.constant > minConstant
        animateViewHeight(!expanded)
        updateDragIndicatorColor(false)
    }
    
    @objc private func panGestureRecognized(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: recognizer.view)
        switch recognizer.state {
        case .began,
             .possible:
            guard let constraint = variableConstraint else { return }
            startOffset = constraint.constant
            updateDragIndicatorColor(true)
        case .changed:
            let offset = startOffset-translation.y
            variableConstraint?.constant = min(maxConstant, max(minConstant, offset))
            setNeedsLayout()
            break
        case .ended,
             .cancelled,
             .failed:
            let expanding = translation.y < 0
            animateViewHeight(expanding)
            updateDragIndicatorColor(false)
            break
        default:
            break
        }
    }
    
    private func animateViewHeight(_ expand: Bool) {
        guard let variableConstraint = variableConstraint else { return }
        variableConstraint.constant = expand ? maxConstant : minConstant
        UIView.animate(withDuration: SYUIConstants.animationDuration, delay: 0, options: [.beginFromCurrentState, .curveEaseOut], animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func updateDragIndicatorColor(_ active: Bool) {
        let alpha: CGFloat = active ? 0.3 : 0.1
        dragIndicator.backgroundColor = UIColor.accentSecondary.withAlphaComponent(alpha)
    }
    
    private func updateGradientColors() {
        guard let color = backgroundColor else { return }
        gradient.colors = [color.withAlphaComponent(0), color]
    }
}

// MARK: - Layout Orientation

extension SYUIBubbleView {
    
    public func addToView(_ parentView: UIView, landscapeLayout: Bool = true, animated: Bool = false, completion: ((_ finished: Bool)->())? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(self)
        centerYAnchor.constraint(equalTo: parentView.safeBottomAnchor, constant: -margin*2).isActive = true
        leadingAnchor.constraint(equalTo: parentView.safeLeadingAnchor, constant: margin*2).isActive = true
        widthConstraint?.isActive = false
        widthConstraint = widthAnchor.constraint(equalTo: parentView.widthAnchor, multiplier: 0.4)
        trailingConstraint = trailingAnchor.constraint(equalTo: parentView.safeTrailingAnchor, constant: -margin*2)
        updateConstraints(landscapeLayout: landscapeLayout)
        if animated {
            layoutIfNeeded()
            alpha = 0
            UIView.animate(withDuration: SYUIConstants.animationDuration, animations: {
                self.alpha = 1
            }) { finished in
                completion?(finished)
            }
        } else {
            completion?(true)
        }
    }
    
    public func updateConstraints(landscapeLayout: Bool) {
        if landscapeLayout {
            trailingConstraint?.isActive = false
            widthConstraint?.isActive = true
        } else {
            widthConstraint?.isActive = false
            trailingConstraint?.isActive = true
        }
    }
}

// MARK: ROW

public class BubbleContentRow: UIView {
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        stack.spacing = 16
        return stack
    }()
    
    private let labelsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .accentPrimary
        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1).isActive = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = SYUIFont.with(.regular, size: SYUIFontSize.headingOld)
        label.textColor = .accentSecondary
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = SYUIFont.with(.regular, size: SYUIFontSize.bodyOld)
        label.textColor = .accentSecondary
        return label
    }()
    
    public required init(with icon: UIImage, title: String, subtitle: String?) {
        super.init(frame: .zero)
        imageView.image = icon
        titleLabel.text = title
        subtitleLabel.text = subtitle
        
        heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.coverWholeSuperview()
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(labelsStackView)
        labelsStackView.addArrangedSubview(titleLabel)
        if subtitle != nil {
            labelsStackView.addArrangedSubview(subtitleLabel)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: ACTION

public class SYUIBubbleContentActionButton: UIControl {
    
    public typealias Action = (_ sender: SYUIBubbleContentActionButton)->()
    
    public var action: Action?
    
    public override var tintColor: UIColor? {
        didSet {
            guard let color = tintColor else { return }
            imageView.tintColor = color
            titleLabel.textColor = color
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            tintColor = isEnabled ? .accentPrimary : .gray
        }
    }
    
    public override var isHighlighted: Bool {
        didSet {
            guard isHighlighted != oldValue, let contentColor = tintColor else { return }
            let multiplier = SYUIColorSchemeManager.shared.brightnessMultiplier(for: originalBackgroundColor, foregroundColor: contentColor)
            let highlightedColor = isHighlighted ? originalBackgroundColor.adjustBrightness(with: multiplier) : originalBackgroundColor
            backgroundColor = highlightedColor
        }
    }
    
    public let imageView = UIImageView()
    
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.font = SYUIFont.with(.regular, size: SYUIFontSize.bodyOld)
        return label
    }()
    
    private var margin: CGFloat { SYUIBubbleView.margin }
    private let originalBackgroundColor: UIColor = .veryLightPink
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .veryLightPink
        layer.cornerRadius = 16
        tintColor = .accentPrimary
        
        heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: margin, leading: margin, bottom: margin, trailing: margin)
        stackView.spacing = margin
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.coverWholeSuperview()
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.isUserInteractionEnabled = false
        
        addTarget(self, action: #selector(tapAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return super.beginTracking(touch, with: event)
    }
    
    public override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        super.sendAction(action, to: target, for: event)
    }
    
    @objc private func tapAction() {
        action?(self)
    }
}

// MARK: ACTION

public class SYUIBubbleHeader: UIStackView {
    
    public var titleLabel: UILabel = {
        let label = UILabel()
        label.font = SYUIFont.with(SYUIFont.FontType.bold, size: SYUIFontSize.headingOld)
        label.textColor = .accentSecondary
        return label
    }()
    
    public var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = SYUIFont.with(SYUIFont.FontType.regular, size: SYUIFontSize.bodyOld)
        label.textColor = .accentSecondary
        return label
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        let margin = SYUIBubbleView.margin
        
        axis = .vertical
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: margin*2, bottom: 0, trailing: margin*2)
        spacing = margin
        
        addArrangedSubview(descriptionLabel)
        addArrangedSubview(titleLabel)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
