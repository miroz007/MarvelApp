//
//  APICallError.swift
//  MovieApp
//
//  Created by Amir Samir on 12/11/18.
//  Copyright © 2018 Amir Samir. All rights reserved.
//

import Foundation

enum InternetConnectionErrorCode: Int {
    case offline = 10101
    case unAuth = 1111
}

enum APICallStatus: Error {
    case success
    case failed
    case forbidden
    case serializationFailed
    case offline
    case timeout
    case unknown
}

class APICallError {
    
    var critical: Bool = false
    var code: Int = -1
    var reason:String = String()
    var message: String = String()
    var callStatus: APICallStatus = .unknown
    
    init() {}
    
    init(error : Error) {
        self.code =  (error as NSError).code
        self.reason = error.localizedDescription
        self.message = error.localizedDescription
        switch self.code {
        case 1111:
            self.callStatus = .failed
        case 2222:
            self.callStatus = .forbidden
        case 3333:
            self.callStatus = .offline
        case 404:
            self.callStatus = .timeout
        case 403:
            self.callStatus = .timeout
        case 200:
            self.callStatus = .success
        case 5000:
            self.callStatus = .failed
        default:
            self.callStatus = .unknown
        }
    }
    
    init(critical:Bool, code:Int, reason:String, message:String, callStatus: APICallStatus = .unknown) {
        self.critical = critical
        self.code = code
        self.reason = reason
        self.message = message
        self.callStatus = callStatus
    }
    
    convenience init(status:APICallStatus) {
        switch status {
        case .success:
            self.init()
        case .failed:
            self.init(critical: false, code: 1111, reason: "Generic Error, status code isn't 200.", message: NSLocalizedString("Generic Error", comment: ""))
        case .forbidden:
            self.init(critical: false, code: 2222, reason: "HTTP status code 403", message: NSLocalizedString("HTTP status code 403", comment: ""))
        case .serializationFailed:
            self.init(critical: false, code: 3333, reason: "Could not parse the json", message: NSLocalizedString("Could not parse the json", comment: ""))
        case .offline:
            self.init(critical: false, code: InternetConnectionErrorCode.offline.rawValue, reason: "User offline", message: NSLocalizedString("Unable to contact the server", comment: ""), callStatus: .offline)
        case .timeout:
            self.init(critical: false, code: 5555, reason: "Slow internet connection", message: NSLocalizedString("Slow internet connection", comment: ""))
        case .unknown:
            self.init(critical: false, code: 1000, reason: "Unknown error", message: NSLocalizedString("Unknown error", comment: ""))
        }
    }
    
}
