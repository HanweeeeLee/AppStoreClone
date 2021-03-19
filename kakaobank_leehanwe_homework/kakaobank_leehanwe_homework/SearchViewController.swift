//
//  SearchViewController.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/19.
//

import UIKit
import RxSwift
import RxCocoa
import HWNavigationView

class SearchViewController: UIViewController, MVVMViewController {
    
    typealias MVVMViewModelClassType = SearchViewModel
    typealias SelfType = SearchViewController
    
    //MARK: IBOutlet
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var topContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBarHeightConstranit: NSLayoutConstraint!
    @IBOutlet weak var subViewContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: fold
    var foldPercent: CGFloat = 1.0 { //1이면 다 펴져있음
        didSet {
            print("foldPercent:\(self.foldPercent)")
            let offset: CGFloat = self.foldPercent * (self.maxTitleHeight - self.minTitleHeight)
            self.topContainerViewHeightConstraint.constant = self.minTitleHeight + offset
        }
    }
    var minTitleHeight: CGFloat = 0
    var maxTitleHeight: CGFloat = 0
    
    func animationFold(isFold: Bool, duration: TimeInterval) {
        if isFold {
            self.topContainerViewHeightConstraint.constant = self.minTitleHeight
        }
        else {
            self.topContainerViewHeightConstraint.constant = self.maxTitleHeight
        }
        
        UIView.animate(withDuration: duration, animations: {
            self.view.layoutIfNeeded()
        }, completion: {[weak self] _ in
            if isFold {
                self?.foldPercent = 0
            }
            else {
                self?.foldPercent = 1
            }
        })
    }
    
    //MARK: property
    
    var disposeBag: DisposeBag = DisposeBag()
    var isViewModelBinded: Bool = false
    var viewModel: SearchViewModel! = SearchViewModel()
    
    
    
    //MARK: lifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindingViewModel(viewModel: self.viewModel)
        initUI()
        self.tableView.delegate = self //test
        self.tableView.dataSource = self //test
    }
    
    //MARK: function
    
    static func makeViewController(viewModel: SearchViewModel) -> SearchViewController? {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
    }
    
    func initUI() {
        self.minTitleHeight = self.searchBarHeightConstranit.constant
        self.maxTitleHeight = self.topContainerViewHeightConstraint.constant
        self.titleLabel.font = UIFont(name: CommonDefine.FontBoldKey, size: CommonDefine.FontTitleSize)
        self.titleLabel.text = LocalizedMap.TITLE_SEARCH_VIEW_CONTROLLER.localized
    }
    
    func bind(viewModel: MVVMViewModel) {
        print("bind!")
    }
    
    //MARK: action
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.minTitleHeight > scrollView.contentOffset.y {
            let maxOffset = self.maxTitleHeight - self.minTitleHeight
            let yOffset = scrollView.contentOffset.y
            self.foldPercent = 1 - yOffset/maxOffset
        }
        else {
            self.animationFold(isFold: true, duration: 0.1)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.foldPercent > 0.5 {
            self.animationFold(isFold: false, duration: 0.2)
        }
        else {
            self.animationFold(isFold: true, duration: 0.2)
        }
    }
    
    
}
