//
//  ProductListViewModel.swift
//  FakeStore
//
//  Created by Aman Bhatt on 08/03/23.
//

import UIKit

class ProductListViewModel: NSObject, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var dataModel : ProductListModel?
    var collectionView : UICollectionView!
    var controller : ProductListViewController?
    var didTapCallback : ((_ id : String) -> Void)?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataModel?.response?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCollectionViewCell", for: indexPath) as! ProductListCollectionViewCell
        cell.imageView.setImage(fromURL: dataModel?.response?[indexPath.row].image ?? "")
        cell.productName.text = dataModel?.response?[indexPath.row].title
        
        cell.productPrice.text = "Price:" + " " + (dataModel?.response?[indexPath.row].price ?? "")
        cell.deleteImage.addTapGestureRecognizer {
            self.didTapCallback?(self.dataModel?.response?[indexPath.row].id ?? "")
           // self.deleteProduct(id: self.dataModel?.response?[indexPath.row].id ?? "")
        }
        cell.editImage.addTapGestureRecognizer {
            
            let storyboardRef = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboardRef.instantiateViewController(withIdentifier: "AddEditProductViewController") as! AddEditProductViewController
            vc.dataModel = self.dataModel
            vc.isEditProduct = true
            self.controller?.navigationController?.pushViewController(vc, animated: true)
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       // return CGSize(width: self.collectionView.frame.width/2 + 1, height: self.collectionView.frame.width/2 + 90)
        
        let noOfCellsInRow = 2

            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

            return CGSize(width: size, height: size)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print()
        let storyboardRef = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboardRef.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        vc.productId = dataModel?.response?[indexPath.row].id ?? ""
        self.controller?.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func deleteProduct(id: String){
        for val in 0..<(self.dataModel?.response?.count ?? 0) {
            if self.dataModel?.response?[val].id == id{
                self.dataModel?.response?.remove(at: val)
                break
            }
        }
    
        self.collectionView.reloadData()
    }
    
}
