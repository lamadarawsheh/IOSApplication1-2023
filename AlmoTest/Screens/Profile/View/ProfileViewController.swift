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
    let imagePickerController = UIImagePickerController()
    let profileViewModel = ProfileViewModel()
    
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
        let activeField = view
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: view.frame.origin.y + 200 , right: 0.0)
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
        navigationItem.rightBarButtonItem?.isEnabled = !SingeltonUser.User.name.isEmpty
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == self.nameTextField
        {
            profileViewModel.checkNameField(self.nameTextField.text!)
        }
        else if textField == self.usernameTextField
        {
            profileViewModel.checkUserNameField(self.usernameTextField.text!)
            
        }
        else if textField == self.emailTextField
        {
            profileViewModel.checkEmailField(self.emailTextField.text!)
            
        }
        
        navigationItem.rightBarButtonItem?.isEnabled = profileViewModel.saveButtonEnabeled()
        
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
            
            _ = tapGestureRecognizer.view as! UIImageView
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
        
        if imageIcon.image != defaultImage
        {
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
