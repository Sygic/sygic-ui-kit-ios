//// InfobarTestViewController.swift
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


class InfobarTestViewController: UIViewController {
    
    let infobar = SYUIInfobar()
    
    var items: [(text: String, isOn: Bool)] = [
        (text: "Left Button", isOn: true),
        (text: "Item1", isOn: true),
        (text: "Item2", isOn: false),
        (text: "Item3", isOn: false),
        (text: "SecItem1", isOn: true),
        (text: "SecItem2", isOn: true),
        (text: "SecItem3", isOn: false),
        (text: "Right Button", isOn: true),
    ]
    
    let leftButton: SYUIActionButton = {
        let button = SYUIActionButton()
        button.style = .primary13
        button.icon = SYUIIcon.contextMenuIos
        button.height = SYUIActionButtonSize.infobar.rawValue
        return button
    }()
    
    let rightButton: SYUIActionButton = {
        let button = SYUIActionButton()
        button.style = .error13
        button.icon = SYUIIcon.close
        button.height = SYUIActionButtonSize.infobar.rawValue
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        
        infobar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infobar)
        infobar.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 16).isActive = true
        infobar.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -16).isActive = true
        infobar.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -16).isActive = true
        
        updateInfobarLayout()
        setupContolSwitches()
    }
    
    @objc func switchChanged(_ onOff: UISwitch) {
        print("switch N\(onOff.tag) = \(onOff.isOn ? "ON" : "OFF")")
        items[onOff.tag].isOn = onOff.isOn
        updateInfobarLayout()
    }
    
    func updateInfobarLayout() {
        if items[0].isOn {
            infobar.leftButton = leftButton
        } else {
            infobar.leftButton = nil
        }
        
        if items[7].isOn {
            infobar.rightButton = rightButton
        } else {
            infobar.rightButton = nil
        }
        
        infobar.items = {
            var itemViews: [UIView] = []
            for i in 1...3 {
                let item = items[i]
                if item.isOn {
                    let itemView = SYUIInfobarItem()
                    itemView.text = item.text
                    itemViews.append(itemView)
                }
            }
            return itemViews
        }()
        
        infobar.secondaryItems = {
            var itemViews: [UIView] = []
            for i in 4...6 {
                let item = items[i]
                if item.isOn {
                    let itemView = SYUIInfobarSecondaryItem()
                    itemView.text = item.text
                    itemViews.append(itemView)
                }
            }
            return itemViews
        }()
    }

    private func setupContolSwitches() {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.spacing = 8
        vStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vStack)
        vStack.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 16).isActive = true
        vStack.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -16).isActive = true
        vStack.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 16).isActive = true
        
        for (index, item) in items.enumerated() {
            let label = UILabel()
            label.text = item.text
            let switck = UISwitch()
            switck.isOn = item.isOn
            switck.tag = index
            switck.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
            let hStack = UIStackView()
            hStack.addArrangedSubview(label)
            hStack.addArrangedSubview(switck)
            vStack.addArrangedSubview(hStack)
        }
    }
}
