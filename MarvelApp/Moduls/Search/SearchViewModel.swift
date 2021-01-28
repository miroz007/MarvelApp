//
//  SearchViewModel.swift
//  MarvelApp
//
//  Created by Amir on 1/28/21.
//  Copyright © 2021 Amir. All rights reserved.
//

import UIKit
import RxSwift

class SearchViewModel : BaseViewModel {
    
    let isLoading: ActivityIndicator =  ActivityIndicator()
    lazy var msg = Variable<String>("")
    var data = Variable<[Result]>([])
    
    
//    //Selected Model
//    var selectedItem = PublishSubject<String?>()
    
//    //Paging Metadata
//    var nextPage: Int? = 1
    
//    //Method
//    var callNextPage = PublishSubject<Void>()

    override init() {
        
    }
    
    
    func getSearchDataAPI(name:String) {
        self.dependency.api.regularRequest(apiRouter: .search(name: name))
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
                            //self.callError.onNext(.noInternet)
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

