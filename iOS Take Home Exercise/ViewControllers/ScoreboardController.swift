//
//  ViewController.swift
//  iOS Take Home Exercise
//
//  Created by Lewanda, David on 1/25/19.
//  Copyright © 2019 Lewanda, David. All rights reserved.
//

import UIKit
import Foundation

class ScoreboardController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    private var backgroundColor: UIColor = .white
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    private func setUpViews() {
        configureNavigationBar()
        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = backgroundColor
    }
    
    private func configureNavigationBar() {
        let logo: UIImage = UIImage(named: "mlblogo")!
        let logoView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        logoView.contentMode = .scaleAspectFit
        logoView.image = logo
        navigationBar.topItem?.titleView = logoView
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = backgroundColor
    }
    
}

