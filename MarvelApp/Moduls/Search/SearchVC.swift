//
//  NewSearchVC.swift
//  MadeInKuwait
//
//  Created by Amir on 3/1/20.
//  Copyright © 2020 Amir. All rights reserved.
//
import UIKit
import Kingfisher

class SearchVC: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtSearchBar: UITextField!
    
    var viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.txtSearchBar.delegate = self
        self.txtSearchBar.backgroundColor = .white
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func setupUI() {
        
        self.tableView.register(UINib (nibName: "SearchViewCell", bundle: nil), forCellReuseIdentifier: "SearchViewCell")
        
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
                let cell = table.dequeueReusableCell(withIdentifier:"SearchViewCell", for: indexPath) as! SearchViewCell
                
                cell.movieName.text = self.viewModel.data.value[row].name
                if let image = self.viewModel.data.value[row].thumbnail?.path , let _extention = self.viewModel.data.value[row].thumbnail?._extensionX {
                    if let url = URL(string: image+"."+_extention) {
                        cell.movieImg.kf.setImage(with: url)
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
                vc.viewModel = viewModel
                self.present(vc, animated: true, completion: nil)
            }
        }.disposed(by: disposeBag)
    }
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil )
    }
}

extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        txtSearchBar.resignFirstResponder()
        txtSearchBar.text = ""
        viewModel.data.value = []
        tableView.reloadData()
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (txtSearchBar.text?.count)! != 0 {
            self.view.endEditing(true)
            viewModel.data.value = []
            viewModel.getSearchDataAPI(name: textField.text ?? "")
        }
        return true
    }
    
}



