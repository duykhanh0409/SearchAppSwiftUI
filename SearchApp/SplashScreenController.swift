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
    
    // MARK: - Properties
    
    /// Callback to handle navigation to movies screen
    var onNavigateToMovies: (() -> Void)?
    
    // MARK: - UI Components
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var navigateButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Movies"
        config.image = UIImage(systemName: "film.fill")
        config.imagePlacement = .leading
        config.imagePadding = 8
        config.cornerStyle = .medium
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        
        let button = UIButton(configuration: config)
        button.addTarget(self, action: #selector(navigateButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var bannerImageView: UIImageView = {
        let object = UIImageView()
        object.image = UIImage(named: "Banner")
        object.contentMode = .scaleToFill
        return object
    }()
    
    let titleLable: UILabel = {
        let object = UILabel()
        object.font = UIFont.systemFont(ofSize: 44, weight: .bold)
        object.textAlignment = .center
        object.numberOfLines = 0
        return object
    }()
    
    let descriptionLable: UILabel = {
        let object = UILabel()
        object.font = .systemFont(ofSize: 14)
        object.textAlignment = .center
        object.numberOfLines = 0
        object.textColor = .secondaryLabel
        return object
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Setup Methods
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Add subviews
        view.addSubview(headerView)
        headerView.addSubview(navigateButton)
        view.addSubview(bannerImageView)
        view.addSubview(titleLable)
        view.addSubview(descriptionLable)
        
        // Set sample content
        titleLable.text = "Welcome to SearchApp"
        descriptionLable.text = "Discover amazing movies and more"
    }
    
    private func setupConstraints() {
        // Header View Constraints
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        // Navigate Button Constraints (Top Right)
        navigateButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        // Banner Image Constraints
        bannerImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(64)
            make.width.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        
        // Title Label Constraints
        titleLable.snp.makeConstraints { make in
            make.top.equalTo(bannerImageView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        // Description Label Constraints
        descriptionLable.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    // MARK: - Actions
    
    @objc private func navigateButtonTapped() {
        print("Navigate button tapped!")
        onNavigateToMovies?()
    }
}
