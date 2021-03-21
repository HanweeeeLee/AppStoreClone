//
//  DetailViewController.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/21.
//

import UIKit

protocol DetailViewCommonProtocol: class {
    func reloadTableView()
}

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
//        self.tableView.register(UINib(nibName: "DetailInfoCollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailInfoCollectionTableViewCell")
//        self.tableView.register(UINib(nibName: "DetailPreViewTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailPreViewTableViewCell")
        self.tableView.register(UINib(nibName: "DetailReleaseNoteTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailReleaseNoteTableViewCell")
        self.tableView.register(UINib(nibName: "DetailContentsTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailContentsTableViewCell")
        self.tableView.register(UINib(nibName: "DetailRatingTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailRatingTableViewCell")
        self.tableView.register(UINib(nibName: "DetailReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailReviewTableViewCell")
        
    }
    
    //MARK: action
    
   

}


extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell: DetailHeaderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailHeaderTableViewCell", for: indexPath) as! DetailHeaderTableViewCell
            cell.selectionStyle = .none
            cell.infoData = self.searchResultData
            return cell
        case 1:
            return UITableViewCell() //콜렉션천국
        case 2:
            let cell: DetailContentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailContentsTableViewCell", for: indexPath) as! DetailContentsTableViewCell
            cell.selectionStyle = .none
            cell.infoData = self.searchResultData
            cell.delegate = self
            return cell
        case 3:
            let cell: DetailRatingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailRatingTableViewCell", for: indexPath) as! DetailRatingTableViewCell
            cell.selectionStyle = .none
            cell.infoData = self.searchResultData
            return cell
        case 4:
            return UITableViewCell() //리뷰남기기
        case 5:
            let cell: DetailReleaseNoteTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailReleaseNoteTableViewCell", for: indexPath) as! DetailReleaseNoteTableViewCell
            cell.selectionStyle = .none
            cell.infoData = self.searchResultData
            return cell
        case 6:
            return UITableViewCell() //데이터 수집 노가다
        case 7:
            return UITableViewCell() //정보
        case 8:
            return UITableViewCell() //지원
        default:
            return UITableViewCell()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}

extension DetailViewController: DetailViewCommonProtocol {
    func reloadTableView() {
        self.tableView.reloadData()
    }
}


extension DetailViewController: DetailContentsTableViewCellDelegate {
}
