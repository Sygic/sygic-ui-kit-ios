import UIKit
import SygicUIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonVM = ActionButtonViewModel(title: "Title", subtitle: "subtitle", style: .primary)
        
        let button = ActionButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setup(with: buttonVM)
        
        view.addSubview(button)
        button.centerInSuperview()
    }
}

