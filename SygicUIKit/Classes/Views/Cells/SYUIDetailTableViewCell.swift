//// SYUIDetailTableViewCell.swift
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


/// Data source used by SYUIDetailTableViewCell to setup icon labels
public struct SYUIDetailCellIconDataSource {
    /// icon from SYUIIcon
    public let icon: String
    /// icon color
    public let color: UIColor?
    /// icon background color
    public let backgroundColor: UIColor?
    
    public init(icon: String, color: UIColor?, backgroundColor: UIColor?) {
        self.icon = icon
        self.color = color
        self.backgroundColor = backgroundColor
    }
}

/// Data source protocol needed for proper setup SYUIDetailTableViewCell
public protocol SYUIDetailCellDataSource {
    /// cell height
    var height: CGFloat { get }
    /// attributed title
    var title: NSMutableAttributedString? { get }
    /// optional attributed subtitle
    var subtitle: NSMutableAttributedString? { get }
    /// optional left icon attributes
    var leftIcon: SYUIDetailCellIconDataSource? { get }
    /// optional right icon attributes
    var rightIcon: SYUIDetailCellIconDataSource? { get }
    /// background color
    var backgroundColor: UIColor? { get }
}

extension SYUIDetailCellDataSource {
    /// default attributes for detail cell title label
    public static var defaultTitleAttributes: [NSAttributedString.Key: Any] {
        return [.foregroundColor: UIColor.textTitle,
                .font: SYUIFont.with(SYUIFont.semiBold, size: SYUIFontSize.headingOld)!]
    }
    
    /// default attributes for detail cell subtitle label
    public static var defaultSubtitleAttributes: [NSAttributedString.Key: Any] {
        return [.foregroundColor: UIColor.textBody,
                .font: SYUIFont.with(SYUIFont.regular, size: SYUIFontSize.bodyOld)!]
    }
}


/// Standard UITableViewCell with default titleLabel, subtitleLabel, left and right icons. Fully customizable by SYUIDetailCellDataSource attributes
public class SYUIDetailTableViewCell: UITableViewCell {

    /// name of xib defining SYUIDetailTableViewCell layout
    public static let nibName: String = "SYUIDetailTableViewCell"
    
    //MARK: - Private properties
    
    @IBOutlet weak private var title: UILabel!
    @IBOutlet weak private var subtitle: UILabel!
    @IBOutlet weak private var leftIcon: UILabel!
    @IBOutlet weak private var rightIcon: UILabel!
    @IBOutlet weak private var leftIconWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak private var leftIconHeightConstraint: NSLayoutConstraint!
    
    //MARK: - Public methods
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        // Highlighting in this cell remain done by standard selectedBackgroundView because animation on highlightingView (FadingHighlightedBackgroundView) is too fast Dashboard and SearchResultsSheetView
        selectedBackgroundView = UIView()
    }
    
    public override func layoutSubviews() {
        leftIcon.layoutIfNeeded()
        leftIcon.fullRoundCorners()
        leftIcon.layer.masksToBounds = true
        let isLeftIconHidden = leftIcon.text == nil
        leftIcon.isHidden = isLeftIconHidden
        leftIconWidthConstraint?.isActive = !isLeftIconHidden
        leftIconHeightConstraint?.isActive = !isLeftIconHidden
        rightIcon.isHidden = rightIcon.text == nil
        
        super.layoutSubviews()
    }
    
    /// UITableViewCell default implementation changes all labels background color when selected or highlighted is true
    override public func setSelected(_ selected: Bool, animated: Bool) {
        let leftIconBackgroundColor = leftIcon.backgroundColor
        let rightIconBackgroundColor = rightIcon.backgroundColor

        super.setSelected(selected, animated: animated)

        leftIcon.backgroundColor = leftIconBackgroundColor
        rightIcon.backgroundColor = rightIconBackgroundColor
    }
    
    public override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let leftIconBackgroundColor = leftIcon.backgroundColor
        let rightIconBackgroundColor = rightIcon.backgroundColor

        super.setHighlighted(highlighted, animated: animated)

        leftIcon.backgroundColor = leftIconBackgroundColor
        rightIcon.backgroundColor = rightIconBackgroundColor
    }
    
    public func setup(with cellViewModel: SYUIDetailCellDataSource) {
        backgroundColor = cellViewModel.backgroundColor
        
        title.attributedText = cellViewModel.title
        subtitle.attributedText = cellViewModel.subtitle
        setup(iconLabel: leftIcon, from: cellViewModel.leftIcon)
        setup(iconLabel: rightIcon, from: cellViewModel.rightIcon)
        
        let heightAnchor = contentView.heightAnchor.constraint(equalToConstant: cellViewModel.height)
        heightAnchor.priority = UILayoutPriority(rawValue: 750)
        heightAnchor.isActive = true

        if let backgroundColor = backgroundColor {
            let multiplier = SYUIColorSchemeManager.shared.brightnessMultiplier(for: backgroundColor, foregroundColor: title.textColor)
            selectedBackgroundView?.backgroundColor = backgroundColor.adjustBrightness(with: multiplier)
        }
    }
    
    public func updateSubtitle(with text: NSAttributedString) {
        subtitle.attributedText = text
    }
    
    public func hideRightIcon() {
        rightIcon.text = nil
    }
    
    public func addGestureRecognizerForRightIcon(gesture: UIGestureRecognizer, tag: Int) {
        rightIcon.tag = tag
        rightIcon.isUserInteractionEnabled = true
        rightIcon.addGestureRecognizer(gesture)
    }
    
    //MARK: - Private methods
    
    private func setup(iconLabel: UILabel, from cellIconData: SYUIDetailCellIconDataSource?) {
        iconLabel.text = cellIconData?.icon
        iconLabel.textColor = cellIconData?.color
        iconLabel.backgroundColor = cellIconData?.backgroundColor
    }
}
