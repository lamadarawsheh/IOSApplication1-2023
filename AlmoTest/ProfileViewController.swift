//
//  ProfileViewController.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 05/03/2023.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate,UITextFieldDelegate {
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet var imageIcon:UIImageView!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
   
    @IBOutlet weak var nameTextField: UITextField!
    let imagePickerController = UIImagePickerController()
 
    override func viewDidLoad() {
        super.viewDidLoad()

        imageIcon.layer.borderWidth = 1.0
        imageIcon.layer.masksToBounds = false
        imageIcon.layer.cornerRadius = imageIcon.frame.size.width/2
        imageIcon.clipsToBounds = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageIcon.isUserInteractionEnabled = true
        imageIcon.addGestureRecognizer(tapGestureRecognizer)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
  
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow),
               name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden),
               name: UIResponder.keyboardWillHideNotification, object: nil)


       view.addGestureRecognizer(tap)
   
        nameTextField.delegate = self
        usernameTextField.delegate = self
        emailTextField.delegate = self
        addressTextField.delegate = self
        configureItems()
        setElements()
    }
    
    @objc func keyboardDidShow(notification: Notification) {
       
        let activeField = view
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 30, right: 0.0)
        scrollview.contentInset = contentInsets
        scrollview.scrollIndicatorInsets = contentInsets
        let activeRect = activeField!.convert(activeField!.bounds, to: scrollview)
        scrollview.scrollRectToVisible(activeRect, animated: true)
    }

    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: -90, right: 0.0)
        scrollview.contentInset = contentInsets
        scrollview.scrollIndicatorInsets = contentInsets
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {

        switchBasedNextTextField(textField)
        return true
    }
   func switchBasedNextTextField(_ textField: UITextField){
       switch textField {
       case self.nameTextField:
           self.usernameTextField.becomeFirstResponder()
       case self.usernameTextField:
           self.emailTextField.becomeFirstResponder()
       case self.emailTextField:
           self.addressTextField.becomeFirstResponder()
       case self.addressTextField:
           view.endEditing(true)
           
       default:
           self.nameTextField.resignFirstResponder()
       }
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
  
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    func configureItems()
    {
        navigationItem.rightBarButtonItem = (
            UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTapped(sender:))
          
       ))
       
        navigationItem.leftBarButtonItem = (
            UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelTapped(sender:))

       ))
        
       
       
    }

    
    @objc func saveTapped(sender: UIBarButtonItem)
    {
        SingeltonUser.User.setuser(nameTextField.text!,usernameTextField.text!,emailTextField.text!, addressTextField.text!, imageIcon.image!)

        self.dismiss(animated: true, completion: nil)
    }
  
    @objc func cancelTapped(sender: UIBarButtonItem)
    {
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
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}
