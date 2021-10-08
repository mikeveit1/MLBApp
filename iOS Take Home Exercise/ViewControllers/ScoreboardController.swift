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
    
    @IBOutlet weak var logoNavigationBar: UINavigationBar!
    @IBOutlet weak var dateNavigationBar: UINavigationBar!
    @IBOutlet weak var dateItemLeft: UIBarButtonItem!
    @IBOutlet weak var dateItemRight: UIBarButtonItem!
    @IBOutlet weak var scoreboardTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    private func setUpViews() {
        configureView()
        configureLogoNavigationBar()
        configureDateNavigationBar()
        configureScoreboardTable() 
    }
    
    private func configureView() {
        view.backgroundColor = Colors.backgroundColor
    }
    
    private func configureLogoNavigationBar() {
        let logo: UIImage = UIImage(named: "mlblogo")!
        let logoView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        logoView.contentMode = .scaleAspectFit
        logoView.image = logo
        logoNavigationBar.topItem?.titleView = logoView
        logoNavigationBar.isTranslucent = false
        logoNavigationBar.barTintColor = Colors.backgroundColor
    }
    
    private func configureDateNavigationBar() {
        let formatter = DateFormatter()
        #warning("make month and day bold")
        formatter.dateFormat = "EEEE MMMM d"
        dateNavigationBar.topItem?.title = formatter.string(from: Date())
        dateNavigationBar.isTranslucent = false
        dateNavigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : Colors.textColor]
        dateNavigationBar.barTintColor = Colors.backgroundColor
        dateNavigationBar.layer.borderWidth = 1.0
        dateNavigationBar.layer.borderColor = Colors.separatorColor.cgColor
        configureDateNavigationItems(item: dateItemLeft, left: true)
        configureDateNavigationItems(item: dateItemRight, left: false)
    }
    
    private func configureDateNavigationItems(item: UIBarButtonItem, left: Bool) {
        var image = UIImage()
        if left {
            image = UIImage(systemName: "chevron.left")!
        } else {
            image = UIImage(systemName: "chevron.right")!
        }
        item.image = image
        
        item.tintColor = Colors.separatorColor
    }
    
    private func configureScoreboardTable() {
        scoreboardTable.delegate = self
        scoreboardTable.dataSource = self
        scoreboardTable.backgroundColor = Colors.backgroundColor
        scoreboardTable.separatorColor = Colors.separatorColor
        scoreboardTable.rowHeight = UITableView.automaticDimension
    }
    
    @IBAction func dateItemLeftPressed(_ sender: Any) {
        print("left item pressed")
        #warning("this will go to the previous date and refresh table")
    }
    
    @IBAction func dateItemRightPressed(_ sender: Any) {
        print("right item pressed")
        #warning("this will go to the next date and refresh table")
    }
    
}

extension ScoreboardController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreboardCell") as! ScoreboardCell
        
        return cell
    }
}

