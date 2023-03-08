//
//  ProductListCollectionViewCell.swift
//  FakeStore
//
//  Created by Aman Bhatt on 08/03/23.
//

import UIKit

class ProductListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var editImage: UIImageView!
    @IBOutlet weak var deleteImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 5
        backView.layer.shadowOpacity = 0.8
        backView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        backView.layer.shadowRadius = 4.0
        backView.layer.shadowColor = UIColor.lightGray.cgColor
        backView.layer.masksToBounds = false
        }
    

}
