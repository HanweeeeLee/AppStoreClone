//
//  DetailContentsTableViewCell.swift
//  AppStoreClone
//
//  Created by hanwe on 2021/03/21.
//

import UIKit


protocol DetailContentsTableViewCellDelegate: DetailViewCommonProtocol {
    func switchMoreContentsTableViewCellMode()
}

class DetailContentsTableViewCell: UITableViewCell {

    enum Mode {
        case simple
        case detail
    }
    
    //MARK: IBOutlet
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var developLabel: UILabel!
    
    //MARK: property
    
    var infoData: SearchData? = nil {
        didSet {
            guard let info = self.infoData else { return }
            self.companyLabel.text = info.sellerName
            self.contentsLabel.text = info.description
        }
    }
    
    var mode: Mode = .simple {
        didSet {
            switch self.mode {
            case .simple:
                break
            case .detail:
                self.contentsLabel.numberOfLines = 100
                self.moreBtn.isHidden = true
                
                break
            }
        }
    }
    
    weak var delegate: DetailContentsTableViewCellDelegate?
    
    //MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    //MARK: function
    
    func initUI() {
        self.contentsLabel.numberOfLines = 3
        self.moreBtn.setTitle(LocalizedMap.MORE.localized, for: .normal)
        self.developLabel.text = LocalizedMap.DEVELOPER.localized
    }
    
    //MARK: action
    
    @IBAction func moreAction(_ sender: Any) {
        self.delegate?.switchMoreContentsTableViewCellMode()
        self.delegate?.reloadTableView(indexPath: IndexPath(row: 0, section: 2))
    }
    
    @IBAction func devAction(_ sender: Any) {
        print("개발자버튼 눌림")
    }
}
