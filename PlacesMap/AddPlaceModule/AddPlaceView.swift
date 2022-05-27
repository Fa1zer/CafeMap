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
    
    @State private var myPlacesIsSelected = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .center, spacing: 15) {
                HStack(spacing: 15) {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 115, height: 115)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(.gray, lineWidth: 5))
                    
                    VStack(alignment: .center, spacing: 15) {
                        TextField(NSLocalizedString("Name", comment: ""), text: self.$viewModel.name)
                            .padding()
                            .frame(height: 50)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(
                                .gray,
                                lineWidth: 0.5
                            ))
                            .background(Color(uiColor: .systemGray6))
                        
                        TextField(NSLocalizedString("Street", comment: ""), text: self.$viewModel.street)
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
                
                TextEditor(text: self.$viewModel.description)
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
        }
        .navigationBarTitle(NSLocalizedString("Redact", comment: ""))
    }
    
}

struct AddPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlaceView(viewModel: AddPlaceViewModel(model: AddPlaceModel(dataManager: DataManager(), locationManager: LocationManager.shared)))
    }
}
