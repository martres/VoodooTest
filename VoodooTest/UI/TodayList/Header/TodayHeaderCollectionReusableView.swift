//
//  TodayHeaderCollectionReusableView.swift
//  VoodooTest
//
//  Created by Martreux Steven on 28/10/2018.
//  Copyright © 2018 Martreux Steven. All rights reserved.
//

import UIKit

protocol TodayHeaderDelegate: class {
    func showProfilView()
}

class TodayHeaderCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var profilImage: UIButton!
    
    static let identifier: String = "TodayHeaderCollectionReusableView"
    
    weak var delegate: TodayHeaderDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        dateLabel.text = Date.getCurrentDate()
        profilImage.layer.cornerRadius = profilImage.frame.height / 2
        profilImage.clipsToBounds = true
    }
    
    @IBAction private func showProfilView() {
        delegate?.showProfilView()
    }
    
}
