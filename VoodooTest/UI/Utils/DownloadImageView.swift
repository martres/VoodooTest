//
//  DownloadImageView.swift
//  VoodooTest
//
//  Created by Martreux Steven on 23/10/2018.
//  Copyright © 2018 Martreux Steven. All rights reserved.
//

import UIKit
import Foundation

private let cacheImageView = NSCache<AnyObject, AnyObject>()

class DownloadImageView: UIImageView {
    
    func downloadImage(at url: String) {
        guard let url = URL(string: url) else { return }
        if let imageCache = cacheImageView.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageCache
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
            guard let strongSelf = self else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            cacheImageView.setObject(image, forKey: url as AnyObject)
            DispatchQueue.main.async {
                strongSelf.image = image
            }
        }.resume()
    }
}
