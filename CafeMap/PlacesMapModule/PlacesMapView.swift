//
//  CafeMapView.swift
//  CafeMap
//
//  Created by Artemiy Zuzin on 05.05.2022.
//

import SwiftUI
import MapKit

struct PlacesMapView: View {
    
    @ObservedObject private var viewModel: PlacesMapViewModel
    @State private var mapUserTrackingMode: MapUserTrackingMode = .follow
    
    init(viewModel: PlacesMapViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Map(
                    coordinateRegion: self.$viewModel.coordinateRegion,
                    interactionModes: .all,
                    showsUserLocation: true,
                    userTrackingMode: self.$mapUserTrackingMode
                )
                .onAppear() {
                    self.viewModel.getUserLocation()
                }
                
                HStack(alignment: .center, spacing: 15) {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(.gray, lineWidth: 5))
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Some Title")
                            .font(.title)
                            .foregroundColor(.black)
                        
                        Text("Some street")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        self.viewModel.goToRegistration()
                    } label: {
                        Image(uiImage: UIImage(systemName: "info.circle") ?? UIImage())
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                    }
                }
                .padding([.leading, .trailing], 20)
            }
            .navigationBarTitle(NSLocalizedString("Map", comment: ""))
        }
        .navigationBarHidden(true)
    }
    
}

struct CafeMapView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesMapView(viewModel: PlacesMapViewModel())
    }
}
