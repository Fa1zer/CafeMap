//
//  CafeMapModel.swift
//  CafeMap
//
//  Created by Artemiy Zuzin on 05.05.2022.
//

import Foundation
import CoreLocation
import Combine
import MapKit

final class CafeMapModel: ObservableObject {
    
    init() {
        self.locationManager.$coodinateRegion
            .assign(to: \.coordinateRegion, on: self)
            .store(in: &subscriptions)
    }
    
    @Published var coordinateRegion = MKCoordinateRegion()
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private let locationManager = LocationManager.shared
    
}
