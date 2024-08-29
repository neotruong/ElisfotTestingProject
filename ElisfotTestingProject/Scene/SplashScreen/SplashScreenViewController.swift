//
//  SplashScreenViewController.swift
//  ElisfotTestingProject
//
//  Created by Neo Truong on 8/29/24.
//

import Foundation
import UIKit

final class SplashScreenViewController: UIViewController {
    
    @IBOutlet weak var appTitleLabel: UILabel!
    
    override func viewDidLoad() {
        appTitleLabel.alpha = 0.0
        appTitleLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        UIView.animate(withDuration: 1.5, 
                       delay: 0.5,
                       options: [.curveEaseInOut],
                       animations: {
            self.appTitleLabel.alpha = 1.0
            self.appTitleLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { _ in
            self.navigationController?.pushViewController(HomeViewController(viewModel: self.initViewModel()), animated: false)
        }
    }
    
    func initViewModel() -> HomeViewModel {
        let networkManger = NetworkManager()
        return HomeViewModel(networkManager: networkManger)
    }
    
}
