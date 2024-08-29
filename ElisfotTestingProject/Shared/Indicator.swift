import UIKit

extension UIApplication {
    
    static let loadingTag = 9998
    
    func showLoading() {
        guard let window = self.windows.first else { return }
        
        guard window.viewWithTag(UIApplication.loadingTag) == nil else {
            return
        }
        
        let activityIndicator = getIndicatorView(window: window)
        
        window.isUserInteractionEnabled = false
        
        DispatchQueue.main.async {
            if window.viewWithTag(UIApplication.loadingTag) == nil {
                window.addSubview(activityIndicator)
                UIView.animate(withDuration: 0.3) {
                    activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.2)
                }
            }
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            guard let window = self.windows.first else { return }
            window.isUserInteractionEnabled = true
            
            if let containerView = window.viewWithTag(UIApplication.loadingTag) {
                UIView.animate(withDuration: 0.3, animations: {
                    containerView.alpha = 0.0
                }) { _ in
                    containerView.removeFromSuperview()
                }
            }
        }
    }
}


extension UIApplication {
    
    func getIndicatorView(window: UIWindow) -> UIView {
        
        
        let containerView = UIView(frame: window.frame)
        containerView.backgroundColor = UIColor(white: 0, alpha: 0.0)
        containerView.tag = UIApplication.loadingTag
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = containerView.center
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        containerView.addSubview(activityIndicator)
        
        return containerView
    }
}
