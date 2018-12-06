import UIKit

class PoiDetailSectionHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Private Properties

    private let separator = UIView()
    
    // MARK: - Public Methods
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        createLayout()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        separator.backgroundColor = .border
    }
    
    // MARK: - Private Methods
    
    private func createLayout() {
        contentView.backgroundColor = .clear
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .border
        addSubview(separator)
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[separator]|", options: [], metrics: nil, views: ["separator" : separator]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[separator(0.5)]", options: [], metrics: nil, views: ["separator" : separator]))
    }
}
