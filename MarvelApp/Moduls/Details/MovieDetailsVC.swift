//
//  MovieDetailsVC.swift
//  MarvelApp
//
//  Created by Amir on 1/27/21.
//  Copyright © 2021 Amir. All rights reserved.
//

import UIKit

class MovieDetailsVC: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLbl: UILabel!
    
    var viewModel : MovieDetailsViewModel!
    var movieName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text = self.movieName
        viewModel.getMoviesDetailsAPI()
    }
    
    override func setupUI() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.register(UINib(nibName: "CoverCell", bundle: nil), forCellReuseIdentifier: "CoverCell")
        tableView.register(UINib(nibName: "CategoriesCell", bundle: nil), forCellReuseIdentifier: "CategoriesCell")
        
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
                
        viewModel.data.asObservable().bind(to: tableView.rx.items){(tv, row, item) -> UITableViewCell in
            let indexPath = IndexPath.init(row: row, section: 0)
            if row == 0 {
                let cell = tv.dequeueReusableCell(withIdentifier: "CoverCell", for: indexPath) as! CoverCell
                if let item = item.items?[0] , let name = item.name , let desc = item.resourceURI , let image = item.type {
                    cell.movieImg.kf.setImage(with: URL(string: image)!)
                    cell.movieTitle.text = name
                    cell.movieDesc.text = desc
                }
                return cell
            }
            else if indexPath.row == 1{
                let cell = tv.dequeueReusableCell(withIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
                cell.items = self.viewModel.comics.value
                cell.customV = self
                cell.categoryLbl.text = "Comics"
                return cell
            }
            else if indexPath.row == 2{
                let cell = tv.dequeueReusableCell(withIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
                cell.items = self.viewModel.events.value
                cell.customV = self
                cell.categoryLbl.text = "Events"
                return cell
            }
            else if indexPath.row == 3{
                let cell = tv.dequeueReusableCell(withIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
                cell.items = self.viewModel.series.value
                cell.customV = self
                cell.categoryLbl.text = "Series"
                return cell
            }
            else if indexPath.row == 4{
                let cell = tv.dequeueReusableCell(withIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
                cell.items = self.viewModel.stories.value
                cell.customV = self
                cell.categoryLbl.text = "Stories"
                return cell
            }
            else{
                return UITableViewCell()
            }
            
        }.disposed(by: disposeBag)
        
                
    }
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
