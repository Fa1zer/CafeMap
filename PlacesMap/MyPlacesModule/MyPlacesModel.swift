//
//  MyPlacesModel.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 09.05.2022.
//

import Foundation
import UIKit
import Combine
import SwiftUI

final class MyPlacesModel: ObservableObject {
    
    @ObservedObject private var dataManager: DataManager
    private var subscriptions = Set<AnyCancellable>()
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        
        self.getAllPlaces()
    }
    
    @Published var places = [Place]()
    
    func getAllPlaces() {
        self.dataManager.getAllUserPlaces()
            .assign(to: \.places, on: self)
            .store(in: &self.subscriptions)
    }
    
}
