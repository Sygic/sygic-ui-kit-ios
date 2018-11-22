import UIKit

class PoiDetailSectionHeaderView: UITableViewHeaderFooterView {

    private let separator = UIView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        createLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        separator.backgroundColor = .border
    }
    
    private func createLayout() {
        contentView.backgroundColor = .clear
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .border
        addSubview(separator)
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[separator]|", options: [], metrics: nil, views: ["separator" : separator]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[separator(0.5)]", options: [], metrics: nil, views: ["separator" : separator]))
    }
}
