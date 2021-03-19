//
//  SearchViewController.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/19.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class SearchViewController: UIViewController, MVVMViewController {
    
    typealias MVVMViewModelClassType = SearchViewModel
    typealias SelfType = SearchViewController
    
    //MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
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
    
    
}
