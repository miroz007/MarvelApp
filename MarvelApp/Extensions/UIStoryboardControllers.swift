//
//  UIStoryboard+Controllers.swift
//  MovieApp
//
//  Created by Amir Samir on 12/11/18.
//  Copyright © 2018 Amir Samir. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIStoryboard {
    
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }

}


extension UIStoryboard {
    
    var homeVC: HomeVC {
        guard let viewController = instantiateViewController(withIdentifier: String(describing: HomeVC.self)) as? HomeVC else {
            fatalError(String(describing: HomeVC.self) + "\(NSLocalizedString("couldn't be found in Storyboard file", comment: ""))")
        }
        return viewController
    }
    

    
    
    
    
}


extension UIImageView {
    
    public func downloadImageWithCaching(with url: String,placeholderImage: UIImage? = nil){
        if url == ""{
            self.image = placeholderImage
            return
        }
        guard let imageURL = URL.init(string: url) else{
            self.image = placeholderImage
            return
        }
        self.kf.setImage(with: imageURL, placeholder: placeholderImage, options: [.transition(.fade(0.1))], progressBlock: nil, completionHandler: { (image, error, cacheType, _url) in
            //self.image = image
        })
    }
    
}
