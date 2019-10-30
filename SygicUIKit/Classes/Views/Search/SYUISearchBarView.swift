//// SYUISearchBarView.swift
//
// Copyright (c) 2019 - Sygic a.s.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the &quot;Software&quot;), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit


/// Search bar protocol. It's possible to create custom view for search input. Custom view must adopt
/// this protocol. Because view type of `SYUISearchBarControllers` is `SYUISearchBarProtocol`.
public protocol SYUISearchBarProtocol {
    
    /// Text in search input field.
    var searchText: String { get set }
    
    /// Search bar handling for delegate. Same delegate is used in `SYUISearchBarController`.
    var searchBarDelegate: SYUISearchBarDelegate? { get set }
    
    /// Method to present activity indicator in searchBar while searching.
    func showLoadingIndicator(_ show: Bool)
}

extension SYUISearchBarProtocol {
    func showLoadingIndicator(_ show: Bool) {}
}


/// Search bar view object.
public class SYUISearchBarView: UIView, UISearchBarDelegate, SYUISearchBarProtocol {

    /// Search bar input field.
    public let searchBar = UISearchBar()
    
    /// Search bar view delegate.
    public weak var searchBarDelegate: SYUISearchBarDelegate?
    
    /// Text in search input field.
    public var searchText: String {
        set {
            searchBar.text = newValue
        }
        get {
            return searchBar.text ?? ""
        }
    }
    
    private let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.showsCancelButton = true
    
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchBar)
        searchBar.coverWholeSuperview()
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func becomeFirstResponder() -> Bool {
        return searchBar.becomeFirstResponder()
    }
    
    public override func resignFirstResponder() -> Bool {
        return searchBar.resignFirstResponder()
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarDelegate?.searchBar(self, textDidChange: searchText)
    }
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBarDelegate?.searchBarDidBeginEditing(self)
    }
    
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBarDelegate?.searchBarDidEndEditing(self)
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBarDelegate?.searchBarSearchButtonClicked(self)
        searchBar.resignFirstResponder()
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBarDelegate?.searchBarCancelButtonClicked(self)
    }

    public func showLoadingIndicator(_ show: Bool) {
        var searchIcon: UIView?
        if let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField {
            searchIcon = textFieldInsideSearchBar.leftView
        }
        searchIcon?.isHidden = show
        
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}
