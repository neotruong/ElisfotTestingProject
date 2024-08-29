//
//  HomeViewController.swift
//  ElisfotTestingProject
//
//  Created by Neo Truong on 8/26/24.
//

import Foundation
import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: IBOulets
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: Variables
    var images: [ImageSection] = []
    var viewModel: HomeViewModelDelegated!
    // MARK: Constant
    let reloadValue: Int = 140
    
    
    init(viewModel: HomeViewModelDelegated!) {
        super.init(nibName: "HomeViewController", bundle: .main)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetup()
        collectionViewSetup()
    }
    
    private func navBarSetup() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        let reloadButton = UIBarButtonItem(title: "Reload all", style: .done, target: self, action: #selector(reloadButtonTapped))
        
        addButton.customView?.isExclusiveTouch = true
        reloadButton.customView?.isExclusiveTouch = true
        
        navigationItem.leftBarButtonItems = [addButton, reloadButton]
    }
    
    private func collectionViewSetup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        
        let nib = UINib(nibName: SectionCollectionCell.cellIdentify, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: SectionCollectionCell.cellIdentify)
        
        collectionView.collectionViewLayout = getCollectionViewLayout()
    }
    
    private func getCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        
        return layout
    }
    
    private func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    fileprivate func addTempImage(currentSection: [ImageSection]) -> [ImageSection] {
        var currentSection: [ImageSection] = currentSection
        if images.count == 0 {
            currentSection.append(ImageSection(data: [Image()]))
        } else if images.last!.data.count == 7 {
            currentSection.append(ImageSection(data: [Image()]))
        } else {
            currentSection[images.count - 1].data.append(Image())
        }
        
        return currentSection
    }
    
    @objc func addButtonTapped() {
        UIApplication.shared.showLoading()
        images = addTempImage(currentSection: images)
        viewModel.addNewImage { [weak self] in
            guard let self = self else { return }
            if self.viewModel.isLoadingAllImage() {
                UIApplication.shared.hideLoading()
            }
            self.images = self.viewModel.images
            self.reloadCollectionView()
        }
        
        reloadCollectionView()
    }
    
    @objc func reloadButtonTapped() {
        UIApplication.shared.showLoading()
        clearCache()
        viewModel.clearCache()
        loopGenerateImages(times: reloadValue)
    }
    
    private func clearCache() {
        images = []
        reloadCollectionView()
    }
    
    private func loopGenerateImages(times: Int) {
        for _ in 1...times {
            images = addTempImage(currentSection: images)
            viewModel.addNewImage { [weak self] in
                guard let self = self else { return }
                self.images = self.viewModel.images
                self.reloadCollectionView()
                
                if viewModel.isLoadingAllImage() {
                    UIApplication.shared.hideLoading()
                }
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionCollectionCell.cellIdentify, for: indexPath) as? SectionCollectionCell else {
            return UICollectionViewCell()
        }
        cell.bindData(images: images[indexPath.item].data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = CollectionViewHelper.getCellHeight(collectViewHeight: collectionView.bounds.height)
        let cellWidth = collectionView.bounds.width - 2
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

