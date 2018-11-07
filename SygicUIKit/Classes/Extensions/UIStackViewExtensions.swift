import Foundation

public extension UIStackView {
    func removeAll() {
        let oldViews = arrangedSubviews
        for view in oldViews {
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}
