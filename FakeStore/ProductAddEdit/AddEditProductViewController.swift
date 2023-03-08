//
//  AddEditProductViewController.swift
//  FakeStore
//
//  Created by Aman Bhatt on 08/03/23.
//

import UIKit

class AddEditProductViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addImageView: UIImageView!
    
    @IBOutlet weak var productName: UITextField!
    
    @IBOutlet weak var productPrice: UITextField!
    
    @IBOutlet weak var productDescription: UITextView!
    var isEditProduct = false
    var dataModel : ProductListModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        imageView.addTapGestureRecognizer {
            self.addEditProductImage()
        }
    }
    func addEditProductImage(){
        let alert = UIAlertController(title: "UPLOAD", message: nil, preferredStyle: .actionSheet)
        
        let takeAction = UIAlertAction(title: "Take a photo", style: .default, handler: take)
        let upload = UIAlertAction(title: "Upload from library", style: .default, handler: uploadImage)
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancel)
        
        alert.addAction(takeAction)
        alert.addAction(upload)
        alert.addAction(CancelAction)
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x:self.view.bounds.size.width / 2.0, y: self.view.bounds.size.height / 2.0, width : 1.0, height : 1.0)
        
        self.present(alert, animated: true, completion: nil)
    }
    func take(alertAction: UIAlertAction!) {
        
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = false
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    func uploadImage(alertAction: UIAlertAction!) {
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = false
        self.present(picker, animated: true, completion: nil)
        
    }
    func cancel(alertAction: UIAlertAction!) {
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print(image)
            self.imageView.image = image
            
        } else {
            print("Something went wrong")
        }
        self.dismiss(animated: true, completion: nil)
    }
    func setViews(){
        self.imageView.layer.cornerRadius = 5
        self.imageView.layer.borderWidth = 1
        self.imageView.layer.borderColor = UIColor.lightGray.cgColor
        self.imageView.layer.masksToBounds = false
        self.productDescription.layer.cornerRadius = 5
        self.productDescription.layer.borderWidth = 1
        self.productDescription.layer.borderColor = UIColor.lightGray.cgColor
        self.productDescription.layer.masksToBounds = false
        self.productDescription.textColor = .lightGray
        if self.isEditProduct{
            self.addImageView.image = UIImage(named: "edit")
            self.navigationItem.title = "Edit Product"
        }else{
            self.addImageView.image = UIImage(named: "add")
            self.navigationItem.title = "Add Product"
        }
    }
    @IBAction func saveClicked(_ sender: UIButton) {
    }
    
    
}
