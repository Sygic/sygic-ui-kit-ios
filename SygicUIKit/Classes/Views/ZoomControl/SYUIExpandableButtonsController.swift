//// SYUIExpandableButtonsView.swift
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


/**
    Expandable buttons UI element.
 
    Button, that can be expanded after tap. You can set n number of buttons which can be expanded in horizontal direction.
*/
open class SYUIExpandableButtonsController {
    
    // MARK: - Public Properties
    
    /// Returns the expandable buttons view managed by the controller object.
    public let expandableButtonsView = SYUIExpandableButtonsView()
    
    // MARK: - Public Methods
    
    public init() {
        expandableButtonsView.toggleButton.addTarget(self, action: #selector(toggleButtonTapped(button:)), for: .touchUpInside)
    }
    
    /// Expand buttons in horizontal direction with animation
    public func expandButtons() {
        expandableButtonsView.expandButtons() {
            self.expandableButtonsView.toggleButton.isEnabled = true
        }
    }
    
    /// Wrap buttons with animation
    public func wrapButtons() {
        expandableButtonsView.wrapButtons()
    }
    
    /// Set expandable buttons. Buttons will be visible in expandable view.
    ///
    /// - Parameter buttons: Array of buttons showed in expanded view
    public func setExpandableButtons(buttons: [SYUIExpandableButton]) {
        expandableButtonsView.expandableButtons = buttons
    }
    
    // MARK: - Private Methods
    
    @objc private func toggleButtonTapped(button: SYUIExpandableButton) {
        button.isEnabled = false
        expandableButtonsView.isExpanded ? wrapButtons() : expandButtons()
    }
    
}
