//// ZoomTestViewController.swift
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
