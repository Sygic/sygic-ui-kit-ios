import UIKit
import MapKit
import SygicUIKit

class CompassTestViewController: UIViewController {
    private let mapView = MKMapView()
    private let compassController = SYUICompassController(course: 0, autoHide: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.coverWholeSuperview()
        mapView.showsCompass = false
        mapView.delegate = self
        mapView.isRotateEnabled = true
        
        let region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: 48.14816, longitude: 17.10674), 500, 500);
        mapView.setRegion(region, animated: true)
        
        view.addSubview(compassController.compass)
        view.bringSubview(toFront: compassController.compass)
        compassController.compass.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -16).isActive = true
        compassController.compass.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 16).isActive = true
        
        compassController.delegate = self
    }
}

extension CompassTestViewController: MKMapViewDelegate {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
       compassController.course = 360 - mapView.camera.heading
    }
}

extension CompassTestViewController: SYUICompassDelegate {
    func compassDidTap(_ compass: SYUICompass) {
        if let camera = mapView.camera.copy() as? MKMapCamera {
            camera.heading = 0
            mapView.setCamera(camera, animated: true)
        }
    }
}
