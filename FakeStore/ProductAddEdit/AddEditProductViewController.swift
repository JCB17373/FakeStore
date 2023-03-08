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
