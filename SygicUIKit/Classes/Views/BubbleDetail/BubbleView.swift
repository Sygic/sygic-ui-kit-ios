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
    public var actionButton: SYUIActionButton = {
        let button = SYUIActionButton()
        button.style = .primary13
        button.title = LS("Get direction")
        button.icon = SYUIIcon.directions
        button.height = SYUIActionButtonSize.infobar.height
        return button
    }()
    
    public var headerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
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
    
    public var widthConstraint: NSLayoutConstraint?
    public var trailingConstraint: NSLayoutConstraint?
    
    public let margin: CGFloat = 16
    public let padding: CGFloat = 8
    
    // MARK: Private properties
    
    private var minConstant: CGFloat { padding * 2 }
    private var maxConstant: CGFloat { contentHeight + minConstant*2 }
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
    
    private let contentContainer = UIStackView()
    private let contentActionsContainer = UIStackView()
    
    // MARK: Public methods
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        let isLandscape = SYUIDeviceOrientationUtils.isLandscapeLayout(traitCollection)
        updateConstraints(landscapeLayout: isLandscape)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        updateDragIndicatorColor(true)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        updateDragIndicatorColor(false)
    }
    
    public func addContent(with icon: UIImage, title: String, subtitle: String? = nil) {
        let view = BubbleContentRow(with: icon, title: title, subtitle: subtitle)
        contentContainer.addArrangedSubview(view)
    }
    
    // MARK: Private methods
    
    private func setupUI() {
        backgroundColor = .accentBackground
        layer.cornerRadius = 24
        clipsToBounds = true
        layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        addSubview(dragIndicator)
        dragIndicator.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
        dragIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        updateDragIndicatorColor(false)
        
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerStackView)
        headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding*2).isActive = true
        headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding*2).isActive = true
        headerStackView.topAnchor.constraint(equalTo: topAnchor, constant: padding+margin).isActive = true
        
        headerStackView.addArrangedSubview(descriptionLabel)
        headerStackView.addArrangedSubview(titleLabel)
        
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentContainer)
        contentContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        contentContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        contentContainer.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: minConstant).isActive = true
        sendSubviewToBack(contentContainer)
        
        if let color = backgroundColor {
            let gradient = SYUIGradientView()
            gradient.colors = [color.withAlphaComponent(0), color]
            gradient.locations = [0, NSNumber(value: 2.0/9.0)]
            gradient.backgroundColor = .clear
            gradient.translatesAutoresizingMaskIntoConstraints = false
            addSubview(gradient)
            gradient.heightAnchor.constraint(equalToConstant: 64).isActive = true
            gradient.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            gradient.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
            gradient.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        }
            
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(actionButton)
        actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
        variableConstraint = actionButton.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: minConstant)
        variableConstraint?.isActive = true
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized(_:)))
        addGestureRecognizer(panGestureRecognizer)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognized(_:)))
        addGestureRecognizer(tapGestureRecognizer)
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
}

// MARK: - Layout Orientation

extension SYUIBubbleView {
    
    public func addToView(_ parentView: UIView, landscapeLayout: Bool = true, animated: Bool = false) {
        translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(self)
        centerYAnchor.constraint(equalTo: parentView.safeBottomAnchor, constant: -margin).isActive = true
        leadingAnchor.constraint(equalTo: parentView.safeLeadingAnchor, constant: margin).isActive = true
        widthConstraint?.isActive = false
        widthConstraint = widthAnchor.constraint(equalTo: parentView.widthAnchor, multiplier: 0.4)
        trailingConstraint = trailingAnchor.constraint(equalTo: parentView.safeTrailingAnchor, constant: -margin)
        updateConstraints(landscapeLayout: landscapeLayout)
        if animated {
            layoutIfNeeded()
            alpha = 0
            UIView.animate(withDuration: SYUIConstants.animationDuration) {
                self.alpha = 1
            }
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
    
    required init(with icon: UIImage, title: String, subtitle: String?) {
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
