//
//  Quote.swift
//  swift-data
//
//  Created by Nitesh Patil on 02/07/24.
//

import Foundation
import SwiftData

@Model
class Quote {
    var creationData: Date = Date.now
    var text: String
    var page: String?
    
    init(text: String, page: String? = nil) {
        self.text = text
        self.page = page
    }
    
    var book: Book?
}
