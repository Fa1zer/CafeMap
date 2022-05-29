//
//  AddPlaceView.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 23.05.2022.
//

import SwiftUI

struct AddPlaceView: View {
    
    @ObservedObject private var viewModel: AddPlaceViewModel
    
    init(viewModel: AddPlaceViewModel) {
        self.viewModel = viewModel
    }
    
    @State private var showSheet = false
    @State var myPlacesIsSelected = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .center, spacing: 15) {
                HStack(spacing: 15) {
                    Image(uiImage: UIImage(data: Data(base64Encoded: self.viewModel.place.image ?? "") ?? Data()) ?? (UIImage(named: "empty") ?? UIImage()))
                        .resizable()
                        .frame(width: 115, height: 115)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(.gray, lineWidth: 5))
                        .onTapGesture {
                            self.showSheet = true
                        }
                    
                    VStack(alignment: .center, spacing: 15) {
                        TextField(NSLocalizedString("Name", comment: ""), text: self.$viewModel.place.name)
                            .padding()
                            .frame(height: 50)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(
                                .gray,
                                lineWidth: 0.5
                            ))
                            .background(Color(uiColor: .systemGray6))
                        
                        TextField(NSLocalizedString("Street", comment: ""), text: self.$viewModel.place.street)
                            .padding()
                            .frame(height: 50)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(
                                .gray,
                                lineWidth: 0.5
                            ))
                            .background(Color(uiColor: .systemGray6))
                    }
                    .frame(height: 115)
                }
                
                HStack {
                    Text("\(NSLocalizedString("Description", comment: "")):")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                
                TextEditor(text: self.$viewModel.place.placeDescription)
                    .padding()
                    .frame(height: 200)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(
                        .gray,
                        lineWidth: 0.5
                    ))
                    .background(Color(uiColor: .systemGray6))
                
                MyMapView(viewModel: self.viewModel)
                    .frame(height: 350)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(
                        .gray,
                        lineWidth: 0.5
                    ))
                
                Button {
                    self.viewModel.saveChanges()
                    self.myPlacesIsSelected = true
                } label: {
                    HStack {
                        Spacer()
                        
                        Text(NSLocalizedString("Save", comment: ""))
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                }
                .frame(height: 50)
                .background(.blue)
                .cornerRadius(10)
            }
            .padding()
            
            NavigationLink("", destination: self.viewModel.goToPlacesMap(), isActive: self.$myPlacesIsSelected)
                .hidden()
        }
        .navigationBarTitle(NSLocalizedString("Redact", comment: ""))
        .sheet(isPresented: self.$showSheet) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$viewModel.place.image)
        }
    }
    
}

struct AddPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlaceView(viewModel: AddPlaceViewModel(model: AddPlaceModel(dataManager: DataManager(), locationManager: LocationManager.shared)))
    }
}
