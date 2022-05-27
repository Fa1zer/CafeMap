//
//  CustomImage.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 27.05.2022.
//

import Foundation
import SwiftUI

struct CustomImage: UIViewRepresentable {
    
    typealias UIViewType = UIImageView
    
    @ObservedObject private var viewModel: AddPlaceViewModel
    
    init(viewModel: AddPlaceViewModel) {
        self.viewModel = viewModel
    }
    
    private let imageView = UIImageView()
    private var coordinator: Coordinator { Coordinator(viewModel: self.viewModel) }
    
    func makeUIView(context: Context) -> UIImageView {
        let longPressGesture = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(self.coordinator.pushImagePicker))
        
        self.imageView.addGestureRecognizer(longPressGesture)
        self.imageView.image = UIImage(data: self.viewModel.place.image ?? Data()) ?? (UIImage(named: "empty") ?? UIImage())
        
        return self.imageView
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) {
        self.imageView.image = UIImage(data: self.viewModel.place.image ?? Data()) ?? (UIImage(named: "empty") ?? UIImage())
    }
    
    func makeCoordinator() -> Coordinator {
        return self.coordinator
    }
    
    final class Coordinator: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        @ObservedObject private var viewModel: AddPlaceViewModel
        
        init(viewModel: AddPlaceViewModel) {
            self.viewModel = viewModel
            
            super.init(nibName: nil, bundle: nil)
            
            self.imagePicker.delegate = self
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private let imagePicker: UIImagePickerController = {
           let controller = UIImagePickerController()
            
            controller.sourceType = .photoLibrary
            controller.allowsEditing = true
            
            return controller
        }()
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = (info[UIImagePickerController.InfoKey(
                rawValue: "UIImagePickerControllerEditedImage"
            )] as? UIImage)?.pngData() else { return }
            
            self.viewModel.place.image = image
        }
        
        @objc func pushImagePicker() {
            self.present(imagePicker, animated: true)
        }
        
    }
    
}
