//// SYUIErrorMessageView.swift
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


/// Simple view with icon and message label suitable for showing error message within search results table
public class SYUIErrorMessageView: UIView {
    public var text: String? {
        didSet {
            titleLabel.text = text
        }
    }
    
    public let iconLabel = UILabel()
    public let titleLabel = UILabel()
    
    private let iconSize: CGFloat = 36.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupIconLabel()
        setupTitleLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupIconLabel() {
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        iconLabel.font = SYUIFont.iconFontWith(size: iconSize)
        iconLabel.textAlignment = .center
        iconLabel.textColor = .textBody
        iconLabel.backgroundColor = .iconBackground
        iconLabel.clipsToBounds = true
        iconLabel.text = SYUIIcon.search
        iconLabel.layer.cornerRadius = iconSize
        
        addSubview(iconLabel)
        
        let constraintsToActivate = [iconLabel.widthAnchor.constraint(equalToConstant: iconSize * 2),
                                     iconLabel.heightAnchor.constraint(equalToConstant: iconSize * 2),
                                     iconLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     iconLabel.topAnchor.constraint(equalTo: safeTopAnchor, constant: 0)]
        NSLayoutConstraint.activate(constraintsToActivate)
    }
    
    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = SYUIFont.with(.semiBold, size: SYUIFontSize.heading)
        titleLabel.textColor = .textTitle
        titleLabel.numberOfLines = 3
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byTruncatingMiddle
        titleLabel.sizeToFit()
        
        addSubview(titleLabel)
        
        let constraintsToActivate = [titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     titleLabel.leadingAnchor.constraint(lessThanOrEqualTo: safeLeadingAnchor, constant: 12),
                                     titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeTrailingAnchor, constant: -12),
                                     titleLabel.topAnchor.constraint(equalTo: iconLabel.bottomAnchor, constant: 13.0),
                                     titleLabel.bottomAnchor.constraint(equalTo: safeBottomAnchor, constant: 0)]
        NSLayoutConstraint.activate(constraintsToActivate)
    }
}
