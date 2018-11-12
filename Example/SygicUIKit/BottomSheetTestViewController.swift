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
    
    @objc func hideBottomSheet() {
        bottomSheet.animateOut {
            print("bottom sheet hidden")
        }
    }
    
    private func setupHelperButtons() {
        let buttonShow = SYUIActionButton()
        buttonShow.translatesAutoresizingMaskIntoConstraints = false
        buttonShow.setup(with: ActionButtonViewModel(title: "Show bottom sheet"))
        buttonShow.addTarget(self, action: #selector(showBottomSheet), for: .touchUpInside)
        
        let buttonHide = SYUIActionButton()
        buttonHide.translatesAutoresizingMaskIntoConstraints = false
        buttonHide.setup(with: ActionButtonViewModel(title: "Hide bottom sheet", style: .error))
        buttonHide.addTarget(self, action: #selector(hideBottomSheet), for: .touchUpInside)
        
        view.addSubview(buttonShow)
        view.addSubview(buttonHide)
        buttonShow.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        buttonShow.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor).isActive = true
        buttonHide.topAnchor.constraint(equalTo: buttonShow.bottomAnchor, constant: 8.0).isActive = true
        buttonHide.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor).isActive = true
    }

}
