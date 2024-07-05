//
//  GenereSamples.swift
//  swift-data
//
//  Created by Nitesh Patil on 05/07/24.
//

import Foundation

extension Genre {
    static var samplesGenres: [Genre] {
        [
            Genre(name: "Fiction", color: "00FF00"),
            Genre(name: "Non Fiction", color: "0000FF"),
            Genre(name: "Romance", color: "FF0000"),
            Genre(name: "Thriller", color: "000000")
            
        ]
    }
}
