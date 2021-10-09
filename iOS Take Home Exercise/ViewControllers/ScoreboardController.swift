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
    @IBOutlet weak var datePicker: UIDatePicker!
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
        var score = ScoreDisplay(officialDate: Date(), gameDate: Date(), awayTeamName: "", awayTeamRecord: "", homeTeamName: "", homeTeamRecord: "", awayTeamScore: 0, homeTeamScore: 0, inning: 0, inningOrdinal: "0", inningHalf: "Top", gameState: "", scheduledInnings: 0)
        for date in dates {
            dateFormatter.dateFormat = officialDateFormat
            score.officialDate = dateFormatter.date(from: date.date)!
            currentDate = score.officialDate
            for game in date.games {
                dateFormatter.dateFormat = gameDateFormat
                score.gameDate = dateFormatter.date(from: game.gameDate)!
                score.awayTeamName = game.teams.away.team.teamName
                score.awayTeamScore = game.linescore.teams.away.runs
                score.awayTeamRecord = "\(game.teams.away.leagueRecord.wins) - \(game.teams.away.leagueRecord.losses)"
                score.homeTeamName = game.teams.home.team.teamName
                score.homeTeamScore = game.linescore.teams.home.runs
                score.homeTeamRecord = "\(game.teams.home.leagueRecord.wins) - \(game.teams.home.leagueRecord.losses)"
                score.inning = game.linescore.currentInning
                score.inningOrdinal = game.linescore.currentInningOrdinal
                score.inningHalf = game.linescore.inningHalf
                score.gameState = game.status.detailedState
                score.scheduledInnings = game.linescore.scheduledInnings
                scores.append(score)
            }
        }
        addTestCases()
        filteredScores.append(contentsOf: scores.sorted(by: {$0.gameDate < $1.gameDate}))
    }
    
    private func addTestCases() {
        #warning("am i keeping this?")
        //Using this function to show different game state cases
        let gameDateFormatter = DateFormatter()
        gameDateFormatter.dateFormat = gameDateFormat
        let gameDate = gameDateFormatter.date(from: "2018-09-20T17:10:00Z")!
        let awayTeam = "Nationals"
        let homeTeam = "Marlins"
        let awayTeamRecord = "75-77"
        let homeTeamRecord = "61-92"
        let scheduledInnings = 9
        let cases = [
        ScoreDisplay(officialDate: currentDate, gameDate: gameDate, awayTeamName: awayTeam, awayTeamRecord: awayTeamRecord, homeTeamName: homeTeam, homeTeamRecord: homeTeamRecord, awayTeamScore: 5, homeTeamScore: 2, inning: 7, inningOrdinal: "7th", inningHalf: "Top", gameState: "In_Progress", scheduledInnings: scheduledInnings),
        ScoreDisplay(officialDate: currentDate, gameDate: gameDate, awayTeamName: awayTeam, awayTeamRecord: awayTeamRecord, homeTeamName: homeTeam, homeTeamRecord: homeTeamRecord, awayTeamScore: 0, homeTeamScore: 0, inning: 0, inningOrdinal: "", inningHalf: "", gameState: "Not_Started", scheduledInnings: scheduledInnings),
        ScoreDisplay(officialDate: currentDate, gameDate: gameDate, awayTeamName: awayTeam, awayTeamRecord: awayTeamRecord, homeTeamName: homeTeam, homeTeamRecord: homeTeamRecord, awayTeamScore: 1, homeTeamScore: 0, inning: 10, inningOrdinal: "10th", inningHalf: "Bottom", gameState: "Final", scheduledInnings: scheduledInnings),
        ScoreDisplay(officialDate: currentDate, gameDate: gameDate, awayTeamName: awayTeam, awayTeamRecord: awayTeamRecord, homeTeamName: homeTeam, homeTeamRecord: homeTeamRecord, awayTeamScore: 2, homeTeamScore: 4, inning: 7, inningOrdinal: "7th", inningHalf: "Bottom", gameState: "Final", scheduledInnings: scheduledInnings)
            ]
        scores.append(contentsOf: cases)
    }

    private func setUpViews() {
        configureView()
        configureLogoNavigationBar()
        configureScoreboardTable()
        configureTabBar()
        configureGestureRecognizers()
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
        let dateLabel = UILabel()
        dateLabel.textColor = Colors.textColor
        dateFormatter.dateFormat = dayOfWeekFormat
        let dayOfWeekString = dateFormatter.string(from: currentDate)
        dateFormatter.dateFormat = monthDayFormat
        let monthDayString = dateFormatter.string(from: currentDate)
        let currentDateString = "\(dayOfWeekString) \(monthDayString)"
        dateLabel.attributedText = formatAttributedString(string: currentDateString, range: monthDayString, attributes: [NSAttributedString.Key.font: Fonts.mediumFontBold])
        dateNavigationBar.topItem?.titleView = dateLabel
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
        view.bringSubviewToFront(datePicker)
        datePicker.date = currentDate
        datePicker.isHidden = true
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.overrideUserInterfaceStyle = .dark
        datePicker.backgroundColor = Colors.textColor
        datePicker.tintColor = Colors.separatorColor
        datePicker.layer.cornerRadius = 18
        datePicker.clipsToBounds = true
        datePicker.addTarget(self, action: #selector(dateChanged(sender:)), for: .valueChanged)
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
    
    private func configureGestureRecognizers() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(dateItemLeftPressed(_:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(dateItemRightPressed(_:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        let handlePicker = UITapGestureRecognizer(target: self, action: #selector(handleDatePicker))
        let closePicker = UITapGestureRecognizer(target: self, action: #selector(hideDatePicker))
        dateNavigationBar.addGestureRecognizer(handlePicker)
        scoreboardTable.addGestureRecognizer(closePicker)
    }
    
    private func incrementDate(increment: Int, date: Date?) {
        if date == nil {
            currentDate = Calendar.current.date(byAdding: .day, value: increment, to: currentDate)!
        } else {
            currentDate = date!
        }
        configureDateNavigationBar()
        filteredScores = scores.filter({$0.officialDate == currentDate})
        scoreboardTable.reloadData()
    }
    
    @objc func handleDatePicker() {
        print("date picker hidden", datePicker.isHidden)
        if datePicker.isHidden {
            datePicker.isHidden = false
        } else {
            datePicker.isHidden = true
        }
    }
    
    @objc func hideDatePicker() {
        datePicker.isHidden = true
    }
    
    @objc func dateChanged(sender: UIDatePicker) {
        incrementDate(increment: 0, date: sender.date)
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
        #warning("should i put his condition in a variable? doesnt work when i try...maybe an enum?")
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
