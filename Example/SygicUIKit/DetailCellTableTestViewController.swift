import UIKit
import SygicUIKit


private struct CellData: SYUIDetailCellDataSource {
    var height: CGFloat = 60
    var title: NSMutableAttributedString?
    var subtitle: NSMutableAttributedString?
    var leftIcon: SYUIDetailCellIconDataSource?
    var rightIcon: SYUIDetailCellIconDataSource?
    var backgroundColor: UIColor?
}

class DetailCellTableTestViewController: UIViewController {
    
    private let searchResultsVC: SYUISearchResultsViewController = SYUISearchResultsTableViewController<CellData>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewController(searchResultsVC)
        searchResultsVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchResultsVC.view)
        searchResultsVC.view.coverWholeSuperview()
        
        searchResultsVC.data = mockItems()
        
        searchResultsVC.selectionBlock = { selectedItem in
            print("SELECTION OF \(selectedItem.title!.string)")
        }
    }

    private func mockItems() -> [CellData] {
        let cell1 = CellData(height: 60,
                             title: NSMutableAttributedString(string: "Cell with title", attributes: CellData.defaultTitleAttributes),
                             subtitle: nil,
                             leftIcon: nil,
                             rightIcon: nil,
                             backgroundColor: .background)
        
        let cell2 = CellData(height: 60,
                             title: NSMutableAttributedString(string: "Left icon and title", attributes: CellData.defaultTitleAttributes),
                             subtitle: nil,
                             leftIcon: SYUIDetailCellIconDataSource(icon: SYUIIcon.apple, color: UIColor.white, backgroundColor: UIColor.red),
                             rightIcon: nil,
                             backgroundColor: .background)
        
        let cell3 = CellData(height: 60,
                             title: NSMutableAttributedString(string: "Title", attributes: CellData.defaultTitleAttributes),
                             subtitle: NSMutableAttributedString(string: "and subtitle", attributes: CellData.defaultSubtitleAttributes),
                             leftIcon: nil,
                             rightIcon: nil,
                             backgroundColor: .background)
        
        let cell4 = CellData(height: 60,
                             title: NSMutableAttributedString(string: "Right icon", attributes: CellData.defaultTitleAttributes),
                             subtitle: NSMutableAttributedString(string: "and subtitle", attributes: CellData.defaultSubtitleAttributes),
                             leftIcon: nil,
                             rightIcon: SYUIDetailCellIconDataSource(icon: SYUIIcon.apple, color: UIColor.darkGray, backgroundColor: nil),
                             backgroundColor: .background)
        
        return [cell1, cell2, cell3, cell4]
    }
}
