//
//  HomeModel.swift
//  MarvelApp
//
//  Created by Amir Samir on 9/9/20.
//  Copyright © 2020 Amir Samir. All rights reserved.
//
//MoviesCharsResponse

import Foundation

struct MoviesCharsResponse : Codable {

    var attributionHTML : String?
    var attributionText : String?
    var code : Int?
    var copyright : String?
    var data : DataModel?
    var etag : String?
    var status : String?
    
    
    enum CodingKeys: String, CodingKey {
        case attributionHTML = "attributionHTML"
        case attributionText = "attributionText"
        case code = "code"
        case copyright = "copyright"
        case data = "data"
        case etag = "etag"
        case status = "status"
    }
    
    init(response: [String: Any]?) {
        guard let response = response else {
            return
        }
        if let data = try? JSONSerialization.data(withJSONObject: response, options: []) {
            let dataResponse = try? JSONDecoder().decode(MoviesCharsResponse.self, from: data)
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



struct DataModel : Codable {
    
    let count : Int?
    let limit : Int?
    let offset : Int?
    let results : [Result]?
    let total : Int?


    enum CodingKeys: String, CodingKey {
        case count = "count"
        case limit = "limit"
        case offset = "offset"
        case results = "results"
        case total = "total"
    }
}


struct Result : Codable {
    let id : Int?
    let name : String?
    let thumbnail : Thumbnail?
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case thumbnail
    }
    
    init(model: MoviesCoredataModel){
        self.id = Int(model.id)
        self.name = model.title
        self.thumbnail = Thumbnail(_extensionX: "", path: model.imageURL)
    }
}



struct Thumbnail : Codable {

    let _extensionX : String?
    let path : String?

    
    enum CodingKeys: String, CodingKey {
        case _extensionX = "extension"
        case path = "path"
    }
}
