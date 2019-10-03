//// SYUIBubbleHeader.swift
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

import Foundation


public class SYUIBubbleHeader: UIStackView {
    
    //MARK: Public properties
    
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
    
    //MARK: Public methods
    
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

public class SYUIBubbleLoadingHeader: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        let spinny = UIActivityIndicatorView(style: .gray)
        spinny.translatesAutoresizingMaskIntoConstraints = false
        addSubview(spinny)
        spinny.centerInSuperview()
        spinny.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
