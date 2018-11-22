import UIKit
import SygicUIKit

class PoiDetailTestViewController: UIViewController {
    
    var poiDetailViewController: SYUIPoiDetailViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTestLayout()
    }
    
    func presentPoiDetailViewController() {
        poiDetailViewController = SYUIPoiDetailViewController()
        poiDetailViewController?.dataSource = self
        poiDetailViewController?.delegate = self
        poiDetailViewController?.presentPoiDetail(to: self) { (finished) in
            print("poi detail presented as child")
        }
    }
    
    func dismissPoiDetail() {
        poiDetailViewController?.dismissPoiDetail { (finished) in
            self.poiDetailViewController = nil
            print("poi detail dismissed from parent")
        }
    }

    @objc private func tapRecognized() {
        if poiDetailViewController == nil {
            presentPoiDetailViewController()
        } else {
            dismissPoiDetail()
        }
    }
    
    private func setupTestLayout() {
        view.backgroundColor = .lightGray
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapRecognized)))
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tap me!"
        view.addSubview(label)
        label.centerInSuperview()
    }
}

extension PoiDetailTestViewController: SYUIPoiDetailDataSource {
    var poiDetailMaxTopOffset: CGFloat {
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets.top
        }
        return 0
    }
    
    var poiDetailTitle: String {
        return "Poi detail title"
    }
    
    var poiDetailSubtitle: String? {
        return "Poi detail subtitle"
    }
    
    var poiDetailNumberOfActionButtons: Int {
        return 1
    }
    
    func poiDetailActionButtonProperties(at index: Int) -> SYUIActionButtonProperties? {
        return SYUIActionButtonViewModel(title: "Primary action button", icon: SygicIcon.routeStart)
    }
    
    func poiDetailNumberOfRows(in section: SYUIPoiDetailSectionType) -> Int {
        switch section {
        case .actions:
            return 1
        case .contactInfo:
            return 3
        default:
            return 0
        }
    }
    
    func poiDetailCellViewModel(for indexPath: IndexPath) -> SYUIPoiDetailCellDataSource {
        guard let section = SYUIPoiDetailSectionType(rawValue: indexPath.section) else { return SYUIPoiDetailCellViewModel(title: "") }
        switch section {
        case .actions:
            return SYUIPoiDetailCellViewModel(title: "GPS", subtitle: "48.1450996,17.1069041", icon: SygicIcon.streetView)
        case .contactInfo:
            switch indexPath.row {
            case 0:
                return SYUIPoiDetailCellViewModel(title: "Phone", subtitle: "+421 987 123 456", icon: SygicIcon.call)
            case 1:
                return SYUIPoiDetailCellViewModel(title: "Email", subtitle: "info@sygic.com", icon: SygicIcon.email)
            case 2:
                return SYUIPoiDetailCellViewModel(title: "Website", subtitle: "www.sygic.com", icon: SygicIcon.website)
            default:
                return SYUIPoiDetailCellViewModel(title: "")
            }
        default:
            return SYUIPoiDetailCellViewModel(title: "")
        }
    }
}

extension PoiDetailTestViewController: SYUIPoiDetailDelegate {
    func poiDetailDidPressActionButton(at index: Int) {
        print("action button pressed \(index)")
    }
    
    func poiDetailDidSelectCell(at indexPath: IndexPath) {
        print("poi detail cell \(indexPath)")
    }
}
