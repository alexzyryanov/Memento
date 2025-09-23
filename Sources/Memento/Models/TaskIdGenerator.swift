//
//  TaskIdGenerator.swift
//  Memento
//
//  Created by Alexander Zyryanov on 23.09.2025.
//

@MainActor
struct TaskIdGenerator {
    private static var identifier: Int = .zero
    
    static func next() -> Int {
        identifier += 1
        return identifier
    }
}
