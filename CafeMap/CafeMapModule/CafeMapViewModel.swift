//
//  CafeMapViewModel.swift
//  CafeMap
//
//  Created by Artemiy Zuzin on 05.05.2022.
//

import Foundation
import CoreLocation
import MapKit
import Combine

final class CafeMapViewModel: ObservableObject, Coordinatable {
    
    init() {
        self.model.$coordinateRegion
            .assign(to: \.coordinateRegion, on: self)
            .store(in: &self.subribtions)
    }
    
    @Published var coordinateRegion = MKCoordinateRegion()
    
    var coordinator: NavigationCoordinator?
    private let model = CafeMapModel()
    private var subribtions: Set<AnyCancellable> = []
    
}
