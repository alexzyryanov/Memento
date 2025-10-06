import UIKit

extension MementoWrapper where Base: UIImageView {
    @MainActor public func setImage(with url: String) {
        base.subviews.forEach { subview in
            if subview is UIActivityIndicatorView {
                subview.removeFromSuperview()
            }
        }
        
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
            
            let image = await MementoManager.shared.getImage(from: url)
            await MainActor.run {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
                base.image = image
            }
        }
    }
}
