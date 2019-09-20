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
    
    private func setupUI() {
        backgroundColor = .accentBackground
        layer.cornerRadius = 24
        
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerStackView)
        headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding*2).isActive = true
        headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding*2).isActive = true
        headerStackView.topAnchor.constraint(equalTo: topAnchor, constant: padding*2).isActive = true
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(actionButton)
        actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
        actionButton.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: padding*2).isActive = true
        
        headerStackView.addArrangedSubview(descriptionLabel)
        headerStackView.addArrangedSubview(titleLabel)
    }
}

// MARK: - Layout Orientation
extension SYUIBubbleView {
    public func addToView(_ parentView: UIView, landscapeLayout: Bool = true, animated: Bool = false) {
        translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(self)
        bottomAnchor.constraint(equalTo: parentView.safeBottomAnchor, constant: -margin).isActive = true
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
