//
//  ViewController.swift
//  HW_7.2
//
//  Created by Elizaveta Rogozhina on 06.06.2021.
//

import UIKit
import RxSwift
import RxCocoa

var personeID = 0

class ViewController: UIViewController{
    var names: [String] = [],
        searchResult: [String] = [],
        status: [String] = [],
        last_loc: [String] = [],
        species: [String] = [],
        icon: [UIImage] = [],
        disposeBag = DisposeBag(),
        newNames: [String] = [],
        newStatus: [String] = [],
        newLast_loc: [String] = [],
        newSpecies: [String] = [],
        newIcons: [UIImage] = [],
        isLoading = false

    @IBOutlet weak var searchPersoneBar: UISearchBar!
    @IBOutlet weak var allTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = ViewModelTable()
        viewModel.infoDelegate = self
        self.allTable.delegate = self
        self.allTable.dataSource = self
        self.searchPersoneBar.delegate = self
        
        self.allTable.rx.itemSelected
          .subscribe(onNext: { indexPath in
            personeID = indexPath.row + 1
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyboard.instantiateViewController(withIdentifier: "PersoneCard") as! ViewControllerPersone
            self.present(newViewController, animated: true, completion: nil)
          }).disposed(by: disposeBag)
    }
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            DispatchQueue.global().async{
                sleep(2)
                DispatchQueue.main.async {
                    self.allTable.reloadData()
                    self.isLoading = false
                }
            }
        }
    }
}

extension ViewController: uploadInfo {
    func uploadAllInfo(names: [String], status: [String], last_loc: [String], species: [String], icons: [UIImage]){
        self.names = names
        searchResult = names
        self.status = status
        self.last_loc = last_loc
        self.species = species
        self.icon = icons
        allTable.reloadData()
        self.newNames = self.names
        self.newStatus = self.status
        self.newLast_loc = self.last_loc
        self.newSpecies = self.species
        self.newIcons = self.icon
    }
}

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            names = searchText.isEmpty ? searchResult: searchResult.filter{ (item: String) -> Bool in
                return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            }
        for (i, j) in newNames.enumerated(){
            for (k, m) in names.enumerated(){
                if j == m{
                    self.status[k] = newStatus[i]
                    self.last_loc[k] = newLast_loc[i]
                    self.species[k] = newSpecies[i]
                    self.icon[k] = newIcons[i]
                }
            }
        }
        allTable.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return names.count
        } else if section == 1 {
            return 1
        } else {
            return 0
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading {
                loadMoreData()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
            return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "base_info", for: indexPath) as! AllPersoneTableViewCell
            cell.namePersonLabel.text = names[indexPath.row]
            cell.last_locationLabel.text = last_loc[indexPath.row]
            cell.statusPersonLabel.text = "\(status[indexPath.row]) - \(species[indexPath.row])"
            cell.statusView.backgroundColor = ChangeColorStatus().colorStatus(status: status[indexPath.row])
            cell.personImage.image = icon[indexPath.row]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "base_info", for: indexPath) as! AllPersoneTableViewCell
            cell.activityIndicator.startAnimating()
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension NSLayoutConstraint {
    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)"
    }
}
