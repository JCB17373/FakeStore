//
//  AddEditProductViewController.swift
//  FakeStore
//
//  Created by Aman Bhatt on 08/03/23.
//

import UIKit

class AddEditProductViewController: UIViewController {
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
        alert.popoverPresentationController?.sourceView = self
        alert.popoverPresentationController?.sourceRect = CGRect(x:self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0, width : 1.0, height : 1.0)
        
        self.present(alert, animated: true, completion: nil)
    }
    func take(alertAction: UIAlertAction!) {
        
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = false
        picker.delegate = self
        self.viewContainingController?.present(picker, animated: true, completion: nil)
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
extension AddEditProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print(image)
            if let data = image.jpegCompressToMaxLimit() {
                print(data, data.count)
                var fileName = "image.jpeg"
                if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
                    fileName = url.lastPathComponent
                }

            }
        } else {
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
