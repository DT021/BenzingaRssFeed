//
//  postModel.swift
//  BenzingaRss
//
//  Created by Jacob Myers on 10/5/20.
//

import Foundation

struct Post: Identifiable {
    
    var id = UUID().uuidString
    
    let user: testUser!
    
    let image: String?
    
    let content: String?
    
    let time: String!
    
    init(user: testUser, image: String?, content: String?, time: String) {
        self.user = user
        self.image = image
        self.content = content
        self.time = time
        
    }
}
