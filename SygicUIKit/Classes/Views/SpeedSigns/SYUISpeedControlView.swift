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
    private let speedLimit = SYUISpeedLimitView()
    
    private let controlsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = -12
        return stackView
    }()
    
    // MARK: - Public Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initDefaults()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(currentSpeed: Bool, speedLimit: Bool) {
        super.init(frame: .zero)

        initDefaults()
        if speedLimit {
            setupSpeedLimit()
        }
        if currentSpeed {
            setupCurrentSpeedView()
        }
    }
    
    /// Updates current speed label.
    /// - Parameter speed: Current speed.
    public func updateCurrentSpeed(with speed: Int, speeding: Bool) {
        currentSpeedView.currentSpeed = speed
        currentSpeedView.speeding = speeding
    }
    
    /// Updates speed limit.
    ///
    /// - Parameter limit: Limit showed in speed limit view.
    /// - Parameter isAmerica: Boolean value for America or rest of the world speed limit.
    public func updateSpeedLimit(with limit: Int, isAmerica: Bool) {
        guard limit != 0 else {
            speedLimit.isHidden = true
            return
        }
        speedLimit.isHidden = false
        speedLimit.isAmerica = isAmerica
        speedLimit.speedLimit = limit
    }
    
    /// Update units for views.
    ///
    /// - Parameter units: Units format.
    public func updateUnits(_ units: SYUIDistanceUnits) {
        currentSpeedView.unitsFormat = units
    }
    
    // MARK: - Private Methods
    
    private func initDefaults() {
        addSubview(controlsStackView)
        controlsStackView.translatesAutoresizingMaskIntoConstraints = false
        controlsStackView.coverWholeSuperview()
    }
    
    private func setupCurrentSpeedView() {
        currentSpeedView.translatesAutoresizingMaskIntoConstraints = false
        controlsStackView.addArrangedSubview(currentSpeedView)
    }
    
    private func setupSpeedLimit() {
        speedLimit.translatesAutoresizingMaskIntoConstraints = false
        controlsStackView.addArrangedSubview(speedLimit)
    }
    
}
