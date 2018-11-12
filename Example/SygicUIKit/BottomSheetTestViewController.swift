import UIKit
import SygicUIKit

class BottomSheetTestViewController: UIViewController {

    let bottomSheet = SYUIBottomSheetView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        bottomSheet.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomSheet)
        
        setupHelperButtons()
    }
    
    @objc func showBottomSheet() {
        bottomSheet.animateIn {
            print("bottom sheet shown")
        }
    }
    
    private func setupHelperButtons() {
        let buttonShow = SYUIActionButton()
        buttonShow.translatesAutoresizingMaskIntoConstraints = false
        buttonShow.setup(with: ActionButtonViewModel(title: "Show bottom sheet"))
        buttonShow.addTarget(self, action: #selector(showBottomSheet), for: .touchUpInside)
        
        view.addSubview(buttonShow)
        buttonShow.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        buttonShow.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor).isActive = true
    }

}
