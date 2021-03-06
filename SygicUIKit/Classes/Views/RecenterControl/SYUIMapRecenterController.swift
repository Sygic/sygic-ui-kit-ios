//// SYUIMapRecenterController.swift
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


/// Map Recenter controller delegate.
public protocol SYUIMapRecenterDelegate: class {
    
    /// Method is called, when state of a button is changed.
    ///
    /// - Parameters:
    ///   - button: button that changed state.
    ///   - state: new changed state.
    func didChangeRecenterButtonState(button: SYUIActionButton, state: SYUIRecenterState)
}

/// Represents state of recenter controller.
public enum SYUIRecenterState {
    /// Map is in free browse mode.
    case free
    /// Map is locked to gps position.
    case locked
    /// Map is locked to gps position and camera is rotating in front of device.
    case lockedCompass
}

/// Map recenter controller controls its view that is `SYUIActionButton`.
open class SYUIMapRecenterController {
    
    // MARK: - Public Properties
    
    /// Button, which represents a view of this controller
    public var button = SYUIActionButton()
    
    /// Allowed states
    public var allowedStates: [SYUIRecenterState] = [.free, .locked, .lockedCompass]
    
    /// Current state of controller
    public var currentState: SYUIRecenterState = .free {
        didSet {
            refreshIcon()
            if let delegate = delegate, oldValue != currentState {
                delegate.didChangeRecenterButtonState(button: button, state: currentState)
            }
        }
    }
    
    /// Map recenter delegate.
    public weak var delegate: SYUIMapRecenterDelegate?
    
    // MARK: - Public Methods
    
    public init() {
        button.style = .secondary
        button.addTarget(self, action: #selector(SYUIMapRecenterController.didTapButton), for: .touchUpInside)
        refreshIcon()
    }
    
    // MARK: - Private Methods
    
    @objc private func didTapButton() {
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
