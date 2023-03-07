//
//  ProfileViewController.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 05/03/2023.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate,UITextFieldDelegate,UIActionSheetDelegate {
    
    @IBOutlet weak var editIcon: UIImageView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet var imageIcon:UIImageView!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    let defaultImage:UIImage = UIImage(named: "profile")!
    var isNameEdited:Bool = false
    var isUserNameEdited:Bool = false
    var isEmailEdited:Bool = false
    
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImages()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageIcon.isUserInteractionEnabled = true
        imageIcon.addGestureRecognizer(tapGestureRecognizer)
        editIcon.addGestureRecognizer(tapGestureRecognizer2)
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
    func setImages(){
        imageIcon.layer.borderWidth = 1.0
        imageIcon.layer.masksToBounds = false
        imageIcon.layer.cornerRadius = imageIcon.frame.size.width/2
        imageIcon.clipsToBounds = true
        
        editIcon.layer.masksToBounds = false
        editIcon.layer.cornerRadius = editIcon.frame.size.width/2
        editIcon.clipsToBounds = true
        
        
        
        
        
    }
    
    
    @objc func keyboardDidShow(notification: Notification) {
        
        
        //
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print (keyboardSize.height)
            let activeField = view
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            scrollview.contentInset = contentInsets
            scrollview.scrollIndicatorInsets = contentInsets
            let activeRect = activeField!.convert(activeField!.bounds, to: scrollview)
            scrollview.scrollRectToVisible(activeRect, animated: true)
        }
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
        if(!SingeltonUser.User.name.isEmpty){
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
        else{
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if(textField == self.nameTextField)
        {
            print ("lllll")
            if(!self.nameTextField.text!.isEmpty)
            {
                isNameEdited = true
                
            }
            else
            {
                isNameEdited = false
            }
            print ("name")
            print(isNameEdited)
        }
        else if(textField == self.usernameTextField)
        {
            if(!self.usernameTextField.text!.isEmpty)
            {
                isUserNameEdited = true
                
            }
            else
            {
                isUserNameEdited = false
            }
            print ("uname")
            print(isUserNameEdited)
        }
        else if(textField == self.emailTextField)
        {
            if(!self.emailTextField.text!.isEmpty)
            {
                isEmailEdited = true
                
            }
            else
            {
                isEmailEdited = false
            }
            print ("em")
            print(isEmailEdited)
        }
        
        if(isNameEdited == true && isUserNameEdited == true && isEmailEdited == true)
        {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
        else {
            navigationItem.rightBarButtonItem?.isEnabled = false
            
        }
        
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
        
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        
        let firstAction: UIAlertAction = UIAlertAction(title: "Pick Photo", style: .default) { [self] action -> Void in
            
            let tappedImage = tapGestureRecognizer.view as! UIImageView
            imagePickerController.allowsEditing = false
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.delegate = self
            present(self.imagePickerController, animated: true, completion: nil)
        }
        
        let secondAction: UIAlertAction = UIAlertAction(title: "Delete Photo", style: .default) { [self] action -> Void in
            
            imageIcon.image = self.defaultImage
            
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        
        
        actionSheetController.addAction(firstAction)
        if(imageIcon.image != defaultImage){
            actionSheetController.addAction(secondAction)
        }
        
        actionSheetController.addAction(cancelAction)
        
        actionSheetController.popoverPresentationController?.sourceView = view
        present(actionSheetController, animated: true) {
        }
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
