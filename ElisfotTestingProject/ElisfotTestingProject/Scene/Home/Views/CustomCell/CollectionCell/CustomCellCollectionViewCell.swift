//
//  CustomCellCollectionViewCell.swift
//  ElisfotTestingProject
//
//  Created by Neo Truong on 8/26/24.
//

import UIKit

class CustomCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    static let cellIdentify = "CustomCellCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 7.0
        containerView.layer.masksToBounds = true
   
    }
    
    override func prepareForReuse() {
        imageView.image = UIImage(named: "placeHolder_image")
    }
    

}
