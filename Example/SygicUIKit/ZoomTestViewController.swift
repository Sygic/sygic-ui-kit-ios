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
    let zoomControl1 = SYUIZoomController()
    let zoomControl2 = SYUIZoomController()
    let zoomControl3 = SYUIZoomController()
    let zoomControl4 = SYUIZoomController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.coverWholeSuperview()
        mapView.isRotateEnabled = true

        zoomControl1.delegate = self
        view.addSubview(zoomControl1.expandableButtonsView)
        zoomControl1.expandableButtonsView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 16).isActive = true
        zoomControl1.expandableButtonsView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -16).isActive = true
        
        zoomControl2.expandableButtonsView.direction = .top
        zoomControl2.delegate = self
        view.addSubview(zoomControl2.expandableButtonsView)
        zoomControl2.expandableButtonsView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -16).isActive = true
        zoomControl2.expandableButtonsView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -16).isActive = true
        
        zoomControl3.expandableButtonsView.direction = .leading
        zoomControl3.delegate = self
        view.addSubview(zoomControl3.expandableButtonsView)
        zoomControl3.expandableButtonsView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -16).isActive = true
        zoomControl3.expandableButtonsView.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 16).isActive = true
        
        zoomControl4.expandableButtonsView.direction = .bottom
        zoomControl4.delegate = self
        view.addSubview(zoomControl4.expandableButtonsView)
        zoomControl4.expandableButtonsView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 16).isActive = true
        zoomControl4.expandableButtonsView.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 16).isActive = true
    }
    
}

extension ZoomTestViewController: SYUIZoomControllerDelegate {
    
    func zoomController(_ controller: SYUIZoomController, wants activity: SYUIZoomActivity) {
        switch activity {
        case .zoomIn, .zoomingIn:
            updateZoomIn()
        
        case .zoomOut, .zoomingOut:
            updateZoomOut()
            
        case .toggle3D:
            let camera = mapView.camera
            camera.pitch = controller.is3D ? 0 : 50
            mapView.setCamera(camera, animated: true)
            
            let is3D = !controller.is3D
            zoomControl1.is3D = is3D
            zoomControl2.is3D = is3D
            zoomControl3.is3D = is3D
            zoomControl4.is3D = is3D
            
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
