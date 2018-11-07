import CoreGraphics
import UIKit
import RxSwift
import RxCocoa

public protocol CircularProgressViewDataSource {
    var progress: Observable<CGFloat?> { get }
}

public class CircularProgressView: UIView {
//    MARK: Public properties
    /// Reactive button of the view
    public var buttonRx: Reactive<UIButton> {
        return button.rx
    }
    
    /// public override of isHidden property for views internal purposes
    public override var isHidden: Bool {
        didSet {
            setNeedsDisplay()
            progress == nil || progress == 0.0 ? startInfiniteAnimation() : stopInfiniteAnimation()
        }
    }

//    MARK: - Private properties
    private let color = UIColor.action
    private let button = UIButton()
    private var disposeBag = DisposeBag()
    private var viewModel: CircularProgressViewDataSource?
    private let animationKey = "rotationAnimation"
    
    private var progress: CGFloat? = nil {
        willSet {
            guard var newValue = newValue else { return }
            if !newValue.isLess(than: 1.0) {
                newValue = 1.0
            } else if newValue.isLess(than: 0.0) {
                newValue = 0.0
            }
        }
        
        didSet {
            setNeedsDisplay()
            progress == nil || progress == 0.0 ? startInfiniteAnimation() : stopInfiniteAnimation()
        }
    }
    
//    MARK: - Public methods
    /// Regular UIView init
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    /// Regular UIView init
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    /// Use to setup view with its viewModel that conforms CircularProgressViewDataSource protocol
    public func setup(with viewModel: CircularProgressViewDataSource) {
        self.disposeBag = DisposeBag()
        self.viewModel = viewModel
        
        viewModel.progress.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] progress in
                self?.progress = progress
            }).disposed(by: disposeBag)
    }

    /// Hit test fails whether the view is hidden or point is outside its UIButton
    /// Should not be called outside of the view
    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let converted = convert(point, to: button)
        if converted.x >= 0 && !isHidden {
            return button
        }

        return super.hitTest(point, with: event)
    }
    
    /// Public override of draw and shouldn't be used outside of the view
    override public func draw(_ rect: CGRect) {
        let round = rect.insetBy(dx: 1, dy: 1)
        
        color.setStroke()
        color.setFill()
        
        if let progress = progress {
            let outerCircle = UIBezierPath(ovalIn: round)
            outerCircle.lineWidth = 1
            outerCircle.stroke()
            
            let inset = rect.size.width*0.33
            
            let innerRect = UIBezierPath(rect: rect.insetBy(dx: inset, dy: inset))
            innerRect.fill()
            
            let angle = -(CGFloat.pi/2) + progress * 2.0 * CGFloat.pi
            
            let outerProgress = UIBezierPath(arcCenter: CGPoint(x: rect.size.width/2, y: rect.size.height/2), radius: (round.size.height/2-1), startAngle: -(CGFloat.pi / 2), endAngle: angle, clockwise: true)
            outerProgress.lineWidth = 2
            outerProgress.stroke()
            
        } else {
            let angleStart = 2.0 * CGFloat.pi
            let angleEnd = angleStart - CGFloat.pi / 8.0
            
            let outerProgress = UIBezierPath(arcCenter: CGPoint(x: rect.size.width/2, y: rect.size.height/2), radius: (round.size.height/2-1), startAngle: angleStart, endAngle: angleEnd, clockwise: true)
            outerProgress.lineWidth = 1
            outerProgress.stroke()
        }
        
    }

//    MARK: - Private methods
    private func setupUI() {
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        button.coverWholeSuperview(withMargin: -20)
    }

    private func startInfiniteAnimation() {
        if layer.animation(forKey: animationKey) != nil {
            return
        }

        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = Double.pi * 2.0
        rotationAnimation.duration = 1.0
        rotationAnimation.repeatCount = .greatestFiniteMagnitude

        layer.add(rotationAnimation, forKey: animationKey)
    }
    
    private func stopInfiniteAnimation() {
        guard layer.animation(forKey: animationKey) is CABasicAnimation else { return }
        layer.removeAnimation(forKey: animationKey)
    }

    

   
}
