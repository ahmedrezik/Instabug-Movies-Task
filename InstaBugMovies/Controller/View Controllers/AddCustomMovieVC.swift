//
//  AddCustomMovie.swift
//  InstaBugMovies
//
//  Created by Ahmed Rezik on 5/20/20.
//  Copyright © 2020 Ahmed Rezik. All rights reserved.
//

import Foundation
import UIKit

public class AddMovieVC: UIViewController{
     var imagePicker = UIImagePickerController() //Photos Album Image Picke
    
    @IBOutlet weak var MovieTitleField: UITextField!
    @IBOutlet weak var YearPicker: UIPickerView!
    @IBOutlet weak var overviewField: UITextView!
    @IBOutlet weak var posterView: UIImageView!
    
    
    
    @IBAction func pickPhoto(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                  print("Button capture")

            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false

                  present(imagePicker, animated: true, completion: nil)
              }
    }
    
    
    @IBAction func Save(_ sender: Any) {
        let YearIndex = YearPicker.selectedRow(inComponent: 0)
        let NewMovie =  CustomMovie(title: MovieTitleField.text ?? "",
                                    releaseYear: String(ClassesModel.Years[YearIndex]),
                                    posterImage: posterView.image,
                                    overview: overviewField.text)
        ClassesModel.userMovies.append(NewMovie)
        NotificationCenter.default.post(name: Notification.Name("didCreateMovie"), object: nil)
        dismiss(animated: true, completion: nil)
        
    
    }
    
    public override func viewDidLoad() {
        overviewFieldSetup()
    }
    
    //Adds a border around the overview textfield for visibilty
    func overviewFieldSetup(){
        overviewField.text = "Enter Movie Overview"
        overviewField.textColor = .lightGray
        overviewField.backgroundColor = .white
        overviewField.layer.borderWidth = 1.5
        overviewField.layer.cornerRadius = 10
        overviewField.accessibilityIdentifier = "OverviewTextView"
    }
    
}

//MARK:- Year Picker View Delegate & DataSource
extension AddMovieVC: UIPickerViewDelegate, UIPickerViewDataSource{
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return ClassesModel.Years.count
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(ClassesModel.Years[row])
    }
    
    
}

//MARK:- IMage Picker Delegate & Data Source
extension AddMovieVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
   
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         imagePicker.dismiss(animated: true, completion: nil)
        
              guard let image = info[.originalImage] as? UIImage else {
                  fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
              }
        posterView.image = image
    }
}

//MARK:- OVerviewTextView Delegate
extension AddMovieVC: UITextViewDelegate{
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
}

extension AddMovieVC: UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       self.view.endEditing(true)
        return true
    }
    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.endEditing(true)
    }
    public  func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
}
