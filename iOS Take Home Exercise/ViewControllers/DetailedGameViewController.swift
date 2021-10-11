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
    public var score: ScoreDisplay!
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        view.backgroundColor = Colors.backgroundColor
        detailedGameView.setData(score: score)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
