//// SYUIActionButtonsView.swift
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


/// Action buttons delegate protocol.
public protocol SYUIActionButtonsDelegate: class {
    func actionButtonPressed(_ button: SYUIActionButton, at index:Int)
}

/// View that contains multiple action buttons.
public class SYUIActionButtonsView: UIView {
    
    // MARK: - Public Properties

    /// Action buttons delegate.
    public weak var delegate: SYUIActionButtonsDelegate?
    
    /// Array of action buttons in a view.
    public var buttons: [SYUIActionButton] = [SYUIActionButton]() {
        didSet {
            updateLayout()
        }
    }
    
    /// Stack of action buttons.
    public private(set) var buttonsStack = UIStackView()
    
    // MARK: - Private Properties
    
    private var buttonsMargin: CGFloat = 16.0
    private var edgeInsets = UIEdgeInsets(top: 20.0, left: 8.0, bottom: 0, right: -8.0)
    private var topConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?
    private var leftConstraint: NSLayoutConstraint?
    private var rightConstraint: NSLayoutConstraint?
    
    // MARK: - Public Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods.
    
    private func updateLayout() {
        buttonsStack.removeAll()
        buttonsStack.spacing = buttonsMargin
        
        buttons.forEach { button in
            buttonsStack.addArrangedSubview(button)
            button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        }
        
        topConstraint?.constant = edgeInsets.top
        bottomConstraint?.constant = edgeInsets.bottom
        leftConstraint?.constant = edgeInsets.left
        rightConstraint?.constant = edgeInsets.right
        superview?.layoutIfNeeded()
    }
    
    private func setup() {
        backgroundColor = .bar
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        buttonsStack.alignment = .fill
        buttonsStack.axis = .vertical
        addSubview(buttonsStack)
        
        leftConstraint = buttonsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        leftConstraint?.isActive = true
        
        rightConstraint = buttonsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        rightConstraint?.isActive = true
        
        topConstraint = buttonsStack.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        topConstraint?.isActive = true
        
        bottomConstraint = buttonsStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        bottomConstraint?.isActive = true
    }
    
    @objc private func buttonPressed(sender:SYUIActionButton) {
        if let index = buttonsStack.arrangedSubviews.index(of: sender) {
            delegate?.actionButtonPressed(sender, at: index)
        }
    }
}
