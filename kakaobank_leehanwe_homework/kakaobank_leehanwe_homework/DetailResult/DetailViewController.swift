//
//  DetailViewController.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/21.
//

import UIKit

class DetailViewController: UIViewController, MVPViewControllerProtocol {
    typealias MVPPresenterClassType = DetailPresenter
    typealias SelfType = DetailViewController
    
    //MARK: IBOutlet
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: property
    var presenter: DetailPresenter!
    var searchResultData: SearchData!
    
    //MARK: lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    //MARK: function
    
    static func makeViewController(presenter: DetailPresenter, infoData: SearchData) -> DetailViewController? {
        if let vc = DetailViewController.makeViewController(presenter: presenter) {
            vc.searchResultData = infoData
            return vc
        }
        return nil
    }
    
    static func makeViewController(presenter: DetailPresenter) -> DetailViewController? {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            viewController.presenter = presenter
            return viewController
        }
        return nil
    }
    
    func initUI() {
        self.mainContainerView.backgroundColor = .clear
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "DetailHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailHeaderTableViewCell")
//        self.tableView.register(UINib(nibName: "SearchHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchHistoryTableViewCell")
//        self.tableView.register(UINib(nibName: "SearchAutoCompleteTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchAutoCompleteTableViewCell")
//        self.tableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchResultTableViewCell")
    }
    
    //MARK: action
    
   

}


extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 안쓸예정
//        var returnValue: CGFloat = 100
//        return returnValue
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell: DetailHeaderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailHeaderTableViewCell", for: indexPath) as! DetailHeaderTableViewCell
            cell.selectionStyle = .none
            cell.infoData = self.searchResultData
            return cell
        case 1:
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}
