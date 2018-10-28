//
//  TodayCell.swift
//  VoodooTest
//
//  Created by Martreux Steven on 23/10/2018.
//  Copyright © 2018 Martreux Steven. All rights reserved.
//

import UIKit

typealias TodayView = TodayCell

final class TodayCell: UICollectionViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var iconApp: DownloadImageView!
    @IBOutlet private weak var developerLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var rateImage: UIImageView!
    @IBOutlet private weak var backView: UIView!
    
    class func instance(with identifier: TodayIdentifierCell) -> UIView {
        return UINib(nibName: identifier.rawValue, bundle: .main).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.iconApp.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCorner(value: 10)
    }
    
    func setCorner(value: CGFloat) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = value
        backView.layer.cornerRadius = value
        backView.layer.masksToBounds = true
    }
        
    func setup(app: Application) {
        titleLabel.text = app.title
        developerLabel.text = app.developer
        priceLabel.text = app.price
        if app.rates != 0 {
            rateLabel.text = "\(app.rates)"
            rateImage.isHidden = false
        } else {
            rateLabel.text = ""
            rateImage.isHidden = true
        }
        if let url = app.iconURL {
            iconApp.downloadImage(at: url)
        }
    }
}
