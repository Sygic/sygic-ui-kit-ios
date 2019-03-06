//// PoiDetailTableViewCells.swift
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


/// Poi detail cell action types
@objc public enum PoiDetailCellActionType: Int {
    /// standard cell type
    case action
    /// remove action style cell type
    case removeAction
    /// disabled action cell type
    case disabled
}

/// Protocol for Poi detail cell data source
public protocol SYUIPoiDetailCellDataSource {
    var title: String { get }
    var subtitle: String? { get }
    var icon: String? { get }
    /// Cell action type that defines cell visual style
    var actionType: PoiDetailCellActionType { get }
    /// String that is provided for context menu action 'Copy'
    var stringToCopy: String? { get }
}

/// Poi detail cell data source
public struct SYUIPoiDetailCellData: SYUIPoiDetailCellDataSource {
    
    public var title: String
    public var subtitle: String?
    public var icon: String?
    public var actionType: PoiDetailCellActionType = .action
    public var stringToCopy: String?
    
    public init(title: String, subtitle: String? = nil, icon: String? = nil, actionType: PoiDetailCellActionType = .action, stringToCopy: String? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.actionType = actionType
        self.stringToCopy = stringToCopy
    }
    
}

/// Poi detail table view cell
class PoiDetailTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    fileprivate let iconSize: CGFloat = 36.0
    
    fileprivate let titleLabel = UILabel()
    fileprivate let iconLabel = UILabel()
    
    private var stringToCopy = ""
    
    // MARK: - Public Methods
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createLayout()
        createConstraints()
        createAccessoryIconLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconLabel.fullRoundCorners()
    }
    
    public override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let iconBackgroundColor = iconLabel.backgroundColor
        
        super.setHighlighted(highlighted, animated: animated)
        
        iconLabel.backgroundColor = iconBackgroundColor
        
        highlightCell(highlighted, backgroundColor: backgroundColor, foregroundColor: titleLabel.textColor)
    }
    
    /// Update cell with data form data source
    ///
    /// - Parameter cellData: data source
    public func update(with cellData: SYUIPoiDetailCellDataSource) {
        backgroundColor = .background
        
        switch (cellData.actionType) {
        case .action:
            setDefaultColors()
        case .removeAction:
            setDefaultColorsForRemovingActionState()
        case .disabled:
            setDefaultColorsForInactiveState()
        }
        titleLabel.text = cellData.title
        iconLabel.text = cellData.icon
        stringToCopy = cellData.stringToCopy ?? ""
    }
    
    // MARK: - Private Methods
    
    fileprivate func createLayout() {
        setupHighlightingView()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = SYUIFont.with(SYUIFont.regular, size:SYUIFontSize.headingOld)
        titleLabel.textColor = .action
        contentView.addSubview(titleLabel)
    }
    
    fileprivate func createConstraints() {
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(24)-[title]-(65)-|", options: [], metrics: nil, views: ["title": titleLabel]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(14)-[title]-(15)-|", options: [], metrics: nil, views: ["title": titleLabel]))
    }
    
    private func setDefaultColors() {
        titleLabel.textColor = .action
        iconLabel.textColor = .action
        iconLabel.backgroundColor = .iconBackground
    }
    
    private func setDefaultColorsForInactiveState() {
        titleLabel.textColor = .textBody
        iconLabel.textColor = .textBody
        iconLabel.backgroundColor = .iconBackground
    }
    
    private func setDefaultColorsForRemovingActionState() {
        titleLabel.textColor = .error
        iconLabel.textColor = .error
        iconLabel.backgroundColor = .iconBackground
    }
    
    private func createAccessoryIconLabel() {
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        iconLabel.font = SYUIFont.iconFontWith(size: 18.0)
        setDefaultColors()
        iconLabel.clipsToBounds = true
        iconLabel.textAlignment = .center
        contentView.addSubview(iconLabel)
        
        iconLabel.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        iconLabel.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        iconLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:[icon]-(8)-|", options: [], metrics: nil, views: ["icon": iconLabel]))
        layoutIfNeeded()
    }
}

//MARK: - Copy

extension PoiDetailTableViewCell {
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) {
            return true
        }
        return false
    }
    
    override func copy(_ sender: Any?) {
        let pasteBoard = UIPasteboard.general
        pasteBoard.string = stringToCopy
    }
}


/// Poi detail table view cell with subtitle label
class PoiDetailSubtitleTableViewCell: PoiDetailTableViewCell {
    
    private let subtitleLabel = UILabel()
        
    override fileprivate func createLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = SYUIFont.with(SYUIFont.regular, size:SYUIFontSize.bodyOld)
        titleLabel.textColor = .action
        contentView.addSubview(titleLabel)
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = SYUIFont.with(SYUIFont.regular, size:SYUIFontSize.headingOld)
        subtitleLabel.textColor = .textBody
        contentView.addSubview(subtitleLabel)
    }
    
    override fileprivate func createConstraints() {
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(24)-[title]-(65)-|", options: [], metrics: nil, views: ["title": titleLabel]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(24)-[subtitle]-(65)-|", options: [], metrics: nil, views: ["subtitle": subtitleLabel]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(13)-[title]-(2)-[subtitle]-(11)-|", options: [], metrics: nil, views: ["title": titleLabel, "subtitle": subtitleLabel]))
    }
    
    override public func update(with cellData: SYUIPoiDetailCellDataSource) {
        super.update(with: cellData)
        subtitleLabel.text = cellData.subtitle
        subtitleLabel.textColor = .textBody
    }
}
