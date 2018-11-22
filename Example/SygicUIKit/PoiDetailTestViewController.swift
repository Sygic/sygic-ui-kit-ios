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
}

extension PoiDetailTestViewController: SYUIPoiDetailDelegate {
    
}
