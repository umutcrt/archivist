//
//

import Foundation
import SwiftUI
import Alamofire

class Webservice: ObservableObject {
    
    @Published var totresult = "0"
    @Published var detailPlot = ""
    
    func getMovies(searchWord: String, pageNum: Int, completion: @escaping([Search]) -> Void) {
        let url = "https://www.omdbapi.com/?s=" + searchWord.trimmed() + "&apikey=1b024a23&page=\(pageNum)"
        AF.request(url, method: .get).responseDecodable(of: MovieInfo.self) { response in
            switch response.result {
            case .success(let data):
                let value = data.search
                self.totresult = data.totalResults
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    func getMoviesDetail(idWord: String) {
        let url = "https://www.omdbapi.com/?i=" + idWord + "&apikey=1b024a23"
        AF.request(url, method: .get).responseDecodable(of: DetailInfo.self) { response in
            switch response.result {
            case .success(let data):
                let value = data.plot
                self.detailPlot = value
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

