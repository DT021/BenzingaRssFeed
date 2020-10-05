//
//  testUserPostData.swift
//  BenzingaRss
//
//  Created by Jacob Myers on 10/5/20.
//

import Foundation
/// Test Data
struct TestData {
    
    /// users
    static let userTimCook     =   testUser(name: "Tim Cook", avatar: "tim")
    static let userSteveJobs   =   testUser(name: "Steve Jobs", avatar: "steve")
    static let userCraig       =   testUser(name: "Craig Federighi", avatar: "craig")
    static let userElonMusk    =   testUser(name: "Elon Musk", avatar: "elon")
    
    
    /// posts
    static func posts() -> [Post] {
        let post1 = Post(user: userTimCook, image: "mojave",
                         content: "Cook is the chief executive officer of Apple Inc., and previously served as the company's chief operating officer under its cofounder Steve Jobs.",
                         time: "Just now")
        
        let post2 = Post(user: userSteveJobs, image: "iphone",
                         content: "Steven Jobs was an American business magnate and investor. He was the chairman, chief executive officer (CEO), and co-founder of Apple Inc.",
                         time: "2 mins ago")
        
        let post3 = Post(user: userCraig, image: "catalina",
                         content: "Craig Federighi is Apple's senior vice president of Software Engineering.",
                         time: "an hour ago")
        
        let post4 = Post(user: userElonMusk, image: "tesla",
                         content: "Elon Musk FRS is a technology entrepreneur, investor, and engineer.",
                         time: "yesterday")
        
        return [post1, post2, post3, post4]
    }
}
