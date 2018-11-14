import UIKit
import MapKit
import SygicUIKit

class CompassTestViewController: UIViewController {
    private let mapView = MKMapView()
    private let compass = SYUICompass()
    
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
        
        view.addSubview(compass)
        view.bringSubview(toFront: compass)
        compass.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -16).isActive = true
        compass.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 16).isActive = true
        
        compass.viewModel.compassAutoHide = false
    }
}

extension CompassTestViewController: MKMapViewDelegate {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        compass.viewModel.compassCourse = mapView.camera.heading
        //print("map rotation = \(mapView.camera.heading)")
    }
}
