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
    
    private func createPinView() -> (UIView, SYUIPinView) {
        let pin = SYUIPinView()
        let cont = UIView()
        let containerSize = CGSize(width: 130, height: 130)
        cont.translatesAutoresizingMaskIntoConstraints = false
        cont.addConstraints(cont.widthAndHeightConstraints(with: containerSize))
        cont.addSubview(pin)
        pin.center = CGPoint(x: containerSize.width/2, y: containerSize.width/2)

        return (cont, pin)
    }
    
    private func addPins() {
        let (cont1, pin1) = createPinView()
        pin1.viewModel = SYUIPinViewViewModel(icon: SygicIcon.accomodation, color: .red, selected: false, animated: true)
        pinStack.addArrangedSubview(cont1)
        pin1.delegate = self
        
        let (cont2, pin2) = createPinView()
        pin2.viewModel = SYUIPinViewViewModel(icon: SygicIcon.restaurant, color: .blue, selected: true, animated: false)
        pinStack.addArrangedSubview(cont2)
        pin2.delegate = self

        let (cont3, pin3) = createPinView()
        pin3.viewModel = SYUIPinViewViewModel(icon: SygicIcon.stationPetrol, color: .gray, selected: true, animated: true)
        pinStack.addArrangedSubview(cont3)

        let (cont4, pin4) = createPinView()
        pin4.viewModel = SYUIPinViewViewModel(icon: SygicIcon.restingArea, color: .brown, selected: true, animated: false)
        pinStack.addArrangedSubview(cont4)

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t: Timer) in
            pin3.viewModel.isSelected = !pin3.viewModel.isSelected
            pin4.viewModel.isSelected = !pin4.viewModel.isSelected
        })
    }
}

// MARK: - SYUIPinViewDelegate
extension PinTestViewController : SYUIPinViewDelegate {
    func pinWasTapped(_ pin: SYUIPinView) {
        pin.viewModel.isSelected = !pin.viewModel.isSelected
    }
    
    func pinStateHasChanged(_ pin: SYUIPinView, isSelected: Bool) {
        
    }
}

