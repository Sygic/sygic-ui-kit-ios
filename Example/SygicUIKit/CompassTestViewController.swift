//// CompassTestViewController.swift
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
