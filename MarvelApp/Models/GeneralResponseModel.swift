//
//  GeneralResponseModel.swift
//  ASCIOS
//
//  Created by islam on 3/4/20.
//  Copyright © 2020 islam. All rights reserved.
//

import Foundation

struct GeneralResponse : Codable {
    
    var status : Bool?
    var message : String?
    
    init(response: [String: Any]?) {
        guard let response = response else {
            return
        }
        if let data = try? JSONSerialization.data(withJSONObject: response, options: []) {
            let dataResponse = try? JSONDecoder().decode(GeneralResponse.self, from: data)
            self.status = dataResponse?.status
            self.message = dataResponse?.message

        }
        
    }
}

struct FavResponse : Codable {
    
    var status : Bool?
    var message : String?
    var data : FavModel?
    
    init(response: [String: Any]?) {
        guard let response = response else {
            return
        }
        if let data = try? JSONSerialization.data(withJSONObject: response, options: []) {
            let dataResponse = try? JSONDecoder().decode(FavResponse.self, from: data)
            self.status = dataResponse?.status
            self.message = dataResponse?.message
            self.data = dataResponse?.data

        }
        
    }
}


struct PickerModelRespoonse : Codable {

    var data : [PickerModel]?
    var message : String?
    var status : Bool?


    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
    }
    init(response: [String: Any]?) {
        guard let response = response else {
            return
        }
        if let data = try? JSONSerialization.data(withJSONObject: response, options: []) {
            let dataResponse = try? JSONDecoder().decode(PickerModelRespoonse.self, from: data)
            self.status = dataResponse?.status
            self.message = dataResponse?.message
            self.data = dataResponse?.data
        }
        
    }
}


struct PickerModel : Codable {

    let id : Int?
    let image : String?
    let name : String?


    enum CodingKeys: String, CodingKey {
        case id = "id"
        case image = "image"
        case name = "name"
    }

}

struct FavModel : Codable {


    let liked:Bool?

    enum CodingKeys: String, CodingKey {
        case liked = "liked"
    }

}
