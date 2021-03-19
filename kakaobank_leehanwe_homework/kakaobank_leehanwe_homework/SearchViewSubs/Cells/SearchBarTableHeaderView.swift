//
//  SearchBarTableHeaderView.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/19.
//

import UIKit

class SearchBarTableHeaderView: UITableViewHeaderFooterView {

    //MARK: IBOutlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var lineView: UIView!
    
    //MARK: property
    
    //MARK: lifeCycle
    
    override func awakeFromNib() {
        initUI()
    }
    
    //MARK: function
    
    func initUI() {
        self.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: UIBarMetrics.default)
        self.colorView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 0)
        self.lineView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 0)
    }
    
    func setColorEffect(percent: CGFloat) {
        self.colorView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: percent)
        self.lineView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: percent)
    }
    
    //MARK: action
    @IBAction func cancelAction(_ sender: Any) {
    }

}
