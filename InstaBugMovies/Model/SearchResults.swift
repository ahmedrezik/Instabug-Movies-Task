//
//  SearchResults.swift
//  InstaBugMovies
//
//  Created by Ahmed Rezik on 5/19/20.
//  Copyright © 2020 Ahmed Rezik. All rights reserved.
//

import Foundation

struct MovieResults: Codable {
    
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]
    
    
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
        
            }
    
}
