//
//  SearchViewController.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/19.
//

import UIKit
import QuartzCore

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
                    self.navigationController?.setNavigationBarHidden(false, animated: true)
                    self.searchHistoryArr = self.presenter.getSearchHistorys()
                    self.tableView.reloadData()
                    break
                case .nonInputHistory:
                    self.navigationController?.setNavigationBarHidden(true, animated: true)
                    self.searchBarHeaderView?.getFirstResponder()
                    self.tableView.reloadData()
                    break
                case .autoComplete:
                    break
                case .searched:
                    self.navigationController?.setNavigationBarHidden(true, animated: true)
                    break
                }
            }
        }
    }
    
    //MARK: data
    
    var searchResultData: [SearchData] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var searchHistoryArr: Array<SearchHistoryData> = []
    
    var autoCompleteArr: Array<SearchHistoryData> = []
    
    //MARK: property
    
    weak var searchBarHeaderView: SearchBarTableHeaderView? = nil
    
    let presenter: SearchPresenter = SearchPresenter(service: SearchService())
    
    let callNextPageBeforeOffset: CGFloat = 150
    
    var isSetUserIcon: Bool = false
    
    //MARK: lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchHistoryArr = self.presenter.getSearchHistorys()
        initUI()
        self.tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        if !isSetUserIcon {
            self.isSetUserIcon = true
            addUserIcon()
        }
    }
    
    //MARK: function
    
    func initUI() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
        showLargeTitle()
    }
    
    func search(text: String) {
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
    
    func showLargeTitle() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = LocalizedMap.TITLE_SEARCH_VIEW_CONTROLLER.localized
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func addUserIcon() {
        let imageView = UIImageView(image: UIImage(systemName: "person.circle"))
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickedUserIcon(_:)))
        imageView.addGestureRecognizer(tapGesture)
        guard let UINavigationBarLargeTitleView = NSClassFromString("_UINavigationBarLargeTitleView") else { return }
        guard let largeTitleView = self.navigationController?.navigationBar.subviews.first(where: {
            $0.isKind(of: UINavigationBarLargeTitleView.self)
        }) else { return }
        largeTitleView.removeAllSubview()
        largeTitleView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.rightAnchor.constraint(equalTo: self.navigationController!.navigationBar.rightAnchor, constant: -20),
            imageView.bottomAnchor.constraint(equalTo: self.navigationController!.navigationBar.bottomAnchor, constant: -13),
            imageView.heightAnchor.constraint(equalToConstant: 30),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
            ])
    }
    
    //MARK: action
    
    @objc func clickedUserIcon(_ recognizer: UITapGestureRecognizer) {
        print("유저 아이콘 클릭")
    }
    
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
            return UITableViewCell()
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
            break
        case .nonInputHistory:
            break
        case .autoComplete:
            break
        case .searched:
            let offset = scrollView.contentOffset;
            let bounds = scrollView.bounds;
            let size = scrollView.contentSize;
            let inset = scrollView.contentInset;
            let y = offset.y + bounds.size.height - inset.bottom;
            let h = size.height;
            if y + self.callNextPageBeforeOffset >= h {
                self.presenter.getNextPageData(completeHandler: { response in
                    self.searchResultData += response
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }, failureHandler: { err in
                    print("페이징 실패:\(err.localizedDescription)")
                })
            }
            break
        
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        switch self.currentState {
        case .history:
            break
        case .nonInputHistory:
            break
        case .autoComplete:
            break
        case .searched:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 { //0번섹션은 처리하지않음, 오로지 1번섹션(결과들)만
            switch self.currentState {
            case .history:
                let text = self.searchHistoryArr[indexPath.row].searchText
                self.searchBarHeaderView?.setTextToSearchBar(text: text)
                search(text: text)
                break
            case .nonInputHistory:
                let text = self.searchHistoryArr[indexPath.row].searchText
                self.searchBarHeaderView?.setTextToSearchBar(text: text)
                search(text: text)
                break
            case .autoComplete:
                let text = self.autoCompleteArr[indexPath.row].searchText
                self.searchBarHeaderView?.setTextToSearchBar(text: text)
                search(text: text)
                break
            case .searched:
                if let vc = DetailViewController.makeViewController(presenter: DetailPresenter(), infoData: self.searchResultData[indexPath.row]) {
                    self.currentState = .searched
                    self.navigationController?.pushViewController(vc, animated: true)
                    vc.delegate = self
                }
                break
            }
        }
    }
    
}


extension SearchViewController : SearchBarTableHeaderViewDelegate {
    func searchBarSearchBtnClicked(_ view: SearchBarTableHeaderView, text: String) {
        search(text: text)
    }
    
    func searchBarInputedText(_ view: SearchBarTableHeaderView, text: String) {
        if text == "" {
            self.currentState = .nonInputHistory
        }
        else {
            self.autoCompleteArr = self.presenter.getAutoCompleteHistoryData(keyword: text)
            self.currentState = .autoComplete
            self.tableView.reloadData()
        }
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


extension SearchViewController: DetailViewControllerDelegate {
    func viewPoped() {
        self.addUserIcon()
    }
}
