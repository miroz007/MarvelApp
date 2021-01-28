//
//  MovieDetailsModel.swift
//  MarvelApp
//
//  Created by Amir on 1/28/21.
//  Copyright © 2021 Amir. All rights reserved.
//

import Foundation



struct MoviesCharsDetailsResponse : Codable {
    var attributionHTML : String?
    var attributionText : String?
    var code : Int?
    var copyright : String?
    var data : Data?
    var etag : String?
    var status : String?
    
    
    enum CodingKeys: String, CodingKey {
        case attributionHTML = "attributionHTML"
        case attributionText = "attributionText"
        case code = "code"
        case copyright = "copyright"
        case data
        case etag = "etag"
        case status = "status"
    }
  
    init(response: [String: Any]?) {
           guard let response = response else {
               return
           }
           if let data = try? JSONSerialization.data(withJSONObject: response, options: []) {
               let dataResponse = try? JSONDecoder().decode(MoviesCharsDetailsResponse.self, from: data)
               self.status = dataResponse?.status
               self.code = dataResponse?.code
               self.copyright = dataResponse?.copyright
               self.etag  = dataResponse?.etag
               self.data = dataResponse?.data
               self.attributionHTML  = dataResponse?.attributionHTML
               self.attributionText = dataResponse?.attributionText
           }
           
       }
    
}

struct Data : Codable {

    let count : Int?
    let limit : Int?
    let offset : Int?
    let results : [Results]?
    let total : Int?


    enum CodingKeys: String, CodingKey {
        case count = "count"
        case limit = "limit"
        case offset = "offset"
        case results = "results"
        case total = "total"
    }

}

struct Results : Codable {

    let comics : Comic?
    let descriptionField : String?
    let events : Comic?
    let id : Int?
    let modified : String?
    let name : String?
    let resourceURI : String?
    let series : Comic?
    let stories : Comic?
    let thumbnail : Thumbnails?
    let urls : [Url]?


    enum CodingKeys: String, CodingKey {
        case comics
        case descriptionField = "description"
        case events
        case id = "id"
        case modified = "modified"
        case name = "name"
        case resourceURI = "resourceURI"
        case series
        case stories
        case thumbnail
        case urls = "urls"
    }

}

struct Url : Codable {

    let type : String?
    let url : String?


    enum CodingKeys: String, CodingKey {
        case type = "type"
        case url = "url"
    }


}

struct Thumbnails : Codable {

    let _extension : String?
    let path : String?


    enum CodingKeys: String, CodingKey {
        case _extension = "extension"
        case path = "path"
    }

}

struct Comic : Codable {

    let available : Int?
    let collectionURI : String?
    let items : [Item]?
    let returned : Int?

    
    enum CodingKeys: String, CodingKey {
        case available = "available"
        case collectionURI = "collectionURI"
        case items = "items"
        case returned = "returned"
    }

}

struct Item : Codable {

    let name : String?
    let resourceURI : String?
    let type : String?
    

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case resourceURI = "resourceURI"
        case type = "type"
    }

}
