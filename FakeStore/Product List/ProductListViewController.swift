//
//  ProductListViewController.swift
//  FakeStore
//
//  Created by Aman Bhatt on 08/03/23.
//

import UIKit
import SwiftyJSON
class ProductListViewController: UIViewController {
    var requestMethods : HTTPMethods = .get
    var apiName = "products"
    let viewModel = ProductListViewModel()
    @IBOutlet weak var productListCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.controller = self
        self.viewModel.collectionView = productListCollectionView
        self.navigationItem.title = "Product List"
        productListCollectionView.register(UINib(nibName: "ProductListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductListCollectionViewCell")
        makeRequest()
        viewModel.didTapCallback = { id in
            self.apiName += "/"  + id
            self.requestMethods = .delete
            self.makeRequest()
        }
    }
    func makeRequest(){
//        NetworkManager.sharedInstance.showHideActivityIndicator(viewController: self, action: true)
        NetworkManager.sharedInstance.callingRequest(params: [:], apiname: apiName, view: self, requestType: self.requestMethods) { responseObject in
            switch responseObject{
            case .success(let response) :
                if self.apiName.contains("/"){
                    DispatchQueue.main.async {
                        let data = JSON(rawValue: response) ?? []
                        self.viewModel.deleteProduct(id: data["id"].stringValue)
                    }
                }else{
                    var dict = [String:Any]()
                    dict["response"] = response
                    DispatchQueue.main.async {
                        self.viewModel.dataModel = ProductListModel(data: JSON(rawValue: dict) ?? [])
                        self.productListCollectionView.delegate = self.viewModel
                        self.productListCollectionView.dataSource = self.viewModel
                        self.productListCollectionView.reloadData()
                    }
                }
               
                
//                NetworkManager.sharedInstance.showHideActivityIndicator(viewController: self, action: false)
            case .failure(let error) :
               
                print(error)
            }
            
        }
    }
    
    @IBAction func addClicked(_ sender: UIBarButtonItem) {
        let storyboardRef = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboardRef.instantiateViewController(withIdentifier: "AddEditProductViewController") as! AddEditProductViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
