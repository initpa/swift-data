//
//  PreviewContainer.swift
//  swift-data
//
//  Created by Nitesh Patil on 04/06/24.
//

import Foundation
import SwiftData

struct Preview {
    let container: ModelContainer
    
    init() {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        do {
            container = try ModelContainer(for: Book.self, configurations: config)
        } catch {
            fatalError("could not configure container in preview")
        }
    }
    
    func addExamples (_ examples: [Book]) {
        Task { @MainActor in
            examples.forEach { example in
                container.mainContext.insert(example)
            }
        }
    }
}
