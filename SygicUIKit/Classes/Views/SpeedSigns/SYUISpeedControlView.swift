//// SYUISpeedControlView.swift
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


/// View for both current speed and speed limit.
public class SYUISpeedControlView: UIView {
    
    // MARK: - Private Properties
    
    private let currentSpeedView = SYUICurrentSpeedView()
    private let speedLimitView = SYUISpeedLimitView()
    private let speedLimitAmericaView = SYUISpeedLimitAmericaView()
    private let speedLimitIndentFromCurrentSpeed: CGFloat = 12
    
    // MARK: - Public Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initDefaults()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Updates current speed label.
    /// - Parameter speed: Current speed.
    public func updateCurrentSpeed(with speed: Int, speeding: Bool) {
        currentSpeedView.currentSpeed = speed
        currentSpeedView.speeding = speeding
    }
    
    /// Updates speed limit.
    /// - Parameter limit: Limit showed in speed limit view.
    /// - Parameter isAmerica: Boolean value for America or rest of the world speed limit.
    public func updateSpeedLimit(with limit: Int, isAmerica: Bool) {
        guard limit != 0 else {
            speedLimitAmericaView.isHidden = true
            speedLimitView.isHidden = true
            return
        }
        speedLimitAmericaView.isHidden = !isAmerica
        speedLimitView.isHidden = isAmerica
        var speedLimitView: SYUISpeedLimit
        if isAmerica {
            speedLimitView = speedLimitAmericaView
        } else {
            speedLimitView = self.speedLimitView
        }
        speedLimitView.speedLimit = limit
    }
    
    /// Update units for views.
    /// - Parameter units: Units format.
    public func updateUnits(_ units: SYUIDistanceUnits) {
        currentSpeedView.unitsFormat = units
    }
    
    // MARK: - Private Methods
    
    private func initDefaults() {
        setupCurrentSpeedView()
        setupSpeedLimit(speedLimitView: speedLimitView)
        setupSpeedLimit(speedLimitView: speedLimitAmericaView)
    }
    
    private func setupCurrentSpeedView() {
        addSubview(currentSpeedView)
        currentSpeedView.translatesAutoresizingMaskIntoConstraints = false
        currentSpeedView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        currentSpeedView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        currentSpeedView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    private func setupSpeedLimit(speedLimitView: UIView) {
        addSubview(speedLimitView)
        speedLimitView.translatesAutoresizingMaskIntoConstraints = false
        speedLimitView.centerXAnchor.constraint(equalTo: currentSpeedView.centerXAnchor).isActive = true
        speedLimitView.bottomAnchor.constraint(equalTo: currentSpeedView.topAnchor, constant: speedLimitIndentFromCurrentSpeed).isActive = true
        speedLimitView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        sendSubviewToBack(speedLimitView)
        speedLimitView.isHidden = true
    }
    
}
