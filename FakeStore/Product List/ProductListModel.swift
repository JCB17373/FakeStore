//
//  ProductListModel.swift
//  FakeStore
//
//  Created by Aman Bhatt on 08/03/23.
//

import Foundation
import SwiftyJSON
import RealmSwift
class ProductListModel{
    var response: [ProductListModelData]?
    init(data: JSON) {
     
        if let array = data["response"].array {
            response = array.map {
                ProductListModelData(data: $0)
            }
        }
    }
}
class ProductListModelData{
    var id : String?
    var title : String?
    var price : String?
    var description : String?
    var category : String?
    var image : String?
    var isSelected : Bool = false
    init(data:JSON){
        id = data["id"].stringValue
        title = data["title"].stringValue
        price = data["price"].stringValue
        description = data["description"].stringValue
        category = data["category"].stringValue
        image = data["image"].stringValue
        
       
    }
}
