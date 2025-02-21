//
//  RandomImage.swift
//  RandomImage
//
//  Created by Niyati Patel.
//

import Foundation

struct RandomImage: Decodable {
    let image: Data
    let quote: Quote
}

struct Quote: Decodable {
    let quote: String
}
