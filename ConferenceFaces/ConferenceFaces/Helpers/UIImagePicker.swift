//
//  UIImagePicker.swift
//  ConferenceFaces
//
//  Created by VITALI KAZLOU on 30.08.22.
//

import SwiftUI

struct UIImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    var imageSource: UIImagePickerController.SourceType = .camera
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: UIImagePicker
        
        init(_ parent: UIImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: UIImagePickerController, didFinishPicking result: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true)
            
            if let image = result[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.image = image
            }
        }
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<UIImagePicker>) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.sourceType = imageSource
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
