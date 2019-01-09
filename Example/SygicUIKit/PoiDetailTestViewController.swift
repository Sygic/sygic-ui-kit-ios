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
        poiDetailViewController?.presentPoiDetailAsChildViewController(to: self) { (finished) in
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
    
    func poiDetailActionButton(for index: Int) -> SYUIActionButton {
        let button = SYUIActionButton()
        button.title = "Primary action button"
        button.icon = SYUIIcon.routeStart
        return button
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
    
    func poiDetailCellData(for indexPath: IndexPath) -> SYUIPoiDetailCellDataSource {
        guard let section = SYUIPoiDetailSectionType(rawValue: indexPath.section) else { return SYUIPoiDetailCellData(title: "") }
        switch section {
        case .actions:
            return SYUIPoiDetailCellData(title: "GPS", subtitle: "48.1450996,17.1069041", icon: SYUIIcon.streetView, stringToCopy: "copy to clipboard")
        case .contactInfo:
            switch indexPath.row {
            case 0:
                return SYUIPoiDetailCellData(title: LS("detail.contact.phone"), subtitle: "+421 987 123 456", icon: SYUIIcon.call)
            case 1:
                return SYUIPoiDetailCellData(title: LS("detail.contact.mail"), subtitle: "info@sygic.com", icon: SYUIIcon.email)
            case 2:
                return SYUIPoiDetailCellData(title: LS("detail.contact.url"), subtitle: "www.sygic.com", icon: SYUIIcon.website)
            default:
                return SYUIPoiDetailCellData(title: "")
            }
        default:
            return SYUIPoiDetailCellData(title: "")
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
