//
//  swift_dataApp.swift
//  swift-data
//
//  Created by Nitesh Patil on 03/06/24.
//

import SwiftUI
import SwiftData

@main
struct swift_dataApp: App {
    var body: some Scene {
        WindowGroup {
            BookListView()
        }
        .modelContainer(for: Book.self)
    }
    
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
