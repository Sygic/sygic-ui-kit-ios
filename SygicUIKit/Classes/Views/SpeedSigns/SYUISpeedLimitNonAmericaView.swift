//// SYUISpeedLimitNonAmericaView.swift
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


/// View that shows speed limit.
public class SYUISpeedLimitNonAmericaView: UIView, SYUISpeedLimit {
    
    // MARK: - Public Properties
    
    /// Actual speed limit displayed.
    public var speedLimit = 0 {
        didSet {
            speedLimitLabel.attributedText = NSAttributedString(string: String(speedLimit), attributes: [NSAttributedString.Key.font: UIFont(name: "DINCondensed-Bold", size: 30)!, NSAttributedString.Key.baselineOffset: -3])
        }
    }
    
    // MARK: - Private Properties
    
    private let speedLimitSize: CGFloat = 56
    
    private let speedLimitLabel: UILabel = {
        let label = UILabel()
        label.textColor = .accentSecondary
        return label
    }()
    
    // MARK: - Public Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initDefaults()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func initDefaults() {
        layer.cornerRadius = speedLimitSize / 2
        layer.borderWidth = 6
        layer.borderColor = UIColor.red.cgColor
        backgroundColor = .accentBackground
        widthAnchor.constraint(equalToConstant: speedLimitSize).isActive = true
        heightAnchor.constraint(equalToConstant: speedLimitSize).isActive = true
        
        speedLimitLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(speedLimitLabel)
        speedLimitLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        speedLimitLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
}
