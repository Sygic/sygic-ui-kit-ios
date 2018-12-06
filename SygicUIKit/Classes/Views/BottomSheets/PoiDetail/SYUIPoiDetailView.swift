import UIKit
import GradientView

public enum SYUIPoiDetailSectionType: Int {
    case header
    case contactInfo
    case actions
    
    static let count = 3
}

public protocol SYUIPoiDetailViewProtocol: class {
    var poiDetailButtons: [SYUIActionButton] { get }
    var poiDetailHeaderCellData: SYUIPoiDetailHeaderDataSource { get }
    
    func poiDetailNumberOfRows(in section: SYUIPoiDetailSectionType) -> Int
    func poiDetailCellData(for indexPath: IndexPath) -> SYUIPoiDetailCellDataSource
    func poiDetailDidPressActionButton(at index: Int)
    func poiDetailDidSelectRow(at indexPath: IndexPath)
}

class SYUIPoiDetailView: UIView {
    
    // MARK: - Public Properties

    public let addressCellBottomScreenOffset: CGFloat = 6.0
    public let actionButtonsView = SYUIActionButtonsView()
    public let tableView = UITableView()
    
    public var headerHeight: CGFloat {
        if let headerCell = tableView.cellForRow(at: IndexPath(row: 0, section: Int(SYUIPoiDetailSectionType.header.rawValue))) {
            return headerCell.frame.size.height
        }
        return 0
    }
    
    public weak var delegate: SYUIPoiDetailViewProtocol? {
        didSet {
            reloadData()
        }
    }
    
    // MARK: - Public Methods
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 20))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func reloadData() {
        guard let delegate = delegate else { return }
        actionButtonsView.buttons = delegate.poiDetailButtons
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 20))
        tableView.reloadData()
    }
    
    // MARK: - Private Methods
    
    private func createUI() {
        setupActionButtonsView()
        setupTableView()
        setupGradientView()
        
        actionButtonsView.delegate = self
        bringSubview(toFront: actionButtonsView)
        
        backgroundColor = .bar
        actionButtonsView.backgroundColor = .bar
        tableView.separatorColor = .border
        tableView.backgroundColor = .background
    }
    
    private func setupActionButtonsView() {
        // TODO:
//        ColorSchemeManager.sharedInstance.currentColorScheme.asDriver().drive(onNext: { [unowned self] (colorScheme) in
//            self.actionButtonsView.backgroundColor = .bar
//            self.backgroundColor = .bar
//        }).disposed(by: disposeBag)
        
        actionButtonsView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(actionButtonsView)
        actionButtonsView.leadingAnchor.constraint(equalTo: safeLeadingAnchor).isActive = true
        actionButtonsView.trailingAnchor.constraint(equalTo: safeTrailingAnchor).isActive = true
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[actionButtonsView]", options: .alignAllCenterX, metrics: nil, views: ["actionButtonsView":actionButtonsView]))
    }
    
    private func setupTableView() {
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsetsMake(0, 24, 0, 0)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        addSubview(tableView)

        // TODO:
//        ColorSchemeManager.sharedInstance.currentColorScheme.asDriver().drive(onNext: { [unowned self] (colorScheme) in
//            self.tableView.separatorColor = .border
//            self.tableView.backgroundColor = .background
//            self.tableView.reloadData()
//        }).disposed(by: disposeBag)

        tableView.register(PoiDetailHeaderCell.self, forCellReuseIdentifier: NSStringFromClass(PoiDetailHeaderCell.self))
        tableView.register(PoiDetailTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(PoiDetailTableViewCell.self))
        tableView.register(PoiDetailSubtitleTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(PoiDetailSubtitleTableViewCell.self))
        tableView.register(PoiDetailSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: NSStringFromClass(PoiDetailSectionHeaderView.self))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.accessibilityIdentifier = "PoiDetailView.tableView"
        
        let bindings = ["actionButtonsView": actionButtonsView, "tableView": tableView]
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: .alignAllCenterY, metrics: nil, views: bindings))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:[actionButtonsView][tableView]|", options: .alignAllCenterX, metrics: nil, views: bindings))
    }
    
    private func setupGradientView() {
        let gradient = GradientView()
        gradient.translatesAutoresizingMaskIntoConstraints = false
        gradient.backgroundColor = UIColor.clear
        gradient.locations = [0, 1]
        addSubview(gradient)
        let bindings = ["actionButtonsView":actionButtonsView, "gradient":gradient]
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[gradient]|", options: .alignAllCenterY, metrics: nil, views: bindings))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:[actionButtonsView][gradient(16)]", options: .alignAllCenterX, metrics: nil, views: bindings))

        // TODO:
