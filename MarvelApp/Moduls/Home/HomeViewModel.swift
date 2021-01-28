//
//  HomeViewModel.swift
//  MarvelApp
//
//  Created by Amir Samir on 28/01/2021.
//  Copyright © 2021 Amir Samir. All rights reserved.
//

import Foundation
import RxSwift

class HomeViewModel : BaseViewModel {
    
    let isLoading: ActivityIndicator =  ActivityIndicator()
    lazy var msg = Variable<String>("")
    var data = Variable<[Result]>([])
    
    var isFromCoredata: Bool = false

    
    override init() {
        super.init()
        
        data.asObservable()
            .subscribe(onNext: { [weak self] result in
                guard let `self` = self else { return }
                if result.count > 0{
                    for movie in result {
                        _ = try? self.managedObjectContext.rx.update(MoviesCoredataModel.init(movie: movie))
                    }
                }
            })
            .disposed(by: disposeBag)

    }
    
    
    func getMoviesDataAPI() {
        self.dependency.api.regularRequest(apiRouter: .home)
            .trackActivity(isLoading)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe {[weak self] (event) in
                guard let `self` = self else { return }
                switch event {
                case .next(let result):
                    switch result {
                    case .success(value: let response):
                        let model = MoviesCharsResponse(response: response)
                        if model.code == 200 {
                            if let data = model.data , let results = data.results , results.count > 0 {
                                self.data.value = results
                            }else {
                                self.msg.value = "No Data Found"
                            }
                        }
                        else {
                            self.msg.value = model.status ?? ""
                        }
                    case .failure(let error):
                        if error.code == InternetConnectionErrorCode.offline.rawValue {
                            self.getMoviesFromCoreData()
                            self.msg.value = error.message
                        } else {
                            //self.callError.onNext(.unknownError)
                            self.msg.value = error.message
                        }
                    }
                default:
                    break
                }
            }.disposed(by: disposeBag)
    }
}

//MARK:- Core Data
extension HomeViewModel {
    
    func getMoviesFromCoreData() {
        
        isFromCoredata = true
        managedObjectContext.rx.entities(MoviesCoredataModel.self, sortDescriptors: []).asObservable()
            .subscribe(onNext: { [weak self] movieModels in
                guard let `self` = self else {return}
                
                // Check local cache record count and binded array count same, no need to execute further code
                if self.data.value.count == movieModels.count {
                    return
                }
                
                var movies = [Result]()
                for movie in movieModels {
                    let movieModel = Result.init(model: movie)
                    // Check movie object is contains in main array which bind to tableview, ignore that object
                    if self.data.value.contains(where: { $0.id == movieModel.id }) == false {
                        movies.append(Result.init(model: movie))
                    }
                }
                
                self.data.value = (movies)
            }).disposed(by: disposeBag)
    }
    
}
