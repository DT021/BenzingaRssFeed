//
//  BenzingaDataModel.swift
//  BenzingaRss
//
//  Created by Jacob Myers on 10/5/20.
//

import Foundation

class BenzingaDataObject: Identifiable, ObservableObject {
    var id = UUID().uuidString
    var title: String
    var link: String
    var description: String
    
    init(title: String, link: String, description: String) {
        self.title = title
        self.link = link
        self.description = description
    }
}
