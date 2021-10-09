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
    public var filteredScores: [ScoreDisplay] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getData()
        mapDataToScores()
        configureDateNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
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
        var score = ScoreDisplay(gameDate: Date(), awayTeamName: "", awayTeamRecord: "", homeTeamName: "", homeTeamRecord: "", awayTeamScore: 0, homeTeamScore: 0, inning: 0, gameState: "", scheduledInnings: 0)
        for date in dates {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            score.gameDate = dateFormatter.date(from: date.date)!
            currentDate = score.gameDate
            for game in date.games {
                score.awayTeamName = game.teams.away.team.teamName
                score.awayTeamScore = game.linescore.teams.away.runs
                score.awayTeamRecord = "\(game.teams.away.leagueRecord.wins) - \(game.teams.away.leagueRecord.losses)"
                score.homeTeamName = game.teams.home.team.teamName
                score.homeTeamScore = game.linescore.teams.home.runs
                score.homeTeamRecord = "\(game.teams.home.leagueRecord.wins) - \(game.teams.home.leagueRecord.losses)"
                score.inning = game.linescore.currentInning
                score.gameState = game.status.detailedState
                score.scheduledInnings = game.linescore.scheduledInnings
                scores.append(score)
            }
        }
        filteredScores.append(contentsOf: scores)
    }

    private func setUpViews() {
        configureView()
        configureLogoNavigationBar()
        configureScoreboardTable()
        configureTabBar()
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
        datePicker.date = currentDate
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
    
    private func incrementDate(increment: Int, date: Date?) {
        if date == nil {
            currentDate = Calendar.current.date(byAdding: .day, value: increment, to: currentDate)!
        } else {
            currentDate = date!
        }
        configureDateNavigationBar()
        filteredScores = scores.filter({$0.gameDate == currentDate})
        scoreboardTable.reloadData()
    }
    
    @objc func handleDatePicker() {
        if datePicker.isHidden {
            datePicker.isHidden = false
        } else {
            datePicker.isHidden = true
        }
    }
    
    @objc func dateChanged(sender: UIDatePicker) {
        incrementDate(increment: 0, date: sender.date)
    }
    
    @IBAction func dateNavigationBarPressed(_ sender: Any) {
        handleDatePicker()
    }
    
    @IBAction func dateItemLeftPressed(_ sender: Any) {
        incrementDate(increment: -1, date: nil)
    }
    
    @IBAction func dateItemRightPressed(_ sender: Any) {
        incrementDate(increment: 1, date: nil)
    }
}

extension ScoreboardController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        #warning("should i put his condition in a variable? doesnt work when i try")
        if filteredScores.count > 0 {
            return filteredScores.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreboardCell") as! ScoreboardCell
        if filteredScores.count > 0 {
            cell.setData(score: filteredScores[indexPath.row])
            scoreboardTable.separatorStyle  = .singleLine
        } else {
            scoreboardTable.separatorStyle  = .none
            cell.handleNoScheduledGames(hideLabels: true)
        }
        return cell
    }
}

