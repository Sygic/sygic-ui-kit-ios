//// GradientProgressExampleController.swift
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


class GradientProgressExampleController: UIViewController {
    
    var gradients = [SYUICircleGradientProgressView]()
    var progress: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let defaultGradient = SYUICircleGradientProgressView()
        defaultGradient.frame = CGRect(x: 0, y: 100, width: 100, height: 100)
        gradients.append(defaultGradient)
        
        let fullGradient = SYUICircleGradientProgressView()
        fullGradient.dashLength = 1000
        fullGradient.dashSpace = 0
        fullGradient.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        fullGradient.backgroundColor = .lightGray
        gradients.append(fullGradient)
        
        let cutGradient = SYUICircleGradientProgressView()
        cutGradient.progressOffset = 0.3
        cutGradient.frame = CGRect(x: 200, y: 100, width: 100, height: 100)
        gradients.append(cutGradient)
        
        let blueGradient = SYUICircleGradientProgressView()
        blueGradient.gradientColors = [UIColor.white.cgColor, UIColor.blue.cgColor]
        blueGradient.frame = CGRect(x: 0, y: 200, width: 100, height: 100)
        gradients.append(blueGradient)
        
        let blueGradient2 = SYUICircleGradientProgressView()
        blueGradient2.gradientColors = [UIColor.white.cgColor, UIColor.blue.cgColor]
        blueGradient2.dashLength = 30
        blueGradient2.frame = CGRect(x: 100, y: 200, width: 100, height: 100)
        gradients.append(blueGradient2)
        
        let blueGradient3 = SYUICircleGradientProgressView()
        blueGradient3.gradientColors = [UIColor.white.cgColor, UIColor.blue.cgColor]
        blueGradient3.dashSpace = 10
        blueGradient3.dashWidth = 10
        blueGradient3.frame = CGRect(x: 200, y: 200, width: 100, height: 100)
        gradients.append(blueGradient3)
        
        let bigGradient = SYUICircleGradientProgressView()
        bigGradient.translatesAutoresizingMaskIntoConstraints = false
        bigGradient.dashCap = .round
        bigGradient.dashSpace = 25
        bigGradient.dashWidth = 20
        bigGradient.gradientColors = [UIColor.green.cgColor, UIColor.orange.cgColor, UIColor.red.cgColor]
        bigGradient.progressOffset = 0.3
        bigGradient.backgroundColor = .lightGray
        gradients.append(bigGradient)
        
        for g in gradients {
            view.addSubview(g)
        }
        
        bigGradient.widthAnchor.constraint(equalToConstant: 300).isActive = true
        bigGradient.heightAnchor.constraint(equalTo: bigGradient.widthAnchor, multiplier: 1).isActive = true
        bigGradient.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bigGradient.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let weakSelf = self else {
                timer.invalidate()
                return
            }
            weakSelf.updateProgress()
        }
    }
    
    func updateProgress() {
        if progress < 10 {
            progress = progress+1
        } else {
            progress = 0
        }
        for g in gradients {
            g.progress = CGFloat(progress)*0.1
        }
    }
}
