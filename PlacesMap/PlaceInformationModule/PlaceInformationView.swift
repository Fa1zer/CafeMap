//
//  PlaceInformationView.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 08.05.2022.
//

import SwiftUI

struct PlaceInformationView: View {
    
    @ObservedObject private var viewModel: PlaceInformationViewModel
    
    init(viewModel: PlaceInformationViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 15) {
                HStack(alignment: .center, spacing: 15) {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(.gray, lineWidth: 5))
                                 
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 5) {
                        Text("Some Title")
                            .font(.title)
                            .foregroundColor(.black)
                        
                        Text("Some street")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }
                .padding()
                
                Text("\(NSLocalizedString("Description", comment: "")):\n vbfhbhvhfbvhfbvhfbvhfbvfhvbfvbhfhfhhfhfhfhfhfhfhfhfhfhfhhfhfhfhhfhfhfhfhfhfhfhf")
                    .padding()
                    .font(.body)
            }
        }
        .navigationTitle(NSLocalizedString("Information", comment: ""))
    }
    
}

struct PlaceInformationView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceInformationView(viewModel: PlaceInformationViewModel())
            .previewInterfaceOrientation(.portrait)
    }
}
