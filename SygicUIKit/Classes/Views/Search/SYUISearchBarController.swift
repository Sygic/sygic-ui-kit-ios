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

public protocol SYUISearchBarDelegate: class {
    func search(textDidChange searchedText: String)
    func searchDidBeginEditing()
    func searchDidEndEditing()
    func searchSearchButtonClicked()
    func searchCancelButtonClicked()
}

public class SYUISearchBarController: UIViewController, SYUISearchBarDelegate {
    
    public weak var delegate: SYUISearchBarDelegate?
    public var searchText: String = ""
    
    private var searchBarView: SYUISearchBarProtocol = SYUISearchBarView()
    
    public override func loadView() {
        if let searchView = searchBarView as? UIView {
            view = searchView
        }
        searchBarView.searchBarDelegate = self
    }
    
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
