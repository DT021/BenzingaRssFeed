//
//  BenzingaData.swift
//  BenzingaRss
//
//  Created by Jacob Myers on 10/5/20.
//

import Foundation

class BenzingaData: NSObject, XMLParserDelegate, ObservableObject {
    
    var generalURL = URL(string: "https://www.benzinga.com/general/feed")!
    
    
    
//    class rssPostClass: ObservableObject {
    @Published var RssPosts = [BenzingaDataObject]()
//    }
    
    var title: String = String()
    
    var link : String = String()
    
    var itemDescription: String = String()
    
    var elementName: String = String()
    
    
    func getData(){
        print("lol did this work???")
        
        let task = URLSession.shared.dataTask(with: generalURL) { [self] data, response, error in
            guard let data = data, error == nil else {
                print(error ?? "Unknown error")
                return
            }

            DispatchQueue.main.async {
                if let parser = XMLParser(contentsOf: self.generalURL ){
                    parser.delegate = self
                    if parser.parse(){
                        print()
                    }
                    print("oh hello!")
                }
            }
        }
        task.resume()
        
//        if let path = Bundle.main.url(forResource: "BenzingaGeneral", withExtension: "xml") {
//            if let parser = XMLParser(contentsOf: generalURL ){
//                parser.delegate = self
//                parser.parse()
//                print("oh hello!")
//            }
//        }
        
    }
    
    func debugFxn(){
        print("lol we in dis!")
    }
    
    override init() {
        super.init()
        getData()
        debugFxn()
        
    }
    
    
//    func getPosts() -> [BenzingaDataObject]{
//        return self.RssPosts
//    }
    
    //parser delegate methods
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "item" {
//            bookTitle = String()
            title = String()
            link = String()
            itemDescription = String()
            
        }
        self.elementName = elementName
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item"{
            let dataObj = BenzingaDataObject(title: title, link: link, description: itemDescription)
            RssPosts.append(dataObj)
//            rssPostStruct
            print(dataObj)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if(!data.isEmpty){
            switch self.elementName {
            case "title":
                title += data
            case "description":
                itemDescription += data
            default:
                break
            }
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError)
        
    }
    

}
