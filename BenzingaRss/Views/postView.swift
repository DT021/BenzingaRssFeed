//
//  postView.swift
//  BenzingaRss
//
//  Created by Jacob Myers on 10/5/20.
//
import SwiftUI
import Foundation

struct postView: View {
    let post: BenzingaDataObject
    
    
    let benzingaPs = UIImage(named: "benzingaPs")
    
    var body: some View {
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 3){ 
                        Text(post.title).font(.headline)
                        Text(post.link).font(.footnote)
                    }
                    
                }
        
        
    }
    
}

struct basicView: View{
    var body: some View {
        Text("ayy lmao")
    }
}





struct postView_Previews: PreviewProvider {
    static var previews: some View {
        postView(post: BenzingaDataObject(title: "test title here", link: "www.heresalink.com", description: "yo check this out"))
    }
}
