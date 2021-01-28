//
//  Movies + CoreData.swift
//  MovieApp
//
//  Created by Emad Habib on 11/13/20.
//  Copyright © 2018 Emad Habib. All rights reserved.
//

import Foundation
import CoreData
import RxDataSources
import RxCoreData

struct MoviesCoredataModel {
    var id: Int64
    var imageURL: String
    var title: String
    
    init(movie: Result) {
        self.id = Int64(movie.id ?? 0)
        self.title = movie.name ?? ""
        if let image = movie.thumbnail?.path , let _extention = movie.thumbnail?._extensionX {
            if _extention.count > 0 {
                self.imageURL = image+"."+_extention
            }else {
                self.imageURL = image
            }
        }else {
            self.imageURL = ""
        }
    }
}

func == (lhs: MoviesCoredataModel, rhs: MoviesCoredataModel) -> Bool {
    return lhs.id == rhs.id
}

extension MoviesCoredataModel : Equatable { }

extension MoviesCoredataModel : IdentifiableType {
    typealias Identity = String
    
    var identity: Identity { return "\(id)" }
}

extension MoviesCoredataModel : Persistable {
    typealias T = NSManagedObject
    
    static var entityName: String {
        return "MovieList"
    }
    
    static var primaryAttributeName: String {
        return "id"
    }
    
    init(entity: T) {
        id = entity.value(forKey: "id") as! Int64
        imageURL = entity.value(forKey: "imageURL") as! String
        title = entity.value(forKey: "title") as! String
    }
    
    func update(_ entity: T) {
        entity.setValue(id, forKey: "id")
        entity.setValue(imageURL, forKey: "imageURL")
        entity.setValue(title, forKey: "title")
        do {
            try entity.managedObjectContext?.save()
        } catch let e {
            print(e)
        }
    }
    
}
