import UIKit
import MapKit
import SygicUIKit


class ZoomTestViewController: UIViewController {
    
    private let mapView = MKMapView()
    private let zoomControl = SYUIZoomController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.coverWholeSuperview()
        mapView.isRotateEnabled = true

        zoomControl.delegate = self
        
        view.addSubview(zoomControl.expandableButtonsView)
        zoomControl.expandableButtonsView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 16).isActive = true
        zoomControl.expandableButtonsView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -16).isActive = true
    }
    
}

extension ZoomTestViewController: SYUIZoomControllerDelegate {
    
    func zoomController(wants activity: SYUIZoomActivity) {
        switch activity {
        case .zoomIn, .zoomingIn:
            updateZoomIn()
        
        case .zoomOut, .zoomingOut:
            updateZoomOut()
            
        case .toggle3D:
            let camera = mapView.camera
            camera.pitch = zoomControl.is3D ? 0 : 50
            mapView.setCamera(camera, animated: true)
            
            zoomControl.is3D = !zoomControl.is3D
            
        default:
            break

        }
    
    }
    
    func updateZoomIn() {
        let camera = mapView.camera
        camera.altitude -= 10_000
        mapView.setCamera(camera, animated: true)
    }
    
    func updateZoomOut() {
        let camera = mapView.camera
        camera.altitude += 10_000
        mapView.setCamera(camera, animated: true)
    }
    
}
