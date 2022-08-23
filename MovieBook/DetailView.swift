//
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var detailVM = DetailViewModel()
    @ObservedObject var plot2 = Webservice()
    @EnvironmentObject var settings: Webservice
    @State private var showDetails = false
    @State private var idmb = ""
    
    var choosenMovie: MovieViewModel
    
    var body: some View {
        VStack {
            List{
                AsyncImage(url: choosenMovie.poster) { phase in
                    if let image = phase.image {
                        image.resizable()
                    } else if phase.error != nil {
                        ZStack {
                            Color.brown
                            Text("No image!")
                        }
                    } else {
                        Color.clear
                    }
                }
                .frame(width: UIScreen.main.bounds.width*0.80, height: UIScreen.main.bounds.height*0.40, alignment: .center)
                Text(choosenMovie.title)
                    .font(.system(.headline, design: .monospaced))
                    .padding()
                Text("Year: \(choosenMovie.year)")
                    .onAppear(perform: {
                        idmb = choosenMovie.imdbID
                        plot2.getMoviesDetail(idWord: idmb)
                    })
                    .font(.system(.headline, design: .monospaced))
                    .padding()
                Button {
                    showDetails.toggle()
                } label: {
                    Text (showDetails ? "Less information" : "More information")
                }.font(.system(.headline, design: .monospaced)).buttonStyle(.bordered).buttonBorderShape(.capsule)
                    .padding(10).contentShape(Rectangle()).frame(width: 240, height: 50, alignment: .center)
                
                if showDetails {
                    Text(try! AttributedString(markdown: "_Plot:_ \(plot2.detailPlot)"))
                        .font(.system(.headline, design: .serif))
                        .padding()
                }
            }
        }.background(.linearGradient(.init(colors: [.orange, .white]), startPoint: .init(x: 0.5, y: 2), endPoint: .zero)).foregroundColor(.black)
    }
}
