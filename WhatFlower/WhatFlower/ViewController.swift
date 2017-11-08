//
//  ViewController.swift
//  WhatFlower
//
//  Created by Christian Tobias on 10/29/17.
//  Copyright © 2017 Christian Tobias. All rights reserved.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON
import SDWebImage


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let wikipediaURl = "https://en.wikipedia.org/w/api.php"

    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var uiCamera: UIBarButtonItem!
    @IBOutlet weak var uiImage: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let userPickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            uiImage.image = userPickedImage
            
            guard let convertedCIImage = CIImage(image: userPickedImage) else {
                fatalError("Error converting uiimage to ciimage")
            }
            
            detect(image: convertedCIImage)
            
        }
            
        

        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    func detect(image: CIImage) {
        
        guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
            fatalError("Cannot import model")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            
            guard let classification = request.results?.first as? VNClassificationObservation else {
                fatalError("Could not classify image.")
            }
            
            self.navigationItem.title = classification.identifier.capitalized
            
            self.requestInfo(flowerName: classification.identifier)
            
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])

        } catch {
            print(error)
        }

    }
    
    func requestInfo(flowerName: String) {
        
        let parameters : [String:String] = [
            "format" : "json",
            "action" : "query",
            "prop" : "extracts | pageimages",
            "exintro" : "",
            "explaintext" : "",
            "titles" : flowerName,
            "indexpageids" : "",
            "redirects" : "1",
            "pithumbsize": "500",
            ]
        
        Alamofire.request(wikipediaURl, method: .get, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                print("Got the Wiki Info")
                
                let flowerJSON: JSON = JSON(response.result.value!)
                
                let pageID = flowerJSON["query"]["pageids"][0].stringValue
                
                let flowerDescription = flowerJSON["query"]["pages"][pageID]["extract"].stringValue
                
//                let flowerImageURL = flowerJSON["query"]["pages"][pageID]["thumbnail"]["source"].stringValue
                
//                self.uiImage.sd_setImage(with: URL(string:flowerImageURL))
                
                self.label.text = flowerDescription
                
            }
        }
        
    }


    @IBAction func cameraPressed(_ sender: Any) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    

}

