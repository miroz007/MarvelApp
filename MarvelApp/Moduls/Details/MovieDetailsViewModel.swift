//
//  MovieDetailsViewModel.swift
//  MarvelApp
//
//  Created by Amir on 1/28/21.
//  Copyright © 2021 Amir. All rights reserved.
//

import Foundation
import RxSwift

class MovieDetailsViewModel : BaseViewModel {
    
    let isLoading: ActivityIndicator =  ActivityIndicator()
    lazy var msg = Variable<String>("")
    var data = Variable<[Comic]>([])
    
    var comics = Variable<[Results]>([])
    var events = Variable<[Results]>([])
    var series = Variable<[Results]>([])
    var stories = Variable<[Results]>([])
    
    var id :Int
    
     init(id:Int) {
        self.id = id
    }
    
    
    func getMoviesDetailsAPI() {
        self.dependency.api.regularRequest(apiRouter: .charDetails(id: id))
            .trackActivity(isLoading)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe {[weak self] (event) in
                guard let `self` = self else { return }
                switch event {
                case .next(let result):
                    switch result {
                    case .success(value: let response):
                        let model = MoviesCharsDetailsResponse(response: response)
                        if model.code == 200 {
                            if let data = model.data , let results = data.results , results.count > 0 {
                                var _image = ""
                                if let image = results[0].thumbnail?.path , let ext = results[0].thumbnail?._extension {
                                    _image = image + "." + ext
                                }
                                let item = Item(name: results[0].name, resourceURI: results[0].descriptionField, type: _image)
                                let movieDetail = Comic(available: 0, collectionURI: "", items: [item], returned: 0)
                                self.data.value.append(movieDetail)
                                if let comics = results[0].comics {
                                        self.data.value.append(comics)
                                        self.getSperatedMoviesAPI(api:  .comics(id: self.id))
                                }
                                if let comics = results[0].events {
                                        self.data.value.append(comics)
                                        self.getSperatedMoviesAPI(api:  .events(id: self.id))
                                }
                                if let comics = results[0].stories {
                                        self.data.value.append(comics)
                                        self.getSperatedMoviesAPI(api:  .stories(id: self.id))
                                }
                                if let comics = results[0].series {
                                        self.data.value.append(comics)
                                        self.getSperatedMoviesAPI(api:  .series(id: self.id))
                                }
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
    
    
    func getSperatedMoviesAPI(api:APIRouter) {
        self.dependency.api.regularRequest(apiRouter: api)
            .trackActivity(isLoading)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe {[weak self] (event) in
                guard let `self` = self else { return }
                switch event {
                case .next(let result):
                    switch result {
                    case .success(value: let response):
                        let model = MoviesCharsDetailsResponse(response: response)
                        if model.code == 200 {
                            if let data = model.data , let results = data.results , results.count > 0 {
                                switch api {
                                case .comics:
                                    self.comics.value = results
                                case .events:
                                    self.events.value = results
                                case .series:
                                    self.series.value = results
                                case .stories:
                                    self.stories.value = results
                                default : break
                                }
                            }
                            else {
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
