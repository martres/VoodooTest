//
//  ProfilViewController.swift
//  VoodooTest
//
//  Created by Martreux Steven on 28/10/2018.
//  Copyright © 2018 Martreux Steven. All rights reserved.
//

import UIKit

class ProfilViewController: UIViewController {
    
    @IBOutlet private weak var imageProfil: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageProfil.layer.cornerRadius = imageProfil.frame.height / 2
        imageProfil.clipsToBounds = true
    }
    
    // MARK: IBActions
    
    @IBAction private func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func showLinkedin() {
        guard let url = URL(string: "https://www.linkedin.com/in/stevenmartreux/") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction private func showGithub() {
        guard let url = URL(string: "https://github.com/martres") else { return }
        UIApplication.shared.open(url)
    }
}
