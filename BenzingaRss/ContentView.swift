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
    
    @ObservedObject var rssPostData : BenzingaData
    
    var body: some View{
        NavigationView{
            List{
                ForEach(rssPostData.RssPosts){ post in
                    NavigationLink(
                        destination: WebView(text: post.description).navigationBarTitle(Text("\(post.title)"), displayMode: .inline),
                        label: {
                                postView(post: post)
                        })
                    
                }
                
            }
            
            .navigationBarTitle(Text("BZ General RSS feed"), displayMode: .automatic)
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
            .foregroundColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
            

        }
        
    }
    
    init(rssPostData: BenzingaData) {
        postData = []
        self.rssPostData = BenzingaData()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rssPostData: BenzingaData())
        
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
