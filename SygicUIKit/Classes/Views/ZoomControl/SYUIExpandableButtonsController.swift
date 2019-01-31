
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
