//
//  SectionCollectionCell.swift
//  ElisfotTestingProject
//
//  Created by Neo Truong on 8/26/24.
//

import UIKit

class SectionCollectionCell: UICollectionViewCell {
    
    static let cellIdentify = "SectionCollectionCell"
    var images: [Image] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViewSetup()
    }
    
    private func collectionViewSetup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        
        
        let nib = UINib(nibName: CustomCellCollectionViewCell.cellIdentify, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: CustomCellCollectionViewCell.cellIdentify)
        
        collectionView.collectionViewLayout = getCollectionViewLayout()
    }
    
    private func getCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        
        return layout
    }
    
    func bindData(images: [Image]) {
        self.images = images
        
        collectionView.reloadData()
    }
}

extension SectionCollectionCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCellCollectionViewCell.cellIdentify, for: indexPath) as? CustomCellCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let cacheImage = CacheManager.shared.getCachedImage(forKey: images[indexPath.row].imageLink ?? "") {
            cell.imageView.image = cacheImage
        } 
       
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight:CGFloat = collectionView.bounds.height
        let cellWidth = CollectionViewHelper.getCellWidth(collectViewWidth: collectionView.bounds.width)
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}

