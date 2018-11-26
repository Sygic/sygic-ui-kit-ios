public class SYUIExpandableButtonsView: UIView {
    
    public static let toggleAnimationInterval: TimeInterval = 0.5
    public static let buttonAnimationInterval: TimeInterval = 0.2
    public static let buttonAnimationDelay: TimeInterval = 0.1
    
    private var toggleButton = SYUIExpandableButton(withType: .icon)
    private var isExpanded = false
    
    public var expandableButtons = [SYUIExpandableButton]()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initDefaults()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    public func initDefaults() {
        isExpanded = false
        translatesAutoresizingMaskIntoConstraints = false
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        toggleButton.setTitle(titleForToggleButton(), for: .normal)
        toggleButton.addTarget(self, action: #selector(toggleButtonTapped(button:)), for: .touchUpInside)
        addSubview(toggleButton)
        wrapButtonsWithoutAnimation()
    }
    
    public func expandButtons() {
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
            self.toggleButton.isEnabled = true
        }
    }
    
    public func wrapButtons() {
        hideControlButtons(withCompletion: nil)
    }
    
    public func wrapButtonsWithoutAnimation() {
        isExpanded = false
        expandableButtons.forEach { self.setHidden(forButton: $0) }
        finalizeControlsHide(withCompletion: nil)
    }
    
    // MARK: - Private Methods
    
    @objc private func toggleButtonTapped(button: SYUIExpandableButton) {
        button.isEnabled = false
        isExpanded ? wrapButtons() : expandButtons()
    }
    
    private func titleForToggleButton() -> String {
        return isExpanded ? SygicIcon.close : SygicIcon.viewControls
    }
    
    private func setButtonsTitleColor(_ color: UIColor, for state: UIControlState, setDropShadow: Bool) {
        var buttons = expandableButtons
        buttons.append(toggleButton)
        
        for button in buttons {
            button.setTitleColor(color, for: state)
            if setDropShadow {
                button.setupDefaultShadow()
            }
        }
    }
    
    // MARK: - Animations
    
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
