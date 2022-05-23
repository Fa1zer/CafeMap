//
//  MyMapView.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 10.05.2022.
//

import UIKit
import SwiftUI
import MapKit
import Combine

struct MyMapView: UIViewRepresentable {
    
    typealias UIViewType = MKMapView
    
    @ObservedObject private var viewModel: AddPlaceViewModel
    
    init(viewModel: AddPlaceViewModel) {
        self.viewModel = viewModel
    }
    
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        
        mapView.isZoomEnabled = true
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }()
    
    func makeUIView(context: Context) -> MKMapView {
        let longPressGesture = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleLongPress(sender:)))
        
        self.mapView.addGestureRecognizer(longPressGesture)
        self.mapView.setRegion(self.viewModel.coordinateRegion, animated: true)
        
        return self.mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        self.mapView.setRegion(self.$viewModel.coordinateRegion.wrappedValue, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(mapView: self.mapView, viewModel: self.viewModel)
    }
    
    final class Coordinator: NSObject {
        
        private let mapView: MKMapView
        private let viewModel: AddPlaceViewModel
        
        init(mapView: MKMapView, viewModel: AddPlaceViewModel) {
            self.mapView = mapView
            self.viewModel = viewModel
            
            super.init()
        }
    
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
        @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
            if sender.state == .began {
                let touchPoint = sender.location(in: self.mapView)
                let touchCoordinates = self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
                let anotation = MKPointAnnotation()
                
                anotation.coordinate = touchCoordinates
                
                self.viewModel.lat = Float(touchCoordinates.latitude)
                self.viewModel.lon = Float(touchCoordinates.longitude)
                
                self.mapView.addAnnotation(anotation)
            }
        }
    }
    
}
