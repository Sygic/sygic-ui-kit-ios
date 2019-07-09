//// SYUIRoutePreviewController.swift
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


/// Route preview controller possible activites (user interaction)
public enum SYUIRoutePreviewActivity {
    /// pause button tapped activity
    case pause
    /// play button tapped activity
    case play
    /// stop button tapped activity
    case stop
    /// speed button tapped activity
    case speed
}

/// Route preview controller delegate
public protocol SYUIRoutePreviewControllerDelegate: class {
    
    /// Route preview controller delegation of user interaction with preview control buttons.
    ///
    /// - Parameter activity: Activity based on user interaction.
    func routePreviewController(_ controller: SYUIRoutePreviewController, wants activity: SYUIRoutePreviewActivity)
}


/// Route preview controller is specific implementation of expandable buttons controller
/// with play/pause button, speed and stop buttons.
open class SYUIRoutePreviewController: SYUIExpandableButtonsController {
    
    // MARK: - Public Properties
    
    /// Returns if control is toggled to play or paused mode and updates toggle button title.
    public var isPlaying = false {
        didSet {
            // must be guarded to not trigger unwanted animations
            guard isPlaying != oldValue else { return }
            updatePlayButtonTitle()
        }
    }
    
    /// Icon for stop button.
    public var stopButtonIcon = SYUIIcon.stopPlaying {
        didSet {
            stopButton.setTitle(stopButtonIcon, for: .normal)
        }
    }
    
    /// Icon for play toggle button,
    public var iconPlay = SYUIIcon.play {
        didSet {
            playButton.setTitle(togglePlayButtonIcon, for: .normal)
        }
    }
    
    /// Icon for pause toggle button.
    public var iconPause = SYUIIcon.pause {
        didSet {
            playButton.setTitle(togglePlayButtonIcon, for: .normal)
        }
    }
    
    /// Returns button icon for play/pause toggle button.
    public var togglePlayButtonIcon: String {
        return isPlaying ? iconPause : iconPlay
    }
    
    /// Title for preview speed control button
    public var speedText: String = "1x" {
        didSet {
            speedButton.setTitle(speedText, for: .normal)
        }
    }
    
    /// Route preview controller delegate.
    public weak var delegate: SYUIRoutePreviewControllerDelegate?
    
    // MARK: - Private Properties
    
    private let stopButton = SYUIExpandableButton(withType: .icon)
    private let playButton = SYUIExpandableButton(withType: .icon)
    private let speedButton = SYUIExpandableButton(withType: .text)
    
    // MARK: - Public Methods
    
    public override init() {
        super.init()
        
        setupExpandableButtons()
        setupRecognizers()
    }
    
    public override func expandButtons() {
        updatePlayButtonTitle()
        super.expandButtons()
    }
    
    // MARK: - Private Methods
    
    private func updatePlayButtonTitle() {
        playButton.animateTitleChange(to: togglePlayButtonIcon, withDuration: SYUIExpandableButtonsView.buttonAnimationInterval, andDirection: isPlaying ? .left : .right)
    }
    
    private func setupExpandableButtons() {
        stopButton.setTitle(stopButtonIcon, for: .normal)
        speedButton.setTitle(speedText, for: .normal)
        playButton.setTitle(togglePlayButtonIcon, for: .normal)
        
        expandableButtonsView.toggleButtonExpandedIcon = SYUIIcon.play
        setExpandableButtons(buttons: [playButton, speedButton, stopButton])
    }
    
    private func setupRecognizers() {
        stopButton.addTarget(self, action: #selector(stopButtonPressed(button:)), for: .touchUpInside)
        speedButton.addTarget(self, action: #selector(speedButtonPressed(button:)), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(togglePlayButtonPressed(button:)), for: .touchUpInside)
    }

    @objc private func togglePlayButtonPressed(button: SYUIExpandableButton) {
        delegate?.routePreviewController(self, wants: isPlaying ? .pause : .play)
    }

    @objc private func stopButtonPressed(button: SYUIExpandableButton) {
        delegate?.routePreviewController(self, wants: .stop)
    }

    @objc private func speedButtonPressed(button: SYUIExpandableButton) {
        delegate?.routePreviewController(self, wants: .speed)
    }
    
}