//        ColorSchemeManager.sharedInstance.currentColorScheme.asDriver().drive(onNext: { (colorScheme) in
            gradient.colors = [UIColor.bar, UIColor.bar.withAlphaComponent(0.0)]
//        }).disposed(by: disposeBag)
    }
    
    private func showCopyContextMenu(from cell: UITableViewCell) {
        guard !UIMenuController.shared.isMenuVisible, let indexPath = tableView.indexPath(for: cell) else { return }
        let menu = UIMenuController.shared
        cell.becomeFirstResponder()
        menu.update()
        let menuRect = tableView.rectForRow(at: indexPath)
        menu.setTargetRect(menuRect, in: tableView)
        menu.setMenuVisible(true, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension SYUIPoiDetailView: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return SYUIPoiDetailSectionType.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let delegate = delegate, let section = SYUIPoiDetailSectionType(rawValue: section) else { return 0 }
        if section == .header {
            return 1
        }
        return delegate.poiDetailNumberOfRows(in: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = SYUIPoiDetailSectionType(rawValue: indexPath.section), let delegate = delegate else {
            return PoiDetailTableViewCell()
        }
        switch section {
        case .header:
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PoiDetailHeaderCell.self)) as! PoiDetailHeaderCell
            cell.update(with: delegate.poiDetailHeaderCellData)
            return cell
        case .contactInfo, .actions:
            let cellData = delegate.poiDetailCellData(for: indexPath)
            
            let cell: PoiDetailTableViewCell
            if let subtitle = cellData.subtitle, !subtitle.isEmpty {
                cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PoiDetailSubtitleTableViewCell.self)) as! PoiDetailSubtitleTableViewCell
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PoiDetailTableViewCell.self)) as! PoiDetailTableViewCell
            }
            cell.update(with: cellData)
            
            if let copyString = cellData.stringToCopy, !copyString.isEmpty {
                let copyRecognizer = UILongPressGestureRecognizer.init(target: self, action: #selector(copyLongpressRecognized(recognizer:)))
                cell.addGestureRecognizer(copyRecognizer)
            }
            
            return cell
        }
    }
    
    @objc private func copyLongpressRecognized(recognizer: UILongPressGestureRecognizer){
        guard recognizer.state == .began, let cell = recognizer.view as? UITableViewCell else { return }
        showCopyContextMenu(from: cell)
    }
}

// MARK: - UITableViewDelegate
extension SYUIPoiDetailView: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let rows = tableView.dataSource?.tableView(tableView, numberOfRowsInSection: section), rows > 0, let section = SYUIPoiDetailSectionType(rawValue: section) else { return 0 }
        switch section {
        
        case .header:
            return 0
        case .contactInfo, .actions:
            return 20.0
        }
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let rows = tableView.dataSource?.tableView(tableView, numberOfRowsInSection: section), rows > 0 {
            return tableView.dequeueReusableHeaderFooterView(withIdentifier: NSStringFromClass(PoiDetailSectionHeaderView.self))
        }
        return nil
    }
    
    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? PoiDetailSectionHeaderView {
            view.backgroundView?.backgroundColor = UIColor.clear
        }
    }
    
    public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        guard let section = SYUIPoiDetailSectionType(rawValue: indexPath.section) else { return false }
        switch section {
        
        case .header, .contactInfo, .actions:
            return true
//        case .parking:
//            return true
//        case .openingHours:
//            return false
        }
        
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.poiDetailDidSelectRow(at: indexPath)
    }

}

// MARK: - ActionButtonsDelegate
extension SYUIPoiDetailView: SYUIActionButtonsDelegate {
    public func actionButtonPressed(_ button: SYUIActionButton, at index: Int) {
        if let delegate = delegate {
            delegate.poiDetailDidPressActionButton(at: index)
        }
    }
}
