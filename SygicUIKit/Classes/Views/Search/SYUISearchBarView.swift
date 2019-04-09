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


/// Search bar view output delegate. Same delegate is used in `SYUISearchBarController`.
/// So `SYUISearchBarView` can be subclassed and search UI delegate will be same.
public protocol SYUISearchBarProtocol {
    var searchBarDelegate: SYUISearchBarDelegate? { get set }
}

/// Search bar view object.
public class SYUISearchBarView: UIView, UISearchBarDelegate, SYUISearchBarProtocol {

    /// Search bar input field.
    public let searchBar = UISearchBar()
    
    /// Search bar view delegate.
    public weak var searchBarDelegate: SYUISearchBarDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.showsCancelButton = true
    
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchBar)
        searchBar.coverWholeSuperview()
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
        searchBarDelegate?.search(textDidChange: searchText)
    }
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBarDelegate?.searchDidBeginEditing()
    }
    
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBarDelegate?.searchDidEndEditing()
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBarDelegate?.searchSearchButtonClicked()
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBarDelegate?.searchCancelButtonClicked()
    }

}
