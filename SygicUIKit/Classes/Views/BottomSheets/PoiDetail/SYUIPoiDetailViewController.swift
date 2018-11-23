import Foundation

public protocol SYUIPoiDetailDataSource: class {
    var poiDetailMaxTopOffset: CGFloat { get }
    var poiDetailTitle: String { get }
    var poiDetailSubtitle: String? { get }
    
    var poiDetailNumberOfActionButtons: Int { get }
    func poiDetailActionButtonProperties(at index: Int) -> SYUIActionButtonProperties?
    func poiDetailNumberOfRows(in section: SYUIPoiDetailSectionType) -> Int
    func poiDetailCellViewModel(for indexPath: IndexPath) -> SYUIPoiDetailCellDataSource
}

public extension SYUIPoiDetailDataSource {
    var poiDetailMaxTopOffset: CGFloat {
        return 0
    }
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
    
    private var bottomSheetView: SYUIBottomSheetView!
    private let poiDetailView = SYUIPoiDetailView()
    
    override public func loadView() {
        bottomSheetView = SYUIBottomSheetView()
        bottomSheetView.sheetDelegate = self
        bottomSheetView.minimizedHeight = 184
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
        poiDetailView.viewModel = self
    }
    
    // MARK: presentation handling
    public func presentPoiDetail(to presentingViewController: UIViewController, completion: ((_ finished: Bool)->())?) {
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
    
    public func bottomSheetDidSwipe(_ bottomSheetView: SYUIBottomSheetView, with delta: CGFloat, to offset: CGFloat) {
//        if offset != bottomSheetView.minOffset {
//            if poiDetailView.tableView.panGestureRecognizer.isEnabled {
//                poiDetailView.tableView.panGestureRecognizer.isEnabled = false
//                poiDetailView.tableView.contentOffset = .zero
//            }
//        }
        
//        if poiDetailView.tableView.contentOffset.y <= 0 {
//            if poiDetailView.tableView.panGestureRecognizer.isEnabled {
//                poiDetailView.tableView.panGestureRecognizer.isEnabled = false
//                poiDetailView.tableView.contentOffset = .zero
//            }
//        }
        
//        poiDetailView.tableView.showsVerticalScrollIndicator = !poiDetailView.tableView.contentOffset.y.isZero
    }
    
    public func bottomSheetWillAnimate(_ bottomSheetView: SYUIBottomSheetView, to offset: CGFloat, with duration: TimeInterval) {
        
    }
}

extension SYUIPoiDetailViewController: SYUIPoiDetailViewProtocol {
    public func numberOfRows(in section: SYUIPoiDetailSectionType) -> Int {
        return dataSource?.poiDetailNumberOfRows(in: section) ?? 0
    }
    
    public func poiDetailCellViewModel(for indexPath: IndexPath) -> SYUIPoiDetailCellDataSource {
        return dataSource?.poiDetailCellViewModel(for: indexPath) ?? SYUIPoiDetailCellViewModel(title: "")
    }
    
    
    public var addressCellViewModel: SYUIPoiDetailAddressDataSource {
        guard let dataSource = dataSource else { return SYUIPoiDetailAddressViewModel(title: "", subtitle: nil) }
        return SYUIPoiDetailAddressViewModel(title: dataSource.poiDetailTitle, subtitle: dataSource.poiDetailSubtitle)
    }
    
    public var buttonsViewModel: SYUIActionButtonsViewModel {
        let count = dataSource?.poiDetailNumberOfActionButtons ?? 0
        var buttons: [SYUIActionButtonProperties] = []
        for index in 0..<count {
            guard let properties = dataSource?.poiDetailActionButtonProperties(at: index) else { continue }
            buttons.append(properties)
        }
        return SYUIActionButtonsViewModel(with: buttons)
    }
    
    public func didPressActionButton(at index: Int) {
        delegate?.poiDetailDidPressActionButton(at: index)
    }
    
    public func didSelectRow(at indexPath: IndexPath) {
        delegate?.poiDetailDidSelectCell(at: indexPath)
    }
    
}
