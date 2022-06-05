//
//  RedactPlaceView.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 09.05.2022.
//

import SwiftUI

struct RedactPlaceView: View {
    
    @ObservedObject private var viewModel: RedactPlaceViewModel
    
    init(viewModel: RedactPlaceViewModel) {
        self.viewModel = viewModel
    }
    
    @State var myPlacesIsSelected = false
    @State private var showSheet = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .center, spacing: 15) {
                HStack(spacing: 15) {
                    Image(uiImage: UIImage(data: Data(base64Encoded: self.viewModel.place.image ?? "") ?? Data()) ?? (UIImage(named: "empty") ?? UIImage()))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
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
                    .frame(height: 500)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(
                        .gray,
                        lineWidth: 0.5
                    ))
                    .background(Color(uiColor: .systemGray6))
                
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
                
                NavigationLink("", destination: self.viewModel.goToPlacesMap(), isActive: self.$myPlacesIsSelected)
                    .hidden()
            }
            .padding()
        }
        .navigationBarTitle(NSLocalizedString("Redact", comment: ""))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    self.viewModel.deletePlace()
                    self.myPlacesIsSelected = true
                } label: {
                    Image(uiImage: UIImage(systemName: "trash") ?? UIImage())
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                }
            }
        }
        .sheet(isPresented: self.$showSheet) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$viewModel.place.image)
        }
    }
    
}

struct RedactPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        RedactPlaceView(viewModel: RedactPlaceViewModel(model: RedactPlaceModel(dataManager: DataManager(), place: Place(id: UUID(), name: "", street: "", placeDescription: "", lat: 0, lon: 0, userID: UUID()))))
    }
}
