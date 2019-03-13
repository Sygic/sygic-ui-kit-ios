//// PinTestViewController.swift
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

import UIKit
import SygicUIKit

class PinTestViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let pinStack = UIStackView()
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .bar
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.coverWholeSuperview()
        
        pinStack.translatesAutoresizingMaskIntoConstraints = false
        pinStack.spacing = 16
        pinStack.distribution = .equalSpacing
        pinStack.axis = .vertical
        pinStack.alignment = .center
        
        scrollView.addSubview(pinStack)
        pinStack.coverWholeSuperview(withMargin: 16)
        pinStack.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        addPins()
    }
    
    private func createPinView(icon: String, color: UIColor, highlighted: Bool, animatedHighlight: Bool) -> (UIView, SYUIPinView) {
        let pin = SYUIPinView(icon: icon, color: color, highlighted: highlighted, animatedHighlight: animatedHighlight)
        let cont = UIView()
        let containerSize = CGSize(width: 130, height: 130)
        cont.translatesAutoresizingMaskIntoConstraints = false
        cont.addConstraints(cont.widthAndHeightConstraints(with: containerSize))
        cont.addSubview(pin)
        pin.center = CGPoint(x: containerSize.width/2, y: containerSize.width/2)

        return (cont, pin)
    }
    
    private func addPins() {
        let (cont1, pin1) = createPinView(icon: SYUIIcon.accomodation, color: .red, highlighted: false, animatedHighlight: true)
        pinStack.addArrangedSubview(cont1)
        pin1.delegate = self
        
        let (cont2, pin2) = createPinView(icon: SYUIIcon.restaurant, color: .blue, highlighted: true, animatedHighlight: false)
        pinStack.addArrangedSubview(cont2)
        pin2.delegate = self

        let (cont3, pin3) = createPinView(icon: SYUIIcon.stationPetrol, color: .gray, highlighted: true, animatedHighlight: true)
        pinStack.addArrangedSubview(cont3)

        let (cont4, pin4) = createPinView(icon: SYUIIcon.restingArea, color: .brown, highlighted: true, animatedHighlight: false)
        pinStack.addArrangedSubview(cont4)

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t: Timer) in
            pin3.isHighlighted = !pin3.isHighlighted
            pin4.isHighlighted = !pin4.isHighlighted
        })
    }
}

// MARK: - SYUIPinViewDelegate
extension PinTestViewController : SYUIPinViewDelegate {
    func pinWasTapped(_ pin: SYUIPinView) {
        pin.isHighlighted = !pin.isHighlighted
    }
    
    func pinStateHasChanged(_ pin: SYUIPinView, isHighlighted: Bool) {
        
    }
}

