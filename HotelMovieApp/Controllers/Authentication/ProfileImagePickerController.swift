//
//  ProfileImagePickerController.swift
//  MoviesDarkFriend
//
//  Created by Andreas Demenagas on 9/21/19.
//  Copyright © 2019 Andreas Demenagas. All rights reserved.
//

import UIKit

class ProfileImagePickerController: UIImagePickerController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var signUpController: SignUpController? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var pickerImage: UIImage?
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            pickerImage = editedImage
        }
            
        else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            pickerImage = originalImage
        }
        
        if let image = pickerImage {
            signUpController?.profileImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}
