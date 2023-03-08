//
//  ProductDetailsViewController.swift
//  FakeStore
//
//  Created by Aman Bhatt on 08/03/23.
//

import UIKit
import SwiftyJSON
class ProductDetailsViewController: UIViewController {
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var productDescription: UILabel!
    var dataModel : ProductListModelData?
    var productId = ""
    var apiName = "products"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Product Details"
        apiName += "/" + productId
        makeRequest()
    }
    
    func makeRequest(){
//        NetworkManager.sharedInstance.showHideActivityIndicator(viewController: self, action: true)
        NetworkManager.sharedInstance.callingRequest(params: [:], apiname: apiName, view: self) { responseObject in
            switch responseObject{
            case .success(let response) :
                DispatchQueue.main.async {
                    self.dataModel = ProductListModelData(data: JSON(rawValue: response) ?? [])
                    self.productImageView.setImage(fromURL: self.dataModel?.image ?? "")
                    self.productName.text = self.dataModel?.title
                    self.productPrice.text = "Price:" + " " + (self.dataModel?.price ?? "")
                    self.productDescription.text = self.dataModel?.description
                   
                }
                
//                NetworkManager.sharedInstance.showHideActivityIndicator(viewController: self, action: false)
            case .failure(let error) :
               
                print(error)
            }
            
        }
    }

}
