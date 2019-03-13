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


/// A view that presents button and buttons after expand.
public class SYUIExpandableButtonsView: UIView {
    
    // MARK: - Public Properties
    
    /// Time interval for expanding buttons.
    public static var toggleAnimationInterval: TimeInterval = 0.5
    
    /// Time Interval for button animation.
    public static var buttonAnimationInterval: TimeInterval = 0.2
    
    /// Delay of button animation.
    public static var buttonAnimationDelay: TimeInterval = 0.1
    
    /// Main toggle button, expandable buttons are animating from this button.
    public var toggleButton = SYUIExpandableButton(withType: .icon)
    
    /// Icon of button in expanded state.
    public var toggleButtonExpandedIcon = SYUIIcon.viewControls
    
    /// Icon of button in wrapped state.
    public var toggleButtonWrappedIcon = SYUIIcon.close
    
    /// Array of expandable buttons.
    public var expandableButtons = [SYUIExpandableButton]()
    
    /// Returns if view is expanded.
    public var isExpanded = false
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initDefaults()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    /// Expand buttons with completion block.
    ///
    /// - Parameter completion: completion block called after buttons are expanded.
    public func expandButtons(withCompletion completion: (() -> ())?) {
        isExpanded = true
        removeConstraintsRelated(toSubview: toggleButton)
        
        toggleButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        toggleButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        toggleButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        var previousButton = toggleButton
        for button in expandableButtons {
            addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.leadingAnchor.constraint(equalTo: previousButton.trailingAnchor, constant: 8.0).isActive = true
            button.topAnchor.constraint(equalTo: topAnchor).isActive = true
            button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            
            if expandableButtons.last == button {
                button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            }
            previousButton = button
        }
        
        animateControlsShow { () -> () in
            completion?()
        }
    }
    
    /// Wrap buttons with animation.
    public func wrapButtons() {
        hideControlButtons(withCompletion: nil)
    }
    
    /// Wrap buttons without animation.
    public func wrapButtonsWithoutAnimation() {
        isExpanded = false
        expandableButtons.forEach { self.setHidden(forButton: $0) }
        finalizeControlsHide(withCompletion: nil)
    }
    
    // MARK: - Private Methods
    
    private func initDefaults() {
        isExpanded = false
        translatesAutoresizingMaskIntoConstraints = false
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        toggleButton.setTitle(titleForToggleButton(), for: .normal)
        addSubview(toggleButton)
        wrapButtonsWithoutAnimation()
    }
    
    private func titleForToggleButton() -> String {
        return isExpanded ? toggleButtonWrappedIcon : toggleButtonExpandedIcon
    }
    
    private func setButtonsTitleColor(_ color: UIColor, for state: UIControl.State, setDropShadow: Bool) {
        var buttons = expandableButtons
        buttons.append(toggleButton)
        
        for button in buttons {
            button.setTitleColor(color, for: state)
            if setDropShadow {
                button.setupDefaultShadow()
            }
        }
    }
    
    // MARK: Animations
    
    private func hideControlButtons(withCompletion completion: (() -> ())?) {
        isExpanded = false
        animateControlsHide {
            self.finalizeControlsHide(withCompletion: completion)
        }
    }
    
    private func animateControlsShow(withCompletion completion: (() -> ())?) {
        removeAllAnimations()
        toggleButton.animateTitleChange(to: titleForToggleButton(), withDuration: SYUIExpandableButtonsView.buttonAnimationInterval, andDirection: .left)
        
        for (index, button) in expandableButtons.enumerated() {
            setHidden(forButton: button)
            var wrapBlock: (() -> ())? = nil
            if index == expandableButtons.count - 1 {
                wrapBlock = completion
            }
            
            UIView.animate(withDuration: SYUIExpandableButtonsView.buttonAnimationInterval,
                           delay: SYUIExpandableButtonsView.buttonAnimationDelay * Double(index + 1),
                           options: [.curveEaseOut, .beginFromCurrentState], animations: {
                            self.setVisible(forButton: self.expandableButtons[index])
            }, completion: { (successful) in
                if let wrapBlock = wrapBlock {
                    wrapBlock()
                }
            })
        }
    }
    
    private func finalizeControlsHide(withCompletion completion: (() -> ())?) {
        for button in expandableButtons {
            button.removeFromSuperview()
        }
        removeConstraintsRelated(toSubview: toggleButton)
        toggleButton.coverWholeSuperview()
        toggleButton.setTitle(titleForToggleButton(), for: .normal)
        toggleButton.isEnabled = true
        guard let completion = completion else { return }
        completion()
    }
    
    private func animateControlsHide(withCompletion completion: (() -> ())?) {
        removeAllAnimations()
        toggleButton.animateTitleChange(to: titleForToggleButton(), withDuration: SYUIExpandableButtonsView.buttonAnimationInterval, andDirection: .right)
        
        for (index, button) in expandableButtons.enumerated() {
            setVisible(forButton: button)
            var wrapBlock: (() -> ())? = nil
            if index == 0 {
                wrapBlock = completion
            }
            
            UIView.animate(withDuration: SYUIExpandableButtonsView.buttonAnimationInterval,
                           delay: SYUIExpandableButtonsView.buttonAnimationDelay * Double(expandableButtons.count - index),
                           options: [.curveEaseInOut, .beginFromCurrentState],
                           animations: {
                            self.setHidden(forButton: self.expandableButtons[index])
            }, completion: { (successful) in
                if let wrapBlock = wrapBlock {
                    wrapBlock()
                }
            })
        }
    }
    
    private func removeAllAnimations() {
        layer.removeAllAnimations()
        toggleButton.removeAllAnimations()
        for button in expandableButtons {
            button.removeAllAnimations()
        }
    }
    
    private func setHidden(forButton button: UIButton) {
        button.alpha = 0.0
        button.transform = button.transform.scaledBy(x: 0.25, y: 0.25)
    }
    
    private func setVisible(forButton button: UIButton) {
        button.alpha = 1.0
        button.layer.setAffineTransform(.identity)
    }
    
}
