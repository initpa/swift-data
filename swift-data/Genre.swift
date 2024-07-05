//
//  Genre.swift
//  swift-data
//
//  Created by Nitesh Patil on 04/07/24.
//

import SwiftUI
import SwiftData

@Model
class Genre {
    var name: String
    var color: String
    var books: [Book]?
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    
    var hexColor: Color {
        Color(hex: self.color) ?? .red
    }
}
