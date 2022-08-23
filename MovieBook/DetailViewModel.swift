//
//

import Foundation
import Alamofire
import SwiftUI

class DetailViewModel: ObservableObject {
    
    @Published var details: [DetailViewModel] = []
    @ObservedObject var webservice = Webservice()
}

