//// BottomSheetTestViewController.swift
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

class BottomSheetTestViewController: UIViewController {

    let bottomSheet = SYUIBottomSheetView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        bottomSheet.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomSheet)
        
        setupHelperButtons()
    }
    
    @objc func showBottomSheet() {
        bottomSheet.animateIn(bounce: true) {
            print("bottom sheet shown")
        }
    }
    
    @objc func hideBottomSheet() {
        bottomSheet.animateOut {
            print("bottom sheet hidden")
        }
    }
    
    private func setupHelperButtons() {
        let buttonShow = SYUIActionButton()
        buttonShow.translatesAutoresizingMaskIntoConstraints = false
        buttonShow.title = "Show bottom sheet"
        buttonShow.addTarget(self, action: #selector(showBottomSheet), for: .touchUpInside)
        
        let buttonHide = SYUIActionButton()
        buttonHide.translatesAutoresizingMaskIntoConstraints = false
        buttonHide.title = "Hide bottom sheet"
        buttonHide.style = .error
        buttonHide.addTarget(self, action: #selector(hideBottomSheet), for: .touchUpInside)
        
        view.addSubview(buttonShow)
        view.addSubview(buttonHide)
        buttonShow.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        buttonShow.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor).isActive = true
        buttonHide.topAnchor.constraint(equalTo: buttonShow.bottomAnchor, constant: 8.0).isActive = true
        buttonHide.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor).isActive = true
    }

}
