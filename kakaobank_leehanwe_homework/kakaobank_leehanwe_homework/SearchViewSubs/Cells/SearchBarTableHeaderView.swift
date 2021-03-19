//
//  SearchBarTableHeaderView.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/19.
//

import UIKit

class SearchBarTableHeaderView: UITableViewHeaderFooterView {

    //MARK: IBOutlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cancelBtn: UIButton!
    
    //MARK: property
    
    //MARK: lifeCycle
    
    override func awakeFromNib() {
        initUI()
    }
    
    //MARK: function
    
    func initUI() {
        self.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: UIBarMetrics.default)
    }
    
    //MARK: action
    @IBAction func cancelAction(_ sender: Any) {
    }

}
