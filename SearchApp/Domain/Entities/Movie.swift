//
//  Movie.swift
//  SearchApp
//
//  Created by Khanh Nguyen on 9/10/25.
//

import Foundation

struct Movie: Equatable, Identifiable, Hashable {
    typealias Identifier = String
    enum Genre: Hashable {
        case adventure
        case scienceFiction
    }
    let id: Identifier
    let title: String?
    let genre: Genre?
    let posterPath: String?
    let overview: String?
    let releaseDate: Date?
}

struct MoviesPage: Equatable {
    let page: Int
    let totalPages: Int
    let movies: [Movie]
}
