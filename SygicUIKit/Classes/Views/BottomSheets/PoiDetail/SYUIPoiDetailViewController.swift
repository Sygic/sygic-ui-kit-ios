import Foundation


/// Protocol for PoiDetail data source
public protocol SYUIPoiDetailDataSource: class {
    /// Returns space in points between expanded poi detail view and top of the screen (default == 0)
    var poiDetailMaxTopOffset: CGFloat { get }
    
    var poiDetailTitle: String { get }
    var poiDetailSubtitle: String? { get }
    
    /// Returns number of SYUIActionButtons that appears above poi detail content data (default == 0)
    var poiDetailNumberOfActionButtons: Int { get }
    /// Implement if number of action buttons returns more than 0
    func poiDetailActionButton(for index: Int) -> SYUIActionButton
    /// Returns number of poi detail data rows
    func poiDetailNumberOfRows(in section: SYUIPoiDetailSectionType) -> Int
    /// Custom Poi detail row data
    func poiDetailCellData(for indexPath: IndexPath) -> SYUIPoiDetailCellDataSource
}

public extension SYUIPoiDetailDataSource {
    var poiDetailMaxTopOffset: CGFloat { return 0 }
    var poiDetailNumberOfActionButtons: Int { return 0 }
    func poiDetailActionButton(for index: Int) -> SYUIActionButton { return SYUIActionButton() }
}

/// Protocol for PoiDetail delegate
public protocol SYUIPoiDetailDelegate: class {
    func poiDetailDidPressActionButton(at index: Int)
    func poiDetailDidSelectCell(at indexPath: IndexPath)
}

/// PoiDetail view controller
open class SYUIPoiDetailViewController: UIViewController {
    
    // MARK: - Public Properties
    
    /// Data source
    public weak var dataSource: SYUIPoiDetailDataSource? {
        didSet {
            reloadData()
        }
    }
    /// Delegate
    public weak var delegate: SYUIPoiDetailDelegate?
    
    /// Visible height of PoiDetailView when minimized (without action buttons)
    public var defaultMinimizedHeight: CGFloat = 122
    
    // MARK: - Private Properties
    
    private var bottomSheetView: SYUIBottomSheetView!
    private let poiDetailView = SYUIPoiDetailView()
    
    // MARK: - Public Methods
    
    open override func loadView() {
        bottomSheetView = SYUIBottomSheetView()
        bottomSheetView.sheetDelegate = self
        
        view = bottomSheetView
        
        poiDetailView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(poiDetailView)
        poiDetailView.coverWholeSuperview()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dataSource = dataSource {
            bottomSheetView.minimizedHeight = defaultMinimizedHeight + (SYUIActionButtonSize.normal.rawValue * CGFloat(dataSource.poiDetailNumberOfActionButtons))
        }
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        poiDetailView.delegate = self
        poiDetailView.tableView.panGestureRecognizer.isEnabled = bottomSheetView.isFullViewVisible
    }
    
    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_:UIViewControllerTransitionCoordinatorContext) in
            self.bottomSheetView.superviewWillTransition(to: size, with: coordinator)
        }, completion: nil)
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    /// Reload data from poi detail dataSurce
    open func reloadData() {
        guard let dataSource = dataSource, view == bottomSheetView else { return }
        bottomSheetView.minTopMargin = dataSource.poiDetailMaxTopOffset
        poiDetailView.reloadData()
    }
    
    // MARK: presentation handling
    
    /// Presents poiDetail controller as childViewController from presentingViewController
    ///
    /// - Parameters:
    ///   - presentingViewController: presenting view controller (parentViewController)
    ///   - bounce: adds bounce effect to presenting animation if true (default == false)
    ///   - completion: completion block called when presenting animations are finished
    public func presentPoiDetailAsChildViewController(to presentingViewController: UIViewController, bounce: Bool = false, completion: ((_ finished: Bool)->())?) {
        guard let bottomSheetView = view as? SYUIBottomSheetView else {
            completion?(false)
            return
        }
        presentingViewController.addChildViewController(self)
        presentingViewController.view.addSubview(view)
        bottomSheetView.animateIn(bounce: bounce) {
            completion?(true)
        }
    }
    
    /// Dismiss poiDetail controller and removes him from parentViewController
    ///
    /// - Parameter completion: completion block
    public func dismissPoiDetail(completion: ((_ finished: Bool)->())?) {
        guard let bottomSheetView = view as? SYUIBottomSheetView else {
            completion?(false)
            return
        }
        bottomSheetView.animateOut {
            self.removeFromParentViewController()
            completion?(true)
        }
    }
}

// MARK: - BottomSheetView delegate

extension SYUIPoiDetailViewController: BottomSheetViewDelegate {
    public func bottomSheetCanMove() -> Bool {
        if poiDetailView.tableView.contentOffset.y <= 0 {
            if poiDetailView.tableView.panGestureRecognizer.isEnabled {
                poiDetailView.tableView.panGestureRecognizer.isEnabled = false
                poiDetailView.tableView.contentOffset = .zero
            }
            return true
        }
        return false
    }
    
    public func bottomSheetWillAnimate(_ bottomSheetView: SYUIBottomSheetView, to offset: CGFloat, with duration: TimeInterval) {
        if offset == bottomSheetView.minOffset {
            poiDetailView.tableView.panGestureRecognizer.isEnabled = true
        }
    }
}

// MARK: - PoiDetailView protocol

extension SYUIPoiDetailViewController: SYUIPoiDetailViewProtocol {
    public func poiDetailNumberOfRows(in section: SYUIPoiDetailSectionType) -> Int {
        return dataSource?.poiDetailNumberOfRows(in: section) ?? 0
    }
    
    public func poiDetailCellData(for indexPath: IndexPath) -> SYUIPoiDetailCellDataSource {
        return dataSource?.poiDetailCellData(for: indexPath) ?? SYUIPoiDetailCellData(title: "")
    }
    
    
    public var poiDetailHeaderCellData: SYUIPoiDetailHeaderDataSource {
        guard let dataSource = dataSource else { return SYUIPoiDetailHeaderData(title: "", subtitle: nil) }
        return SYUIPoiDetailHeaderData(title: dataSource.poiDetailTitle, subtitle: dataSource.poiDetailSubtitle)
    }
    
    public var poiDetailButtons: [SYUIActionButton] {
        let count = dataSource?.poiDetailNumberOfActionButtons ?? 0
        var buttons: [SYUIActionButton] = []
        for index in 0..<count {
            guard let button = dataSource?.poiDetailActionButton(for: index) else { continue }
            buttons.append(button)
        }
        return buttons
    }
    
    public func poiDetailDidPressActionButton(at index: Int) {
        delegate?.poiDetailDidPressActionButton(at: index)
    }
    
    public func poiDetailDidSelectRow(at indexPath: IndexPath) {
        if indexPath.section == SYUIPoiDetailSectionType.header.rawValue {
            if bottomSheetView.isFullViewVisible {
                bottomSheetView.minimize()
            } else {
                bottomSheetView.expand()
            }
        }
        delegate?.poiDetailDidSelectCell(at: indexPath)
    }
    
}
