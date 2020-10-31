//
//  BenzingaData.swift
//  BenzingaRss
//
//  Created by Jacob Myers on 10/5/20.
//

import Foundation


class BenzingaNetworking: NSObject, XMLParserDelegate, ObservableObject {
    
    static var generalURL = URL(string: "https://www.benzinga.com/fintech/feed")!
    static var generalURLstring = "general"
    
    
    enum DataFetchResult{
        case success
        case failed
    }
    
    
    @Published var RssPosts = [BenzingaDataObject]()
    
    var localRssPostData = [BenzingaDataObject]()
    
    var title: String = String()
    
    var link : String = String()
    
    var itemDescription: String = String()
    
    var elementName: String = String()
    
    
    override init() {
        super.init()
        getData(completion: { DataFetchResult in
            switch DataFetchResult{
            case .failed:
                print("FAILED")
            case .success:
                print("SUCCEEDED initial")
            }
        })
        
    }
    
    
    func getData(string: String? = generalURLstring, completion: @escaping (DataFetchResult)->()) {
        print("lol did this work???")
        
        guard let searchString = string, let searchURL = urlFactory(searchString: searchString) else {return}
        let task = URLSession.shared.dataTask(with: searchURL) { [self] data, response, error in
            guard let data = data, error == nil else {
                print(error ?? "Unknown error")
                return
            }
            
//            var parseSucceeded = true

            DispatchQueue.main.async {
                localRssPostData.removeAll()
                if let parser = XMLParser(contentsOf: searchURL ){
                    parser.delegate = self
                    if parser.parse(){
                        print()
                        completion(.success)
                    }else{
                        print("parse if statement failed")
                        completion(.failed)
//                        parseSucceeded = false
                    }
                    
                }
            }
        }
        task.resume()
        
    }
    
    func urlFactory(searchString: String) -> URL?{
        let urlString = "https://www.benzinga.com/" + searchString + "/feed"
        return URL(string: urlString)
    }
    
    
    //parser delegate methods
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "item" {
            title = String()
            link = String()
            itemDescription = String()
            
        }
        self.elementName = elementName
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item"{
            let dataObj = BenzingaDataObject(title: title, link: link, description: itemDescription)
            localRssPostData.append(dataObj)
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
            case "link":
                link += data
            default:
                break
            }
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError)
        
    }
    
    func parserDidEndDocument(_ parser: XMLParser){
        //great success
        RssPosts = localRssPostData
    }

    

}
