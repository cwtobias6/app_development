//
//  ViewController.swift
//  Foodie
//
//  Created by Christian Tobias on 10/28/17.
//  Copyright © 2017 Christian Tobias. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
    }

    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
            
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                imageView.image = image
                
                
            } else {
                print("There was an error in the image.")
            }
            
        }
    }
    

}

