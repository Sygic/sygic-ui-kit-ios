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
            var newModel3 = SYUIPinViewViewModel(with: pin3.viewModel)
            newModel3.isSelected = !newModel3.isSelected
            pin3.viewModel = newModel3

            var newModel4 = SYUIPinViewViewModel(with: pin4.viewModel)
            newModel4.isSelected = !newModel4.isSelected
            pin4.viewModel = newModel4
        })
    }
}

// MARK: - SYUIPinViewDelegate
extension PinTestViewController : SYUIPinViewDelegate {
    func pinWasTapped(_ pin: SYUIPinView) {
        var newModel = SYUIPinViewViewModel(with: pin.viewModel)
        newModel.isSelected = !newModel.isSelected
        pin.viewModel = newModel
    }
    
    func pinStateHasChanged(_ pin: SYUIPinView, isSelected: Bool) {
        
    }
}

