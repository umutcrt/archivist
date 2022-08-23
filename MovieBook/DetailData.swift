//
//

import Foundation
import SwiftUI

struct DetailInfo: Codable {
    let title, year, released: String
    let genre, director: String
    let actors, plot: String
    let poster: String
    let imdbRating, imdbVotes, imdbID: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case released = "Released"
        case genre = "Genre"
        case director = "Director"
        case actors = "Actors"
        case plot = "Plot"
        case poster = "Poster"
        case imdbRating, imdbVotes, imdbID
        case type = "Type"
    }
}

struct Rating: Codable {
    let source, value: String
    
    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}

