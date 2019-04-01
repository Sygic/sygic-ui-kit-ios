//// DetailCellTableTestViewController.swift
//
// Copyright (c) 2019 Sygic a.s.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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

        addChild(searchResultsVC)
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
