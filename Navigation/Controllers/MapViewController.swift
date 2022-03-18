//
//  MapViewController.swift
//  Navigation
//
//  Created by Марк Пушкарь on 14.03.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    private var currentLocation : CLLocationCoordinate2D?

    private let locationManager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(
            latitude: locations[0].coordinate.latitude,
            longitude: locations[0].coordinate.longitude)
        
        self.currentLocation = location
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location, span: span)
        if let ui = self.view as? MapView {
            ui.mapView.setRegion(region, animated: true)
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func makeRoute() {
        guard let current = self.currentLocation else {return}
        
        if let ui = self.view as? MapView {
            let request = MKDirections.Request()
            
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: current))
            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: ui.pinCoordinates[0]))
            request.transportType = .walking
            
            let directions = MKDirections(request: request)
            directions.calculate { [weak ui] response, error in
                guard let response = response else {return}
                
                if let route = response.routes.first {
                    ui?.mapView.addOverlay(route.polyline, level: .aboveRoads)
                    let rect = route.polyline.boundingMapRect
                    ui?.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
                }
            }
        }
    }
    
    private func showAlert(title : String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Strings.AlertButtonTitle.localized, style: .default, handler: { (_) in
            
             }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setupMenu() {
        
        let removeMapPinsItem = UIAction(title: Strings.RemoveMapPinsMenuItem.localized, image: UIImage(systemName: "minus.circle")) { [unowned self] (action) in
            if let ui = self.view as? MapView {
                let annotations = ui.mapView.annotations.filter({ !($0 is MKUserLocation) })
                ui.mapView.removeAnnotations(annotations)
                ui.pinCoordinates.removeAll()
            }
        }

        let removeRouteItem = UIAction(title: Strings.RemoveRoutesMenuItem.localized) { [unowned self] (action) in
            if let ui = self.view as? MapView {
                let currentOverlays = ui.mapView.overlays(in: .aboveRoads)
                ui.mapView.removeOverlays(currentOverlays)
             
                if let myCurrentLocation = self.currentLocation {
                    let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                    let region = MKCoordinateRegion(center: myCurrentLocation, span: span)
                    
                    ui.mapView.setRegion(region, animated: true)
                }
            }
        }

        let createRouteItem = UIAction(title: Strings.CreateRouteMenuItem.localized) { [unowned self ] (action) in
            if let ui = self.view as? MapView {
                let annotations = ui.mapView.annotations.filter({ !($0 is MKUserLocation) })
                
                if annotations.count != 1 || currentLocation == nil {
                    self.showAlert(title: Strings.AlertButtonTitle.localized, message: Strings.CreateRouteAlertMessage.localized)
                } else {
                    makeRoute()
                }
            }
        }

        let menu = UIMenu(title: Strings.MapMenuName.localized,
                          options: .displayInline,
                          children: [removeMapPinsItem,
                                     createRouteItem,
                                     removeRouteItem])

        let navItems = [
            UIBarButtonItem(systemItem: .edit , menu: menu)
        ]

        self.navigationItem.rightBarButtonItems = navItems
    }
    
    private func setupView() {
        let mainView = MapView(viewFrame: self.view.frame)
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLocationManager()
        setupMenu()
    }
    
    
}

