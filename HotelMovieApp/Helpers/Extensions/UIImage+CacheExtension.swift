//
//  UIImage+CacheExtension.swift
//  MoviesDarkFriend
//
//  Created by Andreas Demenagas on 9/6/19.
//  Copyright © 2019 Andreas Demenagas. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImageFromCacheOrDownload(urlString: String) {
        
        self.image = nil
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Error on dataTask", error!)
                return
            }
            
            DispatchQueue.main.async {
                guard let data = data else {return}
                if let downloadedImage = UIImage(data: data) {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    self.image = downloadedImage
                }
            }
            
        }.resume()
    }
}
