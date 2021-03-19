//
//  SearchViewController.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/19.
//

import UIKit

class SearchViewController: UIViewController {
    //MARK: State Enum
    
    enum SearchBarState {
        case history
        case autoComplete
        case searched
    }
    
    //MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: State
    var currentState: SearchBarState = .history
    var isShowingNavigationTitle: Bool = false {
        didSet {
            if oldValue != self.isShowingNavigationTitle {
                if self.isShowingNavigationTitle {
                    let fadeTextAnimation = CATransition()
                    fadeTextAnimation.duration = 0.3
                    fadeTextAnimation.type = .fade
                    navigationController?.navigationBar.layer.add(fadeTextAnimation, forKey: "fadeText")
                    navigationItem.title = LocalizedMap.TITLE_SEARCH_VIEW_CONTROLLER.localized
                }
                else {
                    let fadeTextAnimation = CATransition()
                    fadeTextAnimation.duration = 0.3
                    fadeTextAnimation.type = .fade
                    navigationController?.navigationBar.layer.add(fadeTextAnimation, forKey: "fadeText")
                    navigationItem.title = ""
                }
            }
        }
    }
    
    //MARK: property
    
    let presenter: SearchPresenter = SearchPresenter()
    let titleSectionHeight: CGFloat = 60
    
    //MARK: lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    //MARK: function
    
    func initUI() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "SearchTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTitleTableViewCell")
        self.tableView.register(UINib(nibName: "SearchHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchHistoryTableViewCell")
        self.tableView.register(UINib(nibName: "SearchAutoCompleteTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchAutoCompleteTableViewCell")
        let titleHeaderNib = UINib.init(nibName: "SearchBarTableHeaderView", bundle: Bundle.main)
        self.tableView.register(titleHeaderNib, forHeaderFooterViewReuseIdentifier: "SearchBarTableHeaderView")
        self.tableView.separatorStyle = .none
        
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        
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
            returnValue = self.titleSectionHeight
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
            let cell: SearchTitleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchTitleTableViewCell", for: indexPath) as! SearchTitleTableViewCell
            cell.selectionStyle = .none
            return cell
        case 1:
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.currentState == .history {
            if scrollView.contentOffset.y > self.titleSectionHeight {
                self.isShowingNavigationTitle = true
            }
            else {
                self.isShowingNavigationTitle = false
            }
        }
    }
    
}
