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
    @State private var registrationIsPresented = false
    @State var direction = ""
    
    init(viewModel: PlacesMapViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Map(coordinateRegion: self.$viewModel.coordinateRegion, interactionModes: .all, showsUserLocation: true, userTrackingMode: self.$mapUserTrackingMode, annotationItems: self.viewModel.places) { place in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(place.lat), longitude: CLLocationDegrees(place.lon))) {
                    Image("pin")
                        .resizable()
                        .frame(width: 20, height: 28)
                        .onTapGesture {
                            self.viewModel.currentPlace = place
                            self.viewModel.image = UIImage(data: Data(base64Encoded: place.image ?? "") ?? Data()) ?? (UIImage(named: "empty") ?? UIImage())
                            self.viewModel.name = place.name
                            self.viewModel.street = place.street
                        }
                }
            }
            .onAppear() {
                self.viewModel.getAllPlaces()
                self.viewModel.getUserLocation()
            }
            
            if self.viewModel.name != "" {
                HStack(alignment: .center, spacing: 15) {
                    Image(uiImage: self.viewModel.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(.gray, lineWidth: 5))
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(self.viewModel.name)
                            .font(.title)
                            .foregroundColor(.black)
                        
                        Text(self.viewModel.street)
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        self.viewModel.goToPlaceInformation(place: self.viewModel.currentPlace)
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
            
            NavigationLink("", destination: self.viewModel.goToRegistration(), isActive: self.$registrationIsPresented)
                .onSubmit {
                    self.registrationIsPresented = false
                }
        }
        .navigationBarTitle(NSLocalizedString("Map", comment: ""))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.registrationIsPresented = true
                } label: {
                    Text(NSLocalizedString("Sign Out", comment: ""))
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink("My places", destination: self.viewModel.goToMyPlaces())
            }
        }
    }
    
}

struct CafeMapView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesMapView(viewModel: PlacesMapViewModel(model: PlacesMapModel(dataManager: DataManager(), locationManager: LocationManager.shared)))
    }
}
