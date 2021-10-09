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
    @IBOutlet weak var tabBar: UITabBar!
    private let datePicker : UIDatePicker = UIDatePicker()
    private let dateFormatter = DateFormatter()
    public var currentDate: Date = Date()
    public var dates: [GameDate] = []
    public var scores: [ScoreDisplay] = []
    private var totalGames: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        getData()
        mapDataToScores()
    }
    
    private func getData() {
        DataService.shared.getData() { (data) in
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(Response.self, from: data)
                self.dates.append(contentsOf: json.dates)
            } catch {
                DispatchQueue.main.async {
                    self.showErrorAlert(title: "Error", message: error.localizedDescription)
                }
            }
        } errorHandler: {(error: Error) -> () in
            print(error.localizedDescription)
            showErrorAlert(title: "Error", message: error.localizedDescription)
        }
    }
    
    private func mapDataToScores() {
        for date in dates {
            var score = ScoreDisplay(awayTeamName: "", awayTeamRecord: "", homeTeamName: "", homeTeamRecord: "", awayTeamScore: 0, homeTeamScore: 0, inning: 0, gameState: "", scheduledInnings: 0)
           /* for game in date.games {
                for status in game.status {
                    score.gameState = status.detailedState
                }
                for team in game.teams {
                    for away in team.awayTeam {
                        for record in away.leagueRecords {
                            score.awayTeamRecord = "\(record.wins)-\(record.losses)"
                        }
                        for team in away.team {
                            score.awayTeamName = team.teamName
                        }
                    }
                    for home in team.homeTeam {
                        for record in home.leagueRecords {
                            score.homeTeamRecord = "\(record.wins)-\(record.losses)"
                        }
                        for team in home.team {
                            score.awayTeamName = team.teamName
                        }
                    }
                }
                for linescore in game.linescore {
                    score.inning =  linescore.currentInning
                    score.scheduledInnings = linescore.scheduledInnings
                    for team in linescore.linescoreTeams {
                        for home in team.home {
                            score.homeTeamScore = home.runs
                        }
                        for away in team.away {
                            score.awayTeamScore = away.runs
                        }
                    }
                }
            }
            scores.append(score) */
        }
    }
    
    private func setUpViews() {
        configureView()
        configureLogoNavigationBar()
        configureDateNavigationBar()
        configureScoreboardTable()
        configureTabBar()
    }
    
    private func configureView() {
        view.backgroundColor = Colors.backgroundColor
    }
    
    private func configureDateFormatter() {
        // dateFormatter.dateFormat = "EEEE MMMM d"
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
        #warning("make month and day bold")
        dateFormatter.dateFormat = "EEEE MMMM d"
        dateNavigationBar.topItem?.title = dateFormatter.string(from: currentDate)
        dateNavigationBar.isTranslucent = false
        dateNavigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : Colors.textColor]
        dateNavigationBar.barTintColor = Colors.backgroundColor
        dateNavigationBar.layer.borderWidth = 1.0
        dateNavigationBar.layer.borderColor = Colors.separatorColor.cgColor
        configureDateNavigationItems(item: dateItemLeft, left: true)
        configureDateNavigationItems(item: dateItemRight, left: false)
        configureDatePicker()
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
    
    private func configureDatePicker() {
        self.view.addSubview(datePicker)
        datePicker.isHidden = true
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.backgroundColor = Colors.textColor
        datePicker.tintColor = Colors.separatorColor
        datePicker.layer.cornerRadius = 18
        datePicker.clipsToBounds = true
        datePicker.addTarget(self, action: #selector(dateChanged(sender:)), for: .valueChanged)
        let pickerSize : CGSize = datePicker.sizeThatFits(CGSize.zero)
        #warning("optimize this")
        datePicker.frame = CGRect(x: 0, y: dateNavigationBar.frame.maxY + 20, width: pickerSize.width, height: pickerSize.height)
        datePicker.center.x = dateNavigationBar.center.x
    }
    
    private func configureScoreboardTable() {
        scoreboardTable.delegate = self
        scoreboardTable.dataSource = self
        scoreboardTable.backgroundColor = Colors.backgroundColor
        scoreboardTable.separatorColor = Colors.separatorColor
        scoreboardTable.rowHeight = UITableView.automaticDimension
    }
    
    private func configureTabBar() {
        tabBar.items = [UITabBarItem(title: "Scores", image: nil, tag: 0)]
        tabBar.selectedItem = tabBar.items?.first
        tabBar.barTintColor = Colors.backgroundColor
        tabBar.tintColor = Colors.mlbBlue
    }
    
    @objc func datePressed() {
        if datePicker.isHidden {
            datePicker.isHidden = false
        } else {
            datePicker.isHidden = true
        }
    }
    
    @objc func dateChanged(sender: UIDatePicker) {
        currentDate = sender.date
        configureDateNavigationBar()
        scoreboardTable.reloadData()
    }
    
    @IBAction func dateNavigationBarPressed(_ sender: Any) {
        datePressed()
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
        return totalGames
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreboardCell") as! ScoreboardCell
        cell.setData(scores: scores[indexPath.row])
        return cell
    }
}

