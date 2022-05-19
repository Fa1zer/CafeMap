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
    
    @ObservedObject private var viewModel: PlacesMapViewModel
    
    init(viewModel: PlacesMapViewModel) {
        self.viewModel = viewModel
    }
    
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }()
    
    func makeUIView(context: Context) -> MKMapView {
        let longPressGesture = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleLongPress(sender:)))
        
        self.mapView.addGestureRecognizer(longPressGesture)
        self.mapView.setRegion(self.viewModel.coordinateRegion, animated: true)
        
        self.$viewModel.anotations.wrappedValue.forEach { self.mapView.addAnnotation($0) }
    
        return self.mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        self.$viewModel.anotations.wrappedValue.forEach { self.mapView.addAnnotation($0) }
        self.mapView.setRegion(self.$viewModel.coordinateRegion.wrappedValue, animated: true)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self.mapView)
    }
    
    final class Coordinator {
        private let mapView: MKMapView
        
        init(_ mapView: MKMapView) {
            self.mapView = mapView
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
                
                self.mapView.addAnnotation(anotation)
            }
        }
    }
    
}
