//
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var moviesVM = MoviesViewModel()
    @State private var inputLetter = ""    
    
    var body: some View {
        NavigationView {
            VStack {
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width * 1, height: UIScreen.main.bounds.height * 0, alignment: .center)
                List(moviesVM.movies, id: \.imdbID) { element in
                    NavigationLink(destination: DetailView(choosenMovie: element)) {
                        VStack {
                            HStack {
                                AsyncImage(url: element.poster) { phase in
                                    if let image = phase.image {
                                        image.resizable()
                                    } else if phase.error != nil {
                                        ZStack {
                                            Color.brown
                                            Text("No image!")
                                        }
                                    } else {
                                        ProgressView{
                                            Text("Loading...").foregroundColor(Color.orange).font(Font.title)
                                        }
                                    }
                                }.frame(width: UIScreen.main.bounds.width*0.35, height: UIScreen.main.bounds.height*0.25, alignment: .leading)
                                VStack {
                                    Text(element.title)
                                        .padding()
                                    Spacer()
                                    Text("Year: \(element.year)")
                                        .onAppear(perform: {
                                            async {
                                                moviesVM.pageNo += 1
                                                await moviesVM.searching(letter: inputLetter)
                                            }
                                        })
                                }.font(.system(.headline, design: .monospaced))
                            }.foregroundColor(.black)
                        }
                    }
                    .background(.linearGradient(.init(colors: [.orange, .white]), startPoint: .init(x: 0.5, y: -0.5), endPoint: .center))
                }
                .listSectionSeparator(.visible)
                .searchable(text: $inputLetter, prompt: "Search...")
                Text(moviesVM.placehold).frame(width: 300, height: 20, alignment: .bottom)
                    .background(.linearGradient(.init(colors: [.yellow, .orange]), startPoint: .init(x: 0.5, y: -0.5), endPoint: .center))
                    .onChange(of: inputLetter) { newValue in
                        async {
                            moviesVM.movies.removeAll()
                            moviesVM.pageNo = 0
                            await moviesVM.searching(letter: newValue)
                        }
                        if newValue.count > 2 {
                            if moviesVM.movies.isEmpty {
                                moviesVM.placehold = "Movie not found."
                            } else {moviesVM.placehold = ""}
                        } else {
                            moviesVM.movies.removeAll()
                            moviesVM.placehold = "Enter at least 3 letters."
                        }
                    }
            }.background(.linearGradient(.init(colors: [.yellow, .orange]), startPoint: .init(x: 0.5, y: -0.5), endPoint: .center))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("archivist")
                                .padding()
                                .font(.system(.largeTitle, design: .monospaced).bold())
                                .foregroundColor(Color.black)
                            Spacer()
                            Spacer()
                        }
                    }
                }
        }.preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
