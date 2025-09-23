//
//  MementoWrapper.swift
//  Memento
//
//  Created by Alexander Zyryanov on 23.09.2025.
//

import UIKit
import ObjectiveC

public struct MementoWrapper<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

@MainActor var taskIdentifierKey: Void?

extension MementoWrapper where Base: UIImageView {
    @MainActor var taskIdentifier: Int {
        get {
            objc_getAssociatedObject(base, &taskIdentifierKey) as? Int ?? .zero
        }
        set {
            objc_setAssociatedObject(base, &taskIdentifierKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

public protocol MementoCompatibleValue {}

extension MementoCompatibleValue {
    public var memento: MementoWrapper<Self> {
        get { return MementoWrapper(self) }
        set { }
    }
}

extension UIImageView: MementoCompatibleValue {}
