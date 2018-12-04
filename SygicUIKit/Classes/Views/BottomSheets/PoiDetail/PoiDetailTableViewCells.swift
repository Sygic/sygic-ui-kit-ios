import UIKit

@objc public enum PoiDetailCellActionType: Int {
    case action
    case removeAction
    case disabled
}

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

public protocol SYUIPoiDetailCellDataSource {
    var title: String { get }
    var subtitle: String? { get }
    var icon: String? { get }
    var actionType: PoiDetailCellActionType { get }
    var stringToCopy: String? { get }
}

class PoiDetailTableViewCell: UITableViewCell {
    
    fileprivate let iconSize: CGFloat = 36.0
    
    fileprivate let titleLabel = UILabel()
    fileprivate let iconLabel = UILabel()
    
    private var stringToCopy = ""
    
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
    
    fileprivate func createLayout() {
        setupHighlightingView()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = SygicFonts.with(SygicFonts.regular, size:SygicFontSize.headingOld)
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
        iconLabel.font = SygicFonts.iconFontWith(size: 18.0)
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
        //    [SygicAnalytics infinarioTrackPoiDetailAction:ATTR_VALUE_DETAIL_ACTION_GPS_COORD_COPY andSearchResult:nil];
    }
}


class PoiDetailSubtitleTableViewCell: PoiDetailTableViewCell {
    
    private let subtitleLabel = UILabel()
        
    override fileprivate func createLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = SygicFonts.with(SygicFonts.regular, size:SygicFontSize.bodyOld)
        titleLabel.textColor = .action
        contentView.addSubview(titleLabel)
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = SygicFonts.with(SygicFonts.regular, size:SygicFontSize.headingOld)
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
