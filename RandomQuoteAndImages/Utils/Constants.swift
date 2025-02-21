//
//  Constants.swift
//  Constants
//
//  Created by Niyati Patel.
//

import Foundation

struct Constants {
    
    struct Urls {
        
        static func getRandomImageUrl() -> URL? {
            return URL(string: "https://picsum.photos/200/300?uuid=\(UUID().uuidString)")
        }
        
        static let randomQuoteUrl: URL? = URL(string: "https://dummyjson.com/quotes/random")
        
    }
    
}
