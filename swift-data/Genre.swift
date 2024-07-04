//
//  Genre.swift
//  swift-data
//
//  Created by Nitesh Patil on 04/07/24.
//

import Foundation
import SwiftData


@Model
class Genre {
    var name: String
    var color: String
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
}
