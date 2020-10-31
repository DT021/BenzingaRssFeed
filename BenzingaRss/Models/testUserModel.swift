//
//  testUserModel.swift
//  BenzingaRss
//
//  Created by Jacob Myers on 10/5/20.
//

import Foundation

struct testUser: Identifiable {
    var id: String = UUID().uuidString
    
    let name: String
    
    let avatar: String
    
    init(name: String, avatar: String) {
        self.name = name
        self.avatar = avatar
    }
}
