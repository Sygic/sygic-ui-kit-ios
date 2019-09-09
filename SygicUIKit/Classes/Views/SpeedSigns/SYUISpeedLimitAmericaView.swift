//// SYUISpeedLimitNorthView.swift
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


/// View that shows speed limit for North America.
public class SYUISpeedLimitAmericaView: UIView, SYUISpeedLimit {
    
    // MARK: - Public Properties
    
    /// Actual speed limit displayed.
    public var speedLimit = 0 {
        didSet {
            speedLimitLabel.attributedText = NSAttributedString(string: String(speedLimit), attributes: [NSAttributedString.Key.font: UIFont(name: "DINCondensed-Bold", size: 32)!, NSAttributedString.Key.baselineOffset: -3])
        }
    }
    
    // MARK: - Private Properties
    
    private let speedLimitLabel: UILabel = {
        let label = UILabel()
        label.textColor = .accentSecondary
        return label
    }()
    
    private let innerBorder: UIView = {
        let innerView = UIView()
        innerView.layer.borderColor = UIColor.black.cgColor
        innerView.layer.borderWidth = 3
        innerView.layer.cornerRadius = 8
        return innerView
    }()
    
    private let limitText: UILabel = {
        let label = UILabel()
        label.textColor = .accentSecondary
        label.attributedText = NSAttributedString(string: "LIMIT", attributes: [NSAttributedString.Key.font: UIFont(name: "DINCondensed-Bold", size: 16)!, NSAttributedString.Key.baselineOffset: -3])
        return label
    }()
    
    private lazy var stackLabel: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.addArrangedSubview(limitText)
        stack.addArrangedSubview(speedLimitLabel)
        return stack
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
        layer.cornerRadius = 8
        backgroundColor = .white
        widthAnchor.constraint(equalToConstant: 56).isActive = true
        heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        stackLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackLabel)
        stackLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        innerBorder.translatesAutoresizingMaskIntoConstraints = false
        addSubview(innerBorder)
        innerBorder.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3).isActive = true
        innerBorder.topAnchor.constraint(equalTo: topAnchor, constant: 3).isActive = true
        innerBorder.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3).isActive = true
        innerBorder.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3).isActive = true
    }
    
}
