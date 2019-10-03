//// SYUIBubbleContentActionButton.swift
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


public class SYUIBubbleContentActionButton: UIControl {
    
    //MARK: Public properties
    
    public typealias Action = (_ sender: SYUIBubbleContentActionButton)->()
    
    /// "On tap" action block
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
    
    /// Icon image view
    public let imageView = UIImageView()
    
    /// Title label
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.font = SYUIFont.with(.regular, size: SYUIFontSize.bodyOld)
        return label
    }()
    
    //MARK: Private properties
    
    private var margin: CGFloat { SYUIBubbleView.margin }
    private let originalBackgroundColor: UIColor = .veryLightPink
    
    //MARK: Public methods
    
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
    
    //MARK: Private methods
    
    @objc private func tapAction() {
        action?(self)
    }
}
