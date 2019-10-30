//// BubbleViewController.swift
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


class BubbleViewController: UIViewController {
    
    var bubble: SYUIBubbleView? {
        didSet {
            if let oldBubble = oldValue {
                oldBubble.removeFromSuperview()
            }
            if let bubble = bubble {
                bubble.addToView(view, landscapeLayout: SYUIDeviceOrientationUtils.isLandscapeLayout(traitCollection), animated: true, completion: nil)
            }
        }
    }
    
    let stackView = UIStackView()
    
    lazy var basicButton: SYUIActionButton = {
        let button = SYUIActionButton()
        button.title = "Basic"
        button.action = { [unowned self] _ in
            self.showBasicView()
        }
        return button
    }()
    
    lazy var loadingButton: SYUIActionButton = {
        let button = SYUIActionButton()
        button.title = "Loading"
        button.action = { [unowned self] _ in
            self.showLoadingView()
        }
        return button
    }()
    
    lazy var contentButton: SYUIActionButton = {
        let button = SYUIActionButton()
        button.title = "With content"
        button.action = { [unowned self] _ in
            self.showContentView()
        }
        return button
    }()
    
    lazy var actionsButton: SYUIActionButton = {
        let button = SYUIActionButton()
        button.title = "With buttons"
        button.action = { [unowned self] _ in
            self.showActionsView()
        }
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        stackView.addArrangedSubview(basicButton)
        stackView.addArrangedSubview(loadingButton)
        stackView.addArrangedSubview(contentButton)
        stackView.addArrangedSubview(actionsButton)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        bubble?.updateConstraints(landscapeLayout: SYUIDeviceOrientationUtils.isLandscapeLayout(traitCollection))
    }
    
    func showBasicView() {
        let bubble = SYUIBubbleView()
        bubble.addHeader(with: "Title", "description")
        self.bubble = bubble
    }
    
    func showLoadingView() {
        let bubble = SYUIBubbleView()
        bubble.addHeader(SYUIBubbleLoadingHeader())
        self.bubble = bubble
    }
    
    func showContentView() {
        let bubble = SYUIBubbleView()
        bubble.addHeader(with: "Tap me", "tap view or drag to reveal additional content")
        bubble.addContent(with: SYUIIcon.locationEmpty!, title: "Title", subtitle: nil)
        bubble.addContent(with: SYUIIcon.phone!, title: "Some title", subtitle: "This can be subtitle")
        self.bubble = bubble
    }
    
    func showActionsView() {
        let action1 = SYUIActionButton()
        action1.title = "Action"
        action1.style = .primary13
        
        let action2 = SYUIActionButton()
        action2.title = "Also action"
        action2.style = .secondary13
        
        let bubble = SYUIBubbleView()
        bubble.addHeader(with: "Tap me", "tap view or drag to reveal additional content")
        bubble.addContent(with: SYUIIcon.locationEmpty!, title: "Title", subtitle: nil)
        bubble.addContent(with: SYUIIcon.phone!, title: "Some title", subtitle: "This can be subtitle")
        bubble.addContentActionButton(title: "Content action1", icon: SYUIIcon.browser, action: nil)
        bubble.addContentActionButton(title: "Content action2", icon: SYUIIcon.mailFull, action: nil)
        bubble.addActionButton(action1)
        bubble.addActionButton(action2)
        self.bubble = bubble
    }
}
