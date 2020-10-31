//
//  ContentView.swift
//  BenzingaRss
//
//  Created by Jacob Myers on 10/5/20.
//

import SwiftUI
import WebKit

struct ContentView: View {
    
    var postData: [BenzingaDataObject] = []
    @State var searchString = ""
    @State var showAlert = false
    @State var feedTitle = "General"
    
    var printButton = Button("Print") {
        print("hello")
    }
    
    @ObservedObject var rssPostData : BenzingaNetworking
    
    var body: some View{
        NavigationView{
            VStack {
                HStack{
                    Spacer()
                    TextField("type here", text: $searchString)

                    Button("Search"){
                        print($searchString)
                        
                        self.rssPostData.getData(string: searchString, completion: { DataFetchResult in
                            switch DataFetchResult{
                            case .failed:
                                print("FAILED query")
                                showAlert = true
                                feedTitle = ""
                            case .success:
                                print("SUCCEEDED query")
                                showAlert = false
                                feedTitle = searchString.capitalized
                            }
                        })
                        
                    }.padding(8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .fixedSize()
                    Spacer()
                    
                }
                
                List{
                    
                    Section(header: Text("\(feedTitle) Feed")) {
                        ForEach(rssPostData.RssPosts){ post in
                            NavigationLink(
                                destination: WebView(text: post.description).navigationBarTitle(Text("\(post.title)"), displayMode: .inline),
                                label: {
                                    postView(post: post)
                                })
                            
                        }
                    }
                    
                    
                }.alert(isPresented: $showAlert){
                     return Alert(title: Text("Invalid Feed"), message: Text("Try searching for a valid BZ RSS feed"), dismissButton: .default(Text("Got it!")))
                                    
                }
                .padding(.horizontal, -20)
            
                
            }
            .navigationBarTitle(Text("Benzinga RSS feed"), displayMode: .automatic)
            .preferredColorScheme(.dark)
            .foregroundColor(.gray)
            
            
        }
        
    }
    
    
    init(rssPostData: BenzingaNetworking) {
        postData = []
        self.rssPostData = BenzingaNetworking()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(rssPostData: BenzingaNetworking())
        }
        
    }
}

struct WebView: UIViewRepresentable {
    
    var text: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(text, baseURL: nil)
    }
}

