//
//  MyPlacesView.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 09.05.2022.
//

import SwiftUI

struct MyPlacesView: View {
    
    @ObservedObject private var viewModel: MyPlacesViewModel
    
    init(viewModel: MyPlacesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List(self.$viewModel.places) { place in
            HStack(alignment: .center, spacing: 15) {
                Image(uiImage: UIImage(data: place.image.wrappedValue ?? Data()) ?? (UIImage(named: "empty") ?? UIImage()))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.gray, lineWidth: 5))
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(place.name.wrappedValue)
                        .font(.title)
                        .foregroundColor(.black)
                    
                    Text(place.street.wrappedValue)
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                NavigationLink("", destination: self.viewModel.goToRedactPlace(place: place.wrappedValue))
            }
            .padding()
        }
        .navigationBarTitle(NSLocalizedString("My places", comment: ""))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: self.viewModel.goToAddPlace()) {
                    Image(uiImage: UIImage(systemName: "plus") ?? UIImage())
                        .renderingMode(.template)
                        .foregroundColor(.blue)
                }
            }
        }
    }
    
}

struct MyPlacesView_Previews: PreviewProvider {
    static var previews: some View {
        MyPlacesView(viewModel: MyPlacesViewModel(model: MyPlacesModel(dataManager: DataManager())))
    }
}
