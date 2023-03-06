//
//  ProfileViewController.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 05/03/2023.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate,UITextFieldDelegate {
    @IBOutlet var imageIcon:UIImageView!
    var image:UIImage? = nil
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    let imagePickerController = UIImagePickerController()
 
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.title = "Edit Profile"
        imageIcon.layer.borderWidth = 1.0
        imageIcon.layer.masksToBounds = false
        imageIcon.layer.cornerRadius = imageIcon.frame.size.width/2
        imageIcon.clipsToBounds = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageIcon.isUserInteractionEnabled = true
        imageIcon.addGestureRecognizer(tapGestureRecognizer)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
  

       view.addGestureRecognizer(tap)
   
         
        configureItems()
       setElements()
    }
    
   
    
    func setElements (){
        nameTextField.text = SingeltonUser.User.name
        usernameTextField.text = SingeltonUser.User.username
        emailTextField.text = SingeltonUser.User.email
        addressTextField.text = SingeltonUser.User.address
        imageIcon.image = SingeltonUser.User.image
        
        nameTextField.returnKeyType = UIReturnKeyType.next
        usernameTextField.returnKeyType = UIReturnKeyType.next
        emailTextField.returnKeyType = UIReturnKeyType.next
        addressTextField.returnKeyType = UIReturnKeyType.done
        

        
        
    }
  
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func configureItems(){
        navigationItem.rightBarButtonItem = (
            UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTapped(sender:))
          
       ))
       
        navigationItem.leftBarButtonItem = (
            UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelTapped(sender:))

       ))
        
       
       
    }

    
    @objc func saveTapped(sender: UIBarButtonItem) {
        SingeltonUser.User.setuser(nameTextField.text!,usernameTextField.text!,emailTextField.text!, addressTextField.text!, imageIcon.image!)

        self.dismiss(animated: true, completion: nil)
        
    }
  
    @objc func cancelTapped(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)

    }
    
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView

          imagePickerController.allowsEditing = true
          imagePickerController.sourceType = .photoLibrary
          imagePickerController.delegate = self
          present(imagePickerController, animated: true, completion: nil)

    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageIcon.image  = tempImage
        self.image = tempImage
//        let image = UIImage(named: "moon")
//        imageIcon.image = image
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}
