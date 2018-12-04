import Foundation

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
    var poiDetailNumberOfActionButtons: Int { return 0}
    func poiDetailActionButton(for index: Int) -> SYUIActionButton { return SYUIActionButton() }
}

public protocol SYUIPoiDetailDelegate: class {
    func poiDetailDidPressActionButton(at index: Int)
    func poiDetailDidSelectCell(at indexPath: IndexPath)
}

public class SYUIPoiDetailViewController: UIViewController {
    
    public weak var dataSource: SYUIPoiDetailDataSource? {
        didSet {
            if let dataSource = dataSource {
                guard view == bottomSheetView else { return }
                bottomSheetView.minTopMargin = dataSource.poiDetailMaxTopOffset
                poiDetailView.reloadData()
            }
        }
    }
    public weak var delegate: SYUIPoiDetailDelegate?
    
    /// visible height of PoiDetailView when minimized (without action buttons)
    public var defaultMinimizedHeight: CGFloat = 122
    
    private var bottomSheetView: SYUIBottomSheetView!
    private let poiDetailView = SYUIPoiDetailView()
    
    override public func loadView() {
        bottomSheetView = SYUIBottomSheetView()
        bottomSheetView.sheetDelegate = self
        if let dataSource = dataSource {
            bottomSheetView.minimizedHeight = defaultMinimizedHeight + (SYUIActionButtonSize.normal.rawValue * CGFloat(dataSource.poiDetailNumberOfActionButtons))
        }
        view = bottomSheetView
        
        poiDetailView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(poiDetailView)
        poiDetailView.coverWholeSuperview()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        poiDetailView.delegate = self
        poiDetailView.tableView.panGestureRecognizer.isEnabled = bottomSheetView.isFullViewVisible
    }
    
    // MARK: presentation handling
    public func presentPoiDetailAsChildViewController(to presentingViewController: UIViewController, completion: ((_ finished: Bool)->())?) {
        guard let bottomSheetView = view as? SYUIBottomSheetView else {
            completion?(false)
            return
        }
        presentingViewController.addChildViewController(self)
        presentingViewController.view.addSubview(view)
        bottomSheetView.animateIn {
            completion?(true)
        }
    }
    
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
