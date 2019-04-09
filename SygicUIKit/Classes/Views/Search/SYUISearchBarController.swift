//// SYUISearchBarController.swift
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

/// Search bar output delegate
public protocol SYUISearchBarDelegate: class {
    
    /// Tells the delegate that the user changed the search text.
    ///
    /// - Parameter searchedText: New text.
    func search(textDidChange searchedText: String)
    
    /// Tells the delegate when the user begins editing the search text.
    func searchDidBeginEditing()
    
    /// Tells the delegate that the user finished editing the search text.
    func searchDidEndEditing()
    
    /// Tells the delegate that the search button on keyboard was tapped.
    func searchSearchButtonClicked()
    
    /// Tells the delegate that the cancel button was tapped.
    func searchCancelButtonClicked()
}

/// Controller manages search bar input field.
public class SYUISearchBarController: UIViewController, SYUISearchBarDelegate {
    
    /// Text in search input field.
    public var searchText: String = ""
    
    /// Search bar controller delegate.
    public weak var delegate: SYUISearchBarDelegate?
    
    /// Custom view of search bar controller.
    private var searchBarView: SYUISearchBarProtocol = SYUISearchBarView()
    
    public override func loadView() {
        if let searchView = searchBarView as? UIView {
            view = searchView
        }
        searchBarView.searchBarDelegate = self
    }
    
    /// Prefill search input field.
    ///
    /// - Parameter text: Text for search input field.
    public func prefillSearch(with text: String) {
        guard let searchView = searchBarView as? SYUISearchBarView else { return }
        searchText = text
        searchView.searchBar.text = text
    }
    
    public override func becomeFirstResponder() -> Bool {
        return view.becomeFirstResponder()
    }
    
    public override func resignFirstResponder() -> Bool {
        return view.resignFirstResponder()
    }
    
    public func search(textDidChange searchedText: String) {
        searchText = searchedText
        delegate?.search(textDidChange: searchedText)
    }
    
    public func searchDidBeginEditing() {
        delegate?.searchDidBeginEditing()
    }
    
    public func searchDidEndEditing() {
        delegate?.searchDidEndEditing()
    }
    
    public func searchSearchButtonClicked() {
        delegate?.searchSearchButtonClicked()
    }
    
    public func searchCancelButtonClicked() {
        delegate?.searchCancelButtonClicked()
    }
    
}
