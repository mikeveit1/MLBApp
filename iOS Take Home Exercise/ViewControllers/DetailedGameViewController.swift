//
//  DetailedGameViewController.swift
//  iOS Take Home Exercise
//
//  Created by Michael Veit on 10/10/21.
//  Copyright © 2021 Lewanda, David. All rights reserved.
//

import UIKit

class DetailedGameViewController: UIViewController {

    @IBOutlet weak var detailedGameView: DetailedGameView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var backButton: UIBarButtonItem!
    public var score: ScoreDisplay!
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        view.backgroundColor = Colors.backgroundColor
        detailedGameView.setData(score: score)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
    }
    
    private func configureNavBar() {
        navigationBar.isTranslucent = true
        navigationBar.barTintColor = Colors.backgroundColor
        navigationBar.tintColor = Colors.textColor
        configureBackButton()
    }
    
    private func configureBackButton() {
        backButton.tintColor = Colors.textColor
        backButton.image = backImage
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
