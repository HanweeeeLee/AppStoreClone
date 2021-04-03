//
//  SearchHistoryTableViewCell.swift
//  AppStoreClone
//
//  Created by hanwe on 2021/03/19.
//

import UIKit

protocol SearchHistoryTableViewCellDelegate: class {
    func deleteHistory(key: String)
}

class SearchHistoryTableViewCell: UITableViewCell {
    
    //MARK: IBOutlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var searchHistoryLabel: UILabel!
    
    //MARK: property
    
    var infoData: SearchHistoryData? = nil {
        didSet {
            guard let info = self.infoData else { return }
            self.searchHistoryLabel.text = info.searchText
        }
    }
    
    weak var delegate: SearchHistoryTableViewCellDelegate?
    
    //MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    //MARK: function
    
    func initUI() {
        
    }
    
    //MARK: action
    
    @IBAction func deleteSearchHistory(_ sender: Any) {
        guard let info = self.infoData else { return }
        self.delegate?.deleteHistory(key: info.searchText)
    }
    
    
    
    
}
