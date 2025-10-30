//
//  ViewController.swift
//  SearchApp
//
//  Created by Khanh Nguyen on 22/10/25.
//

import Foundation
import UIKit
import SnapKit

class SplashScreenController: UIViewController {
    
    var bannerImageView: UIImageView = {
        let object = UIImageView()
        object.image = UIImage(named: "banner")
        object.contentMode = .scaleAspectFit
        return object
    }()
    
    let titleLable: UILabel = {
        let object = UILabel()
        object.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        
        return object
    }()
    
    let descriptionLable:UILabel = {
        let object = UILabel()
        object.font = .systemFont(ofSize: 14)
        
        return object
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerImageView
    }
}
