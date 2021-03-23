//
//  DetailInfoCollectionTableViewCell.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/21.
//

import UIKit

protocol DetailInfoCollectionTableViewCellDelegate: DetailViewCommonProtocol {
}

class DetailInfoCollectionTableViewCell: UITableViewCell {

    //MARK: IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: property
    
    var infoData: SearchData? = nil {
        didSet {
            guard let info = self.infoData else { return }
            self.collectionView.reloadData()
        }
    }
    
    weak var delegate: DetailInfoCollectionTableViewCellDelegate?
    
    //MARK: lifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    //MARK: function
    
    func initUI() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "DetailInfoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailInfoCollectionViewCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        self.collectionView.collectionViewLayout = layout
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
    }
    
    //MARK: action
    
}

extension DetailInfoCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailInfoCollectionViewCell", for: indexPath) as! DetailInfoCollectionViewCell
        switch indexPath.item {
        case 0:
            cell.type = .rating
            guard let info = self.infoData else {
                return cell
            }
            cell.topLabel.text = CommonUtil.over1000ConvertorKor(originValue: UInt(info.userRatingCount)) + "개의 평가"
            cell.centerLabel.text = String(format: "%.1f",  info.averageUserRating)
            if info.averageUserRating == 5 {
                cell.start1ImgView.image = UIImage(systemName: "star.fill")
                cell.start2ImgView.image = UIImage(systemName: "star.fill")
                cell.start3ImgView.image = UIImage(systemName: "star.fill")
                cell.start4ImgView.image = UIImage(systemName: "star.fill")
                cell.start5ImgView.image = UIImage(systemName: "star.fill")
            }
            else if info.averageUserRating >= 4.5 {
                cell.start1ImgView.image = UIImage(systemName: "star.fill")
                cell.start2ImgView.image = UIImage(systemName: "star.fill")
                cell.start3ImgView.image = UIImage(systemName: "star.fill")
                cell.start4ImgView.image = UIImage(systemName: "star.fill")
                cell.start5ImgView.image = UIImage(systemName: "star.leadinghalf.fill")
            }
            else if info.averageUserRating >= 4 {
                cell.start1ImgView.image = UIImage(systemName: "star.fill")
                cell.start2ImgView.image = UIImage(systemName: "star.fill")
                cell.start3ImgView.image = UIImage(systemName: "star.fill")
                cell.start4ImgView.image = UIImage(systemName: "star.fill")
                cell.start5ImgView.image = UIImage(systemName: "star")
            }
            else if info.averageUserRating >= 3.5 {
                cell.start1ImgView.image = UIImage(systemName: "star.fill")
                cell.start2ImgView.image = UIImage(systemName: "star.fill")
                cell.start3ImgView.image = UIImage(systemName: "star.fill")
                cell.start4ImgView.image = UIImage(systemName: "star.leadinghalf.fill")
                cell.start5ImgView.image = UIImage(systemName: "star")
            }
            else if info.averageUserRating >= 3 {
                cell.start1ImgView.image = UIImage(systemName: "star.fill")
                cell.start2ImgView.image = UIImage(systemName: "star.fill")
                cell.start3ImgView.image = UIImage(systemName: "star.fill")
                cell.start4ImgView.image = UIImage(systemName: "star")
                cell.start5ImgView.image = UIImage(systemName: "star")
            }
            else if info.averageUserRating >= 2.5 {
                cell.start1ImgView.image = UIImage(systemName: "star.fill")
                cell.start2ImgView.image = UIImage(systemName: "star.fill")
                cell.start3ImgView.image = UIImage(systemName: "star.leadinghalf.fill")
                cell.start4ImgView.image = UIImage(systemName: "star")
                cell.start5ImgView.image = UIImage(systemName: "star")
            }
            else if info.averageUserRating >= 2 {
                cell.start1ImgView.image = UIImage(systemName: "star.fill")
                cell.start2ImgView.image = UIImage(systemName: "star.fill")
                cell.start3ImgView.image = UIImage(systemName: "star")
                cell.start4ImgView.image = UIImage(systemName: "star")
                cell.start5ImgView.image = UIImage(systemName: "star")
            }
            else if info.averageUserRating >= 1.5 {
                cell.start1ImgView.image = UIImage(systemName: "star.fill")
                cell.start2ImgView.image = UIImage(systemName: "star.leadinghalf.fill")
                cell.start3ImgView.image = UIImage(systemName: "star")
                cell.start4ImgView.image = UIImage(systemName: "star")
                cell.start5ImgView.image = UIImage(systemName: "star")
            }
            else if info.averageUserRating >= 1 {
                cell.start1ImgView.image = UIImage(systemName: "star.fill")
                cell.start2ImgView.image = UIImage(systemName: "star")
                cell.start3ImgView.image = UIImage(systemName: "star")
                cell.start4ImgView.image = UIImage(systemName: "star")
                cell.start5ImgView.image = UIImage(systemName: "star")
            }
            else {
                cell.start1ImgView.image = UIImage(systemName: "star.leadinghalf.fill")
                cell.start2ImgView.image = UIImage(systemName: "star")
                cell.start3ImgView.image = UIImage(systemName: "star")
                cell.start4ImgView.image = UIImage(systemName: "star")
                cell.start5ImgView.image = UIImage(systemName: "star")
            }
            cell.lineView.isHidden = true
            break
        case 1:
            cell.type = .string
            guard let info = self.infoData else {
                return cell
            }
            cell.topLabel.text = "연령"
            cell.centerLabel.text = info.contentAdvisoryRating
            cell.bottomLabel.text = "세"
            break
        case 2:
            cell.type = .image
            guard let info = self.infoData else {
                return cell
            }
            cell.topLabel.text = "개발자"
            cell.bottomLabel.text = info.sellerName
            break
        case 3:
            cell.type = .string
            guard let info = self.infoData else {
                return cell
            }
            cell.topLabel.text = "언어"
            cell.centerLabel.text = info.languageCodesISO2A[0]
            if info.languageCodesISO2A[0] == "EN" {
                cell.bottomLabel.text = "영어"
            }
            else if info.languageCodesISO2A[0] == "KO" {
                cell.bottomLabel.text = "한국어"
            }
            else {
                cell.bottomLabel.text = info.languageCodesISO2A[0]
            }
            break
        default:
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0: //평가 및 리뷰로 이동
            self.delegate?.moveTo(indexPath: IndexPath(row: 0, section: 4))
            break
        case 1: //연령으로 이동
            self.delegate?.moveTo(indexPath: IndexPath(row: 5, section: 7))
            break
        case 2:
            break
        case 3: //언어로 이동
            self.delegate?.moveTo(indexPath: IndexPath(row: 4, section: 7))
            break
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize:CGSize = CGSize(width: 110, height: 90)
        
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let edgeInsets:UIEdgeInsets = .init(top: 0,
                                            left: 20,
                                            bottom: 0,
                                            right: 20)
        return edgeInsets
    }
}
