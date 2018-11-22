import UIKit
import GradientView

///Button types of poiDetailView's main buttons
public enum SYUIPoiDetailActionButtonType {
    /// start route compute
    case getDirection
    /// adds waypoint to computet route
    case addWaypoint
    /// removes waypoint from route
    case removeWaypoint
    /// adds favorite of injected favoriteType
    case addFavorite
    /// updates HomeWork address
    case updateHomeWork
    /// adds waypoint to route planner
    case addToRoute
    /// replace waypoint to route planner
    case selectPoi
    case none
}

public protocol SYUIPoiDetailViewProtocol: class {
    var addressCellViewModel: SYUIPoiDetailAddressDataSource { get }
    var contactInfosViewModels: [PoiDetailCellDataSource] { get }
    var actionCellsViewModels: [PoiDetailCellDataSource] { get }
    var buttonsViewModel: SYUIActionButtonsViewModel { get }
    
    func didPressActionButton(at index: Int)
    func didSelectRow(at indexPath: IndexPath)
}

public enum SYUIPoiDetailSectionType: Int {
    case address
//    case parking
//    case openingHours
    case contactInfo
    case actions
    
    static let count = 3
}

internal class SYUIPoiDetailView: UIView {

    public let addressCellBottomScreenOffset: CGFloat = 6.0
    public let actionButtonsView = SYUIActionButtonsView()
    public let tableView = UITableView()
    public var tapAddressAction: (() -> Void)?
    
    public var addressHeight: CGFloat {
        if let addressCell = tableView.cellForRow(at: IndexPath(row: 0, section: Int(SYUIPoiDetailSectionType.address.rawValue))) {
            return addressCell.frame.size.height
        }
        return 0
    }
    
    public weak var viewModel: SYUIPoiDetailViewProtocol? {
        didSet {
            reloadData()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 20))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func reloadData() {
        guard let viewModel = viewModel else { return }
        actionButtonsView.update(with: viewModel.buttonsViewModel)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 20))
        tableView.reloadData()
    }
    
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

        tableView.register(PoiDetailAddressCell.self, forCellReuseIdentifier: NSStringFromClass(PoiDetailAddressCell.self))
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

//        ColorSchemeManager.sharedInstance.currentColorScheme.asDriver().drive(onNext: { (colorScheme) in
            gradient.colors = [UIColor.bar, UIColor.bar.withAlphaComponent(0.0)]
//        }).disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDataSource
extension SYUIPoiDetailView: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return SYUIPoiDetailSectionType.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel, let section = SYUIPoiDetailSectionType(rawValue: section) else { return 0 }
        switch section {
        case .address:
            return 1
//        case .parking, .openingHours:
//            return 0
        case .contactInfo:
            return viewModel.contactInfosViewModels.count
        case .actions:
            return viewModel.actionCellsViewModels.count
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = SYUIPoiDetailSectionType(rawValue: indexPath.section), let viewModel = viewModel else {
            return PoiDetailTableViewCell()
        }
        switch section {
        case .address:
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PoiDetailAddressCell.self)) as! PoiDetailAddressCell
            cell.update(with: viewModel.addressCellViewModel)
            return cell
//        case .parking:
//            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PoiDetailTableViewCell.self)) as! PoiDetailTableViewCell
////            cell.update(with: viewModel.addressCellViewModel())
//            return cell
//        case .openingHours:
//            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PoiDetailTableViewCell.self)) as! PoiDetailTableViewCell
////            cell.update(with: viewModel.addressCellViewModel())
//            return cell
        case .contactInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PoiDetailSubtitleTableViewCell.self)) as! PoiDetailSubtitleTableViewCell
            cell.update(with: viewModel.contactInfosViewModels[indexPath.row])
            return cell
        case .actions:
            var cell: PoiDetailTableViewCell
            if !viewModel.actionCellsViewModels[indexPath.row].subtitle.isEmpty {
                let copyGPSCoordinatesRecognizer = UILongPressGestureRecognizer.init(target: self, action: #selector(copyCoordinatesLongRecognized(recognizer:)))
                cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PoiDetailSubtitleTableViewCell.self)) as! PoiDetailSubtitleTableViewCell
                cell.addGestureRecognizer(copyGPSCoordinatesRecognizer)
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PoiDetailTableViewCell.self)) as! PoiDetailTableViewCell
            }
            cell.update(with: viewModel.actionCellsViewModels[indexPath.row])
            return cell
        }
    }
    
    @objc private func copyCoordinatesLongRecognized(recognizer: UILongPressGestureRecognizer){
        showCopyGpsContextMenu()
    }
}

// MARK: - UITableViewDelegate
extension SYUIPoiDetailView: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let rows = tableView.dataSource?.tableView(tableView, numberOfRowsInSection: section), rows > 0, let section = SYUIPoiDetailSectionType(rawValue: section) else { return 0 }
        switch section {
        
        case .address:
            return 0
        case .contactInfo, .actions:
            return 20.0
//        case .parking, .openingHours:
//            return 20.0
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
        
        case .address, .contactInfo, .actions:
            return true
//        case .parking:
//            return true
//        case .openingHours:
//            return false
        }
        
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        guard let viewModel = viewModel, let section = PoiDetailSectionType(rawValue: indexPath.section) else { return }
//
//        switch section {
//        case .address:
//            tapAddressAction?()
////        case .parking:
////            viewModel.parkingTapped()
//        case .actions:
//            guard let action = PoiDetailRowAction(rawValue: indexPath.row) else { return }
//            didSelectAction(action)
//        case .contactInfo:
//            if indexPath.row == 0 && viewModel.isContactPhoneAvailable() {
//                viewModel.call()
//            } else if (0...1).contains(indexPath.row) && viewModel.isContactMailAvailable() {
//                viewModel.sendMail()
//            } else if viewModel.isContactWebAvailable() {
//                viewModel.openWebpage()
//            }
//        default:
//            break
//        }
        viewModel?.didSelectRow(at: indexPath)
    }
    
//    func didSelectAction(_ action: PoiDetailRowAction) {
//        switch action {
//        case .favorite:
//            viewModel?.favoriteTapped()
//            tableView.reloadData()
////        case .shareLocation:
////            viewModel.shareLocation()
////        case .streetView:
////            viewModel.showStreetView()
//        case .copyGpsCoordinates:
//            if let formatedCoordinates = viewModel?.coordinates.formattedString {
//                viewModel?.delegate?.showShareCoordinatesDialog(textToShare: formatedCoordinates)
//            }
//        }
//    }
//
    func showCopyGpsContextMenu() {
//        let indexPath = IndexPath(row: PoiDetailRowAction.copyGpsCoordinates.rawValue, section: PoiDetailSectionType.actions.rawValue)
//        guard let gpsCell = tableView.cellForRow(at: indexPath), !UIMenuController.shared.isMenuVisible else { return }
//        let menu = UIMenuController.shared
//
//        gpsCell.becomeFirstResponder()
//        menu.update()
//
//        let menuRect = tableView.rectForRow(at: indexPath)
//        menu.setTargetRect(menuRect, in: tableView)
//        menu.setMenuVisible(true, animated: true)
    }
}

// MARK: - ActionButtonsDelegate
extension SYUIPoiDetailView: SYUIActionButtonsDelegate {
    public func actionButtonPressed(_ button: SYUIActionButton, at index: Int) {
        if let viewModel = viewModel {
            viewModel.didPressActionButton(at: index)
        }
    }
}
