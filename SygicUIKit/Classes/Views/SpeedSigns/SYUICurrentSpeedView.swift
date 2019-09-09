//// SYUICurrentSpeedView.swift
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


/// View that shows current speed and units format.
public class SYUICurrentSpeedView: UIView {
    
    // MARK: - Public Properties
    
    /// Actual current speed displayed.
    public var currentSpeed = 0 {
        didSet {
            currentSpeedLabel.attributedText = NSAttributedString(string: String(currentSpeed), attributes: [NSAttributedString.Key.font: UIFont(name: "DINCondensed-Bold", size: 28)!, NSAttributedString.Key.baselineOffset: -3])
            updateProgress()
        }
    }
    
    /// Current road speed limit to set maximum value in speed progress bar
    public var speedLimit = 90 {
        didSet {
            updateProgress()
        }
    }
    
    /// Units format displayed under the current speed.
    public var unitsFormat: SYUIDistanceUnits = .kilometers {
        didSet {
            units.text = unitsFormat.speedTitle
        }
    }
    
    /// Actual current speed is highet then speed limit.
    public var speeding = false {
        didSet {
            backgroundColor = speeding ? .error : .accentBackground
            progressView.isHidden = speeding
        }
    }
    
    // MARK: - Private Properties
    
    private let currentSpeedSize: CGFloat = 56
    
    private let currentSpeedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .accentSecondary
        return label
    }()
    
    private let units: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "DINCondensed-Bold", size: 12)
        return label
    }()
    
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.addArrangedSubview(currentSpeedLabel)
        stack.addArrangedSubview(units)
        return stack
    }()
    
    private let progressView: SYUICircleGradientProgressView = {
        let progress = SYUICircleGradientProgressView()
        progress.progressOffset = 0.25
        progress.dashWidth = 3
        progress.dashLength = 4
        progress.dashSpace = 1
        progress.dashedBackground.strokeColor = UIColor.lightGray.cgColor
        return progress
    }()
    
    // MARK: - Public Methods
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initDefaults()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func initDefaults() {
        currentSpeed = 0
        unitsFormat = .kilometers
        backgroundColor = .accentBackground
        
        layer.cornerRadius = currentSpeedSize / 2
        backgroundColor = .white
        widthAnchor.constraint(equalToConstant: currentSpeedSize).isActive = true
        heightAnchor.constraint(equalToConstant: currentSpeedSize).isActive = true
        
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(labelStack)
        labelStack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        labelStack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressView)
        progressView.coverWholeSuperview()
    }
    
    private func updateProgress() {
        progressView.progress = CGFloat(currentSpeed) / CGFloat(speedLimit)
    }
}
