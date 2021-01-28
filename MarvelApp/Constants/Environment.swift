//
//  Environment.swift
//  MovieApp
//
//  Created by Amir Samir on 12/11/18.


import Foundation

enum Server {
    case developement
    case testing
    case production
}

class Environment {
        
    static let server:Server =  .production
    
    // To print the log set true.
    static let imageBaseUrl = ""
    static let debug:Bool  =  true
    
    class func APIBasePath() -> String {
        switch self.server {
            case .production:
               return "https://gateway.marvel.com/"
            
            case .testing:
               return "https://gateway.marvel.com/"
            
            case .developement:
                return "https://gateway.marvel.com/"
        }
    }
    
    /// API ~ TOKEN
    class func MOVIEDB_APIKEY() -> String {
        switch self.server {
        case .developement:
            return "02c3618f1930f437334368f95ac4fedb"
        case .testing:
            return "02c3618f1930f437334368f95ac4fedb"
        case .production:
            return "02c3618f1930f437334368f95ac4fedb"
        }
    }
    
    //02c3618f1930f437334368f95ac4fedb
    //8e1e032b76d5555f4ae387eb60d1b2731b7cb81f
    //hash 91c83789a81dcb24cae4fbaa132e9c54
    class func MovieHashURL() ->String {
        return "?apikey=02c3618f1930f437334368f95ac4fedb&hash=91c83789a81dcb24cae4fbaa132e9c54&ts=1"
    }
    class func MovieSearchHashURL() ->String {
        return "&apikey=02c3618f1930f437334368f95ac4fedb&hash=91c83789a81dcb24cae4fbaa132e9c54&ts=1"
    }
    
}


