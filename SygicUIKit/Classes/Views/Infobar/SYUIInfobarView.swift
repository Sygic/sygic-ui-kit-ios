//// SYUIInfobar.swift
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


/// Infobar view, ready to display list of SYUIInfobarItemView or custom UIView in two rows and two customizable buttons on both sides of view.
public class SYUIInfobarView: UIView {
    
    // MARK: - Public Properties
    
    /// Action button layouted on the left side of infobar view
    public var leftButton: SYUIActionButton? {
        didSet {
            updateItemsLayout()
        }
    }
    
    /// Action button layouted on the right side of infobar view
    public var rightButton: SYUIActionButton? {
        didSet {
            updateItemsLayout()
        }
    }
    
    /// Primary row items. Appearence is restricted by maxItemCount.
    public var items = [UIView]() {
        didSet {
            updateItemsLayout()
        }
    }
    
    /// Secondary row items with separator between each item. Appearence is restricted by maxItemCount.
    public var secondaryItems = [UIView]() {
        didSet {
            updateItemsLayout()
        }
    }
    
    public var secondaryItemsSeparator: String? = "|"
    
    /// Defines margin between edges and buttons
    public var edgeMargin: CGFloat = 8
    
    /// Max infobar items in one row
    public var maxItemCount: Int = 3
    
    // MARK: - Private Properties
    
    private let height: CGFloat = 64
    private let cornerRadius: CGFloat = 18
    private let backgroundView = UIView()
    private let stackView = UIStackView()
    private let lineStackView = UIStackView()
    private let primaryStackView = UIStackView()
    private let secondaryStackView = UIStackView()
    
    // MARK: - Public Methods
    
    convenience init() {
        self.init(frame: .zero)
        
        backgroundView.backgroundColor = .accentBackground
        backgroundView.layer.cornerRadius = cornerRadius
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundView)
        backgroundView.coverWholeSuperview()
        
        layer.shadowRadius = 8
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.masksToBounds = false
        
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = edgeMargin
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.coverWholeSuperview(withMargin: edgeMargin)
        
        primaryStackView.distribution = .fillEqually
        primaryStackView.alignment = .center
        
        secondaryStackView.distribution = .equalSpacing
        secondaryStackView.alignment = .center
        secondaryStackView.spacing = edgeMargin/2.0
        
        lineStackView.distribution = .equalCentering
        lineStackView.alignment = .center
        lineStackView.axis = .vertical
        lineStackView.addArrangedSubview(primaryStackView)
        lineStackView.addArrangedSubview(secondaryStackView)
    }
    
    // MARK: - Private Methods
    
    private func updateItemsLayout() {
        primaryStackView.removeAll()
        secondaryStackView.removeAll()
        stackView.removeAll()
        
        if !items.isEmpty {
            for (index, item) in items.enumerated() {
                guard index < maxItemCount else { break }
                primaryStackView.addArrangedSubview(item)
            }
            lineStackView.addArrangedSubview(primaryStackView)
        }
        
        if !secondaryItems.isEmpty {
            for (index, item) in secondaryItems.enumerated() {
                guard index < maxItemCount else { break }
                secondaryStackView.addArrangedSubview(item)
                if let separator = secondaryItemsSeparator, index+1 < maxItemCount && index+1 < secondaryItems.count {
                    secondaryStackView.addArrangedSubview(SYUIInfobarSecondaryLabel(with: separator))
                }
            }
            lineStackView.addArrangedSubview(secondaryStackView)
        }
        
        if let left = leftButton {
            stackView.addArrangedSubview(left)
        }
        stackView.addArrangedSubview(lineStackView)
        if let right = rightButton {
            stackView.addArrangedSubview(right)
        }
        lineStackView.alignment = items.count > 1 ? .fill : .center
        setNeedsLayout()
    }
}

public class SYUIInfobarLabel: UILabel {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        font = SYUIFont.with(.semiBold, size: SYUIFontSize.heading)
        textColor = .textTitle
        textAlignment = .center
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public convenience init(with text: String?) {
        self.init(frame: .zero)
        self.text = text
    }
}

public class SYUIInfobarSecondaryLabel: SYUIInfobarLabel {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        font = SYUIFont.with(.semiBold, size: SYUIFontSize.body)
        textColor = .textBody
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
