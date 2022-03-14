//
//  File.swift
//  Navigation
//
//  Created by Марк Пушкарь on 14.03.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapView : UIView, MKMapViewDelegate {
    
    var pinCoordinates : [CLLocationCoordinate2D] = []
    
    lazy var mapView : MKMapView = {
        let view = MKMapView()
        view.delegate = self
        view.showsCompass = true
        view.showsUserLocation = true
        view.showsBuildings = true
        view.translatesAutoresizingMaskIntoConstraints = false
        let gestureRecognizer = UILongPressGestureRecognizer(
            target: self,
            action: #selector(pinLocation(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 2
        view.addGestureRecognizer(gestureRecognizer)
                
        return view
    }()
    
    @objc private func pinLocation(gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: self.mapView)
            let touchCoordinates = self.mapView.convert(
                touchPoint,
                toCoordinateFrom: self.mapView)

            pinCoordinates.append(touchCoordinates)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchCoordinates
            
            let latitudeString = String(format: "%.2f", touchCoordinates.latitude)
            
            let longitudeString = String(format : "%.2f", touchCoordinates.longitude)
            
            annotation.title = "(\(latitudeString), \(longitudeString))"

            self.mapView.addAnnotation(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 3
        renderer.strokeColor = .systemRed
        return renderer
    }
    
    private func setupView(){
        addSubview(mapView)

        let constraints = [
            mapView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            mapView.leftAnchor.constraint(equalTo: self.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
        
    init(viewFrame : CGRect) {
        super.init(frame: viewFrame)
        self.backgroundColor = .systemBackground
        setupView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented for MainView")
    }
    
    
}
