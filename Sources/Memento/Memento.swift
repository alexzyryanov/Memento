#if canImport(UIKit)
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
        
        Task {
            guard issuedIdentifier == mutableSelf.taskIdentifier else {
                return
            }
            
            guard let image = await MementoManager().getImageData(from: url) else {
                return
            }
            
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            base.image = UIImage(data: image)
        }
    }
}

#endif

import SwiftUI

public struct MementoImage: View {
    @State private var image: Image?
    private let url: URL?
    
    public init(url: URL?) {
        self.url = url
    }
    
    public var body: some View {
        Group {
            if let image {
                image
                    .resizable()
                    .scaledToFill()
            }
            else {
                ProgressView()
            }
        }
        .frame(maxWidth: .infinity)
        .task(id: self.url) {
            guard let url else { return }
            do {
                guard let data = try await MementoManager().getImageData(from: url.absoluteString),
                      let nsImage = NSImage(data: data) else { return }
                self.image = Image(nsImage: nsImage)
            }
            catch {}
        }
    }
}
