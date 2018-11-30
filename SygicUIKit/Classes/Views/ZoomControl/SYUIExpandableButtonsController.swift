public class SYUIExpandableButtonsController {
    
    public let expandableButtonsView = SYUIExpandableButtonsView()
    
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
    
    @objc private func toggleButtonTapped(button: SYUIExpandableButton) {
        button.isEnabled = false
        expandableButtonsView.isExpanded ? wrapButtons() : expandButtons()
    }
    
}
