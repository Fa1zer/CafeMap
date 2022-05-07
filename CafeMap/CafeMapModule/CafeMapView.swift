//
//  CafeMapView.swift
//  CafeMap
//
//  Created by Artemiy Zuzin on 05.05.2022.
//

import SwiftUI
import MapKit

struct CafeMapView: View {
    
    @ObservedObject private var viewModel: CafeMapViewModel
    
    init(viewModel: CafeMapViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Map(coordinateRegion: $viewModel.coordinateRegion)
    }
    
}

struct CafeMapView_Previews: PreviewProvider {
    static var previews: some View {
        CafeMapView(viewModel: CafeMapViewModel())
    }
}
