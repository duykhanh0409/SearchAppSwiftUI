//
//  DataMapping.swift
//  SearchApp
//
//  Created by Khanh Nguyen on 9/10/25.
//

import Foundation

struct MoviesRequestDTO: Encodable {
    let query: String
    let page: Int
}
