//
//  ContentView.swift
//  BenzingaRss
//
//  Created by Jacob Myers on 10/5/20.
//

import SwiftUI

struct ContentView: View {
    
//    let posts = BenzingaData()
    
    var postData: [BenzingaDataObject] = []
    
    @ObservedObject var rssPostData : BenzingaData
    
    var body: some View{
        
    NavigationView{
            //            Text("hello FAM!")
            List{
                ForEach(rssPostData.RssPosts){ post in
                    HStack{
                       postView(post: post)
                    }
                }}
        }
        
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rssPostData: BenzingaData())
        
    }
}
