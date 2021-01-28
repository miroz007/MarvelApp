//
//  APIRouter.swift
//  MovieApp
//
//  Created by Amir Samir on 12/11/18.
//  Copyright © 2018 Amir Samir. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter:URLRequestConvertible {
    
    case home
    case charDetails(id:Int)
    
    case comics(id:Int)
    case events(id:Int)
    case series(id:Int)
    case stories(id:Int)
    case search(name:String)

    func asURLRequest() throws -> URLRequest {
        
        var method: HTTPMethod {
            switch self {
            case .home , .charDetails ,.comics,.events,.series,.stories ,.search:
                return .get
            }
        }
        
        let params: ([String: Any]?) = {
            switch self {
            case .home ,.charDetails,.comics,.events,.series,.stories,.search:
                return nil
            }
        }()
        
        let url: URL = {
            // Add base url for the request
            let baseURL:String = {
                return Environment.APIBasePath()
            }()
            // build up and return the URL for each endpoint
            let relativePath: String? = {
                switch self {
                case.home:return "v1/public/characters"
                case.charDetails(let id):return "v1/public/characters/\(id)"
                case.comics(let id):return "v1/public/characters/\(id)/comics"
                case.events(let id):return "v1/public/characters/\(id)/events"
                case.series(let id):return "v1/public/characters/\(id)/series"
                case.stories(let id):return "v1/public/characters/\(id)/stories"
                case.search(let name):return "v1/public/characters?name=\(name)"
                }
            }()
            
            var str = ""
            var url : URL!
            if let relativePath = relativePath {
                str = baseURL + relativePath 
                if relativePath.contains("name=") {
                    str += Environment.MovieSearchHashURL()
                    url = URL(string: str)
                }else {
                    str += Environment.MovieHashURL()
                    url = URL(string: str)
                }
            }
            plog("\(url.absoluteString)")
            
            return url
        }()
        
        let encoding:ParameterEncoding = {
            return JSONEncoding.default
        }()
        let headers:[String:String]? = {
            // AUTH Header
            let header =   ["Content-Type" : "application/json"  , "Accept" : "application/json" ]
            
            return header
        }()
        print("headers: \(String(describing: headers))")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        return try encoding.encode(urlRequest, with: params)
    }
}
