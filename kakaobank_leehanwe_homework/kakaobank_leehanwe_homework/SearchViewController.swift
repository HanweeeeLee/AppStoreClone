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
        case nonInputHistory
        case autoComplete
        case searched
    }
    
    //MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: State
    var currentState: SearchBarState = .history {
        didSet {
            if oldValue != self.currentState {
                print("newState!: \(self.currentState)")
                switch self.currentState {
                case .history:
                    self.navigationController?.setNavigationBarHidden(false, animated: false)
                    self.searchHistoryArr = self.presenter.getSearchHistorys()
                    self.tableView.reloadData()
                    break
                case .nonInputHistory:
                    self.navigationController?.setNavigationBarHidden(true, animated: false)
                    self.tableView.reloadData()
                    break
                case .autoComplete:
                    break
                case .searched:
                    break
                }
            }
        }
    }
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
    var titleSectionEffectPercent: CGFloat = 0 {
        didSet {
            self.searchBarHeaderView?.setColorEffect(percent: self.titleSectionEffectPercent)
        }
    }
    
    //MARK: data
    
    var searchResultData: [SearchData] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print("이게 많이 호출되면 안된다 !!!!!!")
            }
        }
    }
    
    var searchHistoryArr: Array<SearchHistoryData> = []
    
    var autoCompleteArr: Array<SearchHistoryData> = []
    
    //MARK: property
    
    weak var searchBarHeaderView: SearchBarTableHeaderView? = nil
    
    let presenter: SearchPresenter = SearchPresenter(service: SearchService())
    let titleSectionHeight: CGFloat = 60
    
    //MARK: lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchHistoryArr = self.presenter.getSearchHistorys()
        initUI()
        self.tableView.reloadData()
    }
    
    //MARK: function
    
    func initUI() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "SearchTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTitleTableViewCell")
        self.tableView.register(UINib(nibName: "SearchHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchHistoryTableViewCell")
        self.tableView.register(UINib(nibName: "SearchAutoCompleteTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchAutoCompleteTableViewCell")
        self.tableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchResultTableViewCell")
        
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
            switch self.currentState {
            case .history:
                return 1
            case .nonInputHistory:
                return 0
            case .autoComplete:
                return 0
            case .searched:
                return 0
            }
        case 1:
            switch self.currentState {
            case .history:
                return self.searchHistoryArr.count
            case .nonInputHistory:
                return self.searchHistoryArr.count
            case .autoComplete:
                return self.autoCompleteArr.count
            case .searched:
                return self.searchResultData.count
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SearchBarTableHeaderView") as! SearchBarTableHeaderView
            self.searchBarHeaderView = headerView
            headerView.delegate = self
            headerView.currentState = self.currentState
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
            if currentState == .searched {
                returnValue = 80 + ((UIScreen.main.bounds.width - 40)/3 * 2.5) + 10
            }
            else {
                returnValue = 50
            }
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
            switch self.currentState {
            case .history:
                let cell: SearchHistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchHistoryTableViewCell", for: indexPath) as! SearchHistoryTableViewCell
                cell.selectionStyle = .none
                cell.infoData = self.searchHistoryArr[indexPath.row]
                cell.delegate = self
                return cell
            case .nonInputHistory:
                let cell: SearchHistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchHistoryTableViewCell", for: indexPath) as! SearchHistoryTableViewCell
                cell.selectionStyle = .none
                cell.infoData = self.searchHistoryArr[indexPath.row]
                cell.delegate = self
                return cell
            case .autoComplete:
                let cell: SearchAutoCompleteTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchAutoCompleteTableViewCell", for: indexPath) as! SearchAutoCompleteTableViewCell
                cell.selectionStyle = .none
                cell.infoData = autoCompleteArr[indexPath.row]
                return cell
            case .searched:
                let cell: SearchResultTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell", for: indexPath) as! SearchResultTableViewCell
                cell.selectionStyle = .none
                cell.infoData = self.searchResultData[indexPath.row]
                return cell
            }
        default:
            return UITableViewCell()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchBarHeaderView?.resignTextInput()
        switch self.currentState {
        case .history:
            if scrollView.contentOffset.y >= self.titleSectionHeight {
                self.isShowingNavigationTitle = true
                self.titleSectionEffectPercent = 1
            }
            else {
                self.isShowingNavigationTitle = false
                self.titleSectionEffectPercent = scrollView.contentOffset.y/titleSectionHeight
            }
            break
        case .nonInputHistory:
            break
        case .autoComplete:
            break
        case .searched:
            break
        
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        switch self.currentState {
        case .history:
            if scrollView.contentOffset.y > self.titleSectionHeight {
                self.isShowingNavigationTitle = true
            }
            else if self.titleSectionHeight > scrollView.contentOffset.y && scrollView.contentOffset.y > self.titleSectionHeight/2 {
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
            }
            else {
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
            break
        case .nonInputHistory:
            break
        case .autoComplete:
            break
        case .searched:
            break
        }
    }
    
}


extension SearchViewController : SearchBarTableHeaderViewDelegate {
    func searchBarSearchBtnClicked(_ view: SearchBarTableHeaderView, text: String) {
        self.searchResultData.removeAll()
        self.currentState = .searched
        self.tableView.reloadData()
        self.presenter.search(keyword: text, completeHandler: { [weak self] response in
            self?.searchResultData = response
        }, failureHandler: { [weak self] err in
            let alert = UIAlertController(title: "error", message: err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            }
            alert.addAction(okAction)
            DispatchQueue.main.async {
                self?.present(alert, animated: false, completion: nil)
            }
        })
    }
    
    func searchBarInputedText(_ view: SearchBarTableHeaderView, text: String) {
        self.autoCompleteArr = self.presenter.getAutoCompleteHistoryData(keyword: text)
        self.currentState = .autoComplete
        self.tableView.reloadData()
    }
    
    func searchCancelAction(_ view: SearchBarTableHeaderView) {
        self.currentState = .history
    }
    
    func searchBarTextDidBeginEditing(_ view: SearchBarTableHeaderView) {
        self.currentState = .nonInputHistory
    }
    
    func searchBarTextDidEndEditing(_ view: SearchBarTableHeaderView) {
        
    }
}

extension SearchViewController: SearchHistoryTableViewCellDelegate {
    func deleteHistory(key: String) {
        self.presenter.deleteSearchHistroy(key: key, completeHandler: {
            self.searchHistoryArr = self.presenter.getSearchHistorys()
            self.tableView.reloadData()
        }, failureHandler: { err in
            print("delete history error:\(err.localizedDescription)")
        })
    }
}
