//
//  HomeVC.swift
//  MarvelApp
//
//  Created by Amir on 1/27/21.
//  Copyright © 2021 Amir. All rights reserved.
//

import UIKit
import Kingfisher

class HomeVC: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getMoviesDataAPI()
        
    }
    
    override func setupUI() {
        
        tableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        
        // LOADING
        viewModel.isLoading
            .distinctUntilChanged()
            .drive(onNext: { [weak self] (isLoading) in
                guard let `self` = self else { return }
                // Hide Indicator
                self.killLoading()
                if isLoading {
                    // Show Indicator
                    self.loading()
                }
            })
            .disposed(by: disposeBag)
        
        //Alerts
        
        viewModel.msg.asObservable().subscribe { [weak self ] msg in
            guard let self = self else {return}
            print("\(msg)")
        }.disposed(by: disposeBag)
        
        // Binding Data
        viewModel.data.asObservable()
            .bind(to: tableView.rx.items) { (table, row, element) in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = table.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
                cell.movieTitle.text = self.viewModel.data.value[row].name
                if let image = self.viewModel.data.value[row].thumbnail?.path , let _extention = self.viewModel.data.value[row].thumbnail?._extensionX {
                    if _extention.count > 0  {
                        cell.movieImg.downloadImageWithCaching(with: image+"."+_extention)
                    }else {
                        cell.movieImg.downloadImageWithCaching(with: image)
                    }
                }
                return cell
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Result.self).asObservable().subscribe { [weak self ]selectedItem in
            guard let self = self , let selected = selectedItem.element else {return}
            if let id = selected.id
            {
                let viewModel = MovieDetailsViewModel(id: id)
                let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailsVC") as! MovieDetailsVC
                vc.movieName = selected.name ?? ""
                vc.viewModel = viewModel
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }.disposed(by: disposeBag)
        
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
}
