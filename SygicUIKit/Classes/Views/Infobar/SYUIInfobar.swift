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

/// TODO: neviem ci SYUIInfobarView nie je lepsie
public class SYUIInfobar: UIView {
    
    // MARK: - Public Properties
    
    public var leftButton: SYUIActionButton? {
        didSet {
            updateLayout()
        }
    }
    
    public var rightButton: SYUIActionButton? {
        didSet {
            updateLayout()
        }
    }
    /// Max 3
    public var items: [UIView] = [] {
        didSet {
            updateLayout()
        }
    }
    
    public var edgeMargin: CGFloat = 8
    public let maxItemCount: Int = 3
    
    // MARK: - Private Properties
    
    private let stackView = UIStackView()
    
    // MARK: - Public Methods
    
    convenience init() {
        self.init(frame: .zero)
        heightAnchor.constraint(equalToConstant: 72).isActive = true
        backgroundColor = .bar
        roundCorners()
        
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.layoutMargins = UIEdgeInsets(top: edgeMargin, left: edgeMargin, bottom: edgeMargin, right: edgeMargin)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.coverWholeSuperview()
    }
    
    // MARK: - Private Methods
    
    private func updateLayout() {
        stackView.removeAll()
        
        if let left = leftButton {
            stackView.addArrangedSubview(left)
        }
        for (index, item) in items.enumerated() {
            guard index < maxItemCount else { break }
            stackView.addArrangedSubview(item)
        }
        if let right = rightButton {
            stackView.addArrangedSubview(right)
        }
    }
}

open class SYUIInfobarItem: UIView {
    public var text: String? {
        didSet {
            label.text = text
        }
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = SYUIFont.with(SYUIFont.semiBold, size: SYUIFontSize.heading)
        label.textColor = .textTitle
        label.textAlignment = .center
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.coverWholeSuperview()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
