import UIKit
import MapKit
import SygicUIKit


class ZoomTestViewController: UIViewController {
    
    private let mapView = MKMapView()
    private let zoomView = SYUIZoomControlView()
    
    public var zoomingTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.coverWholeSuperview()
        mapView.isRotateEnabled = true
    
        zoomView.viewModel = SYUIZoomControlViewModel(icon2D: SygicIcon.view2D, icon3D: SygicIcon.view3D, iconZoomIn: SygicIcon.zoomIn, iconZoomOut: SygicIcon.zoomOut, is3D: false)
        zoomView.delegate = self
        
        view.addSubview(zoomView)
        zoomView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 16).isActive = true
        zoomView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -16).isActive = true
    }
    
}

extension ZoomTestViewController: SYUIZoomControlViewDelegate {

    func zoomControl(wants activity: SYUIZoomControlActivity) {
        switch activity {
        case .zoomIn:
            let camera = mapView.camera
            camera.altitude -= 10_000
            mapView.setCamera(camera, animated: true)
            
        case .zoomOut:
            let camera = mapView.camera
            camera.altitude += 10_000
            mapView.setCamera(camera, animated: true)
            
        case .toggle3D:
            guard let viewModel = zoomView.viewModel else { return }
            let camera = mapView.camera
            camera.pitch = viewModel.is3D ? 0 : 50
            mapView.setCamera(camera, animated: true)
            
            var newModel = SYUIZoomControlViewModel(with: viewModel)
            newModel.is3D = !viewModel.is3D
            zoomView.viewModel = newModel
            
        case .startZoomIn:
            zoomingTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateZoomIn), userInfo: nil, repeats: true)
            zoomingTimer?.fire()
            
        case .startZoomOut:
            zoomingTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateZoomOut), userInfo: nil, repeats: true)
            zoomingTimer?.fire()
            
        case .stopZooming:
            zoomingTimer?.invalidate()
        }
    }
    
    @objc func updateZoomIn() {
        let camera = mapView.camera
        camera.altitude -= 10_000
        mapView.setCamera(camera, animated: true)
    }
    
    @objc func updateZoomOut() {
        let camera = mapView.camera
        camera.altitude += 10_000
        mapView.setCamera(camera, animated: true)
    }

}
