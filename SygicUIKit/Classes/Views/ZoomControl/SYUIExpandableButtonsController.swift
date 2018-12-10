
open class SYUIExpandableButtonsController {
    
    // MARK: - Public Properties
    
    public let expandableButtonsView = SYUIExpandableButtonsView()
    
    // MARK: - Public Methods
    
    public init() {
        expandableButtonsView.toggleButton.addTarget(self, action: #selector(toggleButtonTapped(button:)), for: .touchUpInside)
    }
    
    public func expandButtons() {
        expandableButtonsView.expandButtons() {
            self.expandableButtonsView.toggleButton.isEnabled = true
        }
    }
    
    public func wrapButtons() {
        expandableButtonsView.wrapButtons()
    }
    
    public func setExpandableButtons(buttons: [SYUIExpandableButton]) {
        expandableButtonsView.expandableButtons = buttons
    }
    
    // MARK: - Private Methods
    
    @objc private func toggleButtonTapped(button: SYUIExpandableButton) {
        button.isEnabled = false
        expandableButtonsView.isExpanded ? wrapButtons() : expandButtons()
    }
    
}
