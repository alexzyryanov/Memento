import UIKit

extension MementoWrapper where Base: UIImageView {
    @MainActor public func setImage(with url: String) {
        var mutableSelf = self
        
        let issuedIdentifier = TaskIdGenerator.next()
        mutableSelf.taskIdentifier = issuedIdentifier
        
        Task(priority: .high) {
            guard issuedIdentifier == mutableSelf.taskIdentifier else {
                return
            }
            base.image = await MementoManager.shared.getImage(from: url)
        }
    }
}
