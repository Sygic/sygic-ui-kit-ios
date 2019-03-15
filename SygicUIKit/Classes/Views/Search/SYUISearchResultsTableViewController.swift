import UIKit


/// Protocol defines generic interface for search results presenter
public protocol SYUISearchResultsProtocol {
    associatedtype T
    var data: [T] { get }
    var selectionBlock: ((T)->())? { get set }
}


/// Abstract class. Should be subclassed to represent search result in desired style.
public class SYUISearchResultsViewController<Result>: UIViewController, SYUISearchResultsProtocol {
    public var data: [Result] = []
    public var selectionBlock: ((Result) -> ())?
}


/// Table view implementation of search results
public class SYUISearchResultsTableViewController<Result: SYUIDetailCellDataSource>: SYUISearchResultsViewController<Result>, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Public Properties
    
    public override var data: [Result] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Private Properties
    
    private let tableView = UITableView()
    private let cellIdentifier = NSStringFromClass(SYUIDetailTableViewCell.self)
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        let nib = UINib(nibName: SYUIDetailTableViewCell.nibName, bundle: Bundle(for: SYUIDetailTableViewCell.self))
        tableView.register(nib, forCellReuseIdentifier: NSStringFromClass(SYUIDetailTableViewCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        tableView.coverWholeSuperview()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - UITableView delegate, data source
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        if let detailCell = cell as? SYUIDetailTableViewCell {
            
            detailCell.setup(with: data[indexPath.row])
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionBlock?(data[indexPath.row])
    }
}
