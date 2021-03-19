//
//  SearchViewController.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/19.
//

import UIKit

class SearchViewController: UIViewController {
    //MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: property
    
    let presenter: SearchPresenter = SearchPresenter()
    
    //MARK: lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    //MARK: function
    
    func initUI() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "SearchTItleTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTItleTableViewCell")
        self.tableView.register(UINib(nibName: "SearchHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchHistoryTableViewCell")
        self.tableView.register(UINib(nibName: "SearchAutoCompleteTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchAutoCompleteTableViewCell")
        let titleHeaderNib = UINib.init(nibName: "SearchBarTableHeaderView", bundle: Bundle.main)
        self.tableView.register(titleHeaderNib, forHeaderFooterViewReuseIdentifier: "SearchBarTableHeaderView")
        self.tableView.separatorStyle = .none
        
    }
    
    //MARK: action
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 100
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SearchBarTableHeaderView") as! SearchBarTableHeaderView
            return headerView
        }
        else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 44
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var returnValue: CGFloat = 0
        switch indexPath.section {
        case 0:
            returnValue = 60
            break
        case 1:
            returnValue = 50
            break
        default:
            break
        }
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell: SearchTItleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchTItleTableViewCell", for: indexPath) as! SearchTItleTableViewCell
            cell.selectionStyle = .none
            return cell
        case 1:
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
}
