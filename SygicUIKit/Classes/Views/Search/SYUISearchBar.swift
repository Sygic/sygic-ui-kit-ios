import UIKit

protocol SYUISearchBarProtocol {
    
}

protocol SYUISearchBarDelegate {
//    searchBarDidBecomeActive()
}

class SYUISearchBarController {
    var delegate: SYUISearchBarDelegate?
    
    var view: SYUISearchBarProtocol = SYUISearchBarView()
    
    init() {
        
    }
}

class SYUISearchBarView: UIView, SYUISearchBarProtocol {

    let textField = UITextField()
    
    override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }

}
