import UIKit

extension MementoWrapper where Base: UIImageView {
    @MainActor public func setImage(with url: String) {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        base.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: base.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: base.centerYAnchor)
        ])
        
        var mutableSelf = self
        
        let issuedIdentifier = TaskIdGenerator.next()
        mutableSelf.taskIdentifier = issuedIdentifier
        
        Task(priority: .high) {
            guard issuedIdentifier == mutableSelf.taskIdentifier else {
                return
            }
            
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            
            base.alpha = 0.0
            base.image = await MementoManager().getImage(from: url)
            UIView.animate(withDuration: 0.3) {
                base.alpha = 1.0
            }
        }
    }
}
