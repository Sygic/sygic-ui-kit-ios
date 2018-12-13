
public protocol SYUIMapRecenterDelegate: class {
    func didChangeRecenterButtonState(button: SYUIActionButton, state: SYUIMapRecenterController.state)
}

open class SYUIMapRecenterController {
    public enum state {
        case free
        case locked
        case lockedCompass
    }
    
    public var button = SYUIActionButton()
    public var allowedStates: [state] = [.free, .locked, .lockedCompass]
    
    public var currentState: state = .free {
        didSet {
            refreshIcon()
            if let delegate = delegate, oldValue != currentState {
                delegate.didChangeRecenterButtonState(button: button, state: currentState)
            }
        }
    }
    public weak var delegate: SYUIMapRecenterDelegate?
    
    public init() {
        button.style = .secondary
        button.addTarget(self, action: #selector(SYUIMapRecenterController.didTapButton), for: .touchUpInside)
        refreshIcon()
    }
    
    @objc func didTapButton() {
        if allowedStates.count == 0 { return }
        guard var stateIndex = allowedStates.firstIndex(of: currentState) else { return }
        stateIndex += 1
        
        if stateIndex >= allowedStates.count {
            stateIndex = 0
        }
        
        currentState = allowedStates[stateIndex]
    }
    
    private func refreshIcon() {
        switch currentState {
        case .free:
            button.icon = SYUIIcon.positionIos
        case .locked:
            button.icon = SYUIIcon.positionLockIos
        case .lockedCompass:
            button.icon = SYUIIcon.positionLockCompassIos
        }
    }
}