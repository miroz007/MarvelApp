//
//  NotificationHelper.swift
//  ASCIOS
//
//  Created by islam on 5/17/20.
//  Copyright © 2020 islam. All rights reserved.
//

import Foundation
import CoreData
import RxSwift
import RxCocoa


//class NotificationHelper {
//
//    var managedContext: NSManagedObjectContext
//    private let disposeBag = DisposeBag()
//    var cachedData = [NotificationModel]()
//    var updateNotificationsData = PublishSubject<NotificationModel>()
//    var count : Int {
//        get{
//            return cachedData.count
//        }
//    }
//    init(managedContext: NSManagedObjectContext) {
//        self.managedContext = managedContext
//    }
//    
//    func getNotificationsFromCoreDataToFilter() {
//        managedContext.rx.entities(NotificationCoredataModel.self, sortDescriptors: [])
//            .subscribe(onNext: { [weak self] notifications in
//                guard let `self` = self else {return}
//                self.cachedData = []
//                for item in notifications {
//                    self.cachedData.append(NotificationModel(notification: item))
//                }
//                self.cachedData = self.cachedData.sorted(by: { $0.created_at?.convertToDate().compare(($1.created_at?.convertToDate())!) == .orderedDescending })
//            }).disposed(by: disposeBag)
//    }
//
//    func addToCoredata (notifications : [NotificationModel] ,completion: @escaping (Any?) -> ()){
//        completion(notifications.map { [weak self] (notification)   in
//            guard let `self` = self else {return}
//            let containCheck = self.cachedData.contains { (item) -> Bool in item.id == notification.id}
//            if !containCheck {
//                let backgroundQueue = DispatchQueue(label: "backgroundQueue", qos: .background)
//                let defaultQueue = DispatchQueue(label: "backgroundQueue", qos: .default)
//
//                backgroundQueue.sync { [weak self]  in
//                    guard let `self` = self else {return}
//                    _ = try? self.managedContext.rx.update(NotificationCoredataModel.init(notification: notification))
//                    defaultQueue.sync { [weak self]  in
//                        guard let `self` = self else {return}
//                        if Application.isLoggedIn() {
//                            if self.cachedData.count > 50 {
//                                _ = try? self.managedContext.rx.delete(NotificationCoredataModel.init(notification: self.cachedData[self.cachedData.count - 1]))
//                            }
//                        }
//                        else {
//                            if self.cachedData.count > 10 {
//                                _ = try? self.managedContext.rx.delete(NotificationCoredataModel.init(notification: self.cachedData[self.cachedData.count - 1]))
//                            }
//                        }
//                    }
//                }
//            }
//        })
//    }
//    func clear (){
//        for notification in cachedData {
//          _ = try? self.managedContext.rx.delete(NotificationCoredataModel.init(notification: notification))
//        }
//        cachedData.removeAll()
//      }
//    func updateOpenedNotification(index : Int){
//         self.cachedData[index].opened = true
//          _ = try? self.managedContext.rx.update(NotificationCoredataModel.init(notification: self.cachedData[index]))
//    }
//    
//    func updateAllAsRead(completion: @escaping (_ cachedData : [NotificationModel] ) -> ())  {
//        let backgroundQueue = DispatchQueue(label: "backgroundQueue", qos: .background)
//        backgroundQueue.sync { [weak self]  in
//            guard let `self` = self else {return}
//            for index in 0..<self.cachedData.count {
//                self.cachedData[index].opened = true
//                _ = try? self.managedContext.rx.update(NotificationCoredataModel.init(notification:self.cachedData[index]))
//            }
//            completion(self.cachedData)
//        }
//    }
//}
