//
//

import Foundation
import Alamofire
import SwiftUI

@MainActor
class MoviesViewModel: ObservableObject {
    
    @Published var movies: [MovieViewModel] = []
    
    var pageNo = 0
    var pageCount = 0
    var movieCount = 0
    var placehold = "Enter at least 3 letters."
    
    func paceCountCal() {
        let remaining = movieCount % 10
        let fullPage = movieCount / 10
        if remaining == 0 {
            pageCount = fullPage
        }
        else {
            pageCount = (fullPage + 1)
        }
    }
    
    func searching(letter: String) async {
        paceCountCal()
        if pageNo <= pageCount {
            pageNo += 1
        } else {}
        Webservice().getMovies(searchWord: letter, pageNum: pageNo) { response in
            if (response.isEmpty) {
                self.movies.removeAll()
            } else {
                if self.pageNo == 1 {
                    self.movies = response.map(MovieViewModel.init)
                } else {
                    self.movies += response.map(MovieViewModel.init)
                }
            }
        }
    }
}

struct MovieViewModel {
    
    let search: Search
    
    var imdbID: String {
        search.imdbID
    }
    var title: String {
        search.title
    }
    var year: String {
        search.year
    }
    var poster: URL? {
        URL(string: search.poster)
    }
}

struct PageViewModel {
    let movieInfo: MovieInfo
    
    var totalResults: Int {
        Int(movieInfo.totalResults)!
    }
}
