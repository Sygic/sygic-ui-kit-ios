//// SYUISearchResultsTableViewController.swift
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


/// Protocol defines generic interface for search results presenter
public protocol SYUISearchResultsProtocol {
    associatedtype T
    var data: [T] { get }
    var selectionBlock: ((T)->())? { get set }
    var interactionBlock: (() -> ())? { get set }
}


/// Abstract class. Should be subclassed to represent search result in desired style.
public class SYUISearchResultsViewController<Result>: UIViewController, SYUISearchResultsProtocol {
    public var data: [Result] = []
    public var selectionBlock: ((Result) -> ())?
    public var interactionBlock: (() -> ())?
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
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        interactionBlock?()
    }
    
}
