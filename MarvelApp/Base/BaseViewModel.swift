//
//  BaseViewModel.swift
//  ASCIOS
//
//  Created by islam on 2/19/20.
//  Copyright © 2020 islam. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxCoreData
import CoreData

class BaseViewModel {
    
    let disposeBag = DisposeBag()
    let alertDialog = PublishSubject<(String,String)>()
    let dependency:AppDependency
    var managedObjectContext: NSManagedObjectContext!

    init() {
        dependency = AppDependency(window: Application.window!,managedContext: Application.managedObjectContext)
        self.managedObjectContext = dependency.managedObjectContext

    }
}
