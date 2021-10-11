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
    public var sortedScores: [ScoreDisplay] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        mapDataToScores()
        configureDateNavigationBar()
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
        var score = ScoreDisplay(officialDate: Date(), gamePk: 0, gameDate: Date(), awayTeamName: "", awayTeamAbbreviation: "", awayTeamRecord: "", homeTeamName: "", homeTeamAbbreviation: "", homeTeamRecord: "", awayTeamRuns: 0, awayTeamHits: 0, awayTeamErrors: 0, homeTeamRuns: 0, homeTeamHits: 0, homeTeamErrors: 0, inning: 0, inningOrdinal: "0", inningHalf: "Top", gameState: "", scheduledInnings: 0, venueName: "", venueCity: "", venueState: "", innings: [Inning(num: 0, home: InningTeam(runs: 0), away: InningTeam(runs: 0))])
        for date in dates {
            dateFormatter.dateFormat = officialDateFormat
            score.officialDate = dateFormatter.date(from: date.date)!
            currentDate = score.officialDate
            for game in date.games {
                dateFormatter.dateFormat = gameDateFormat
                score.gamePk = game.gamePk
                score.gameDate = dateFormatter.date(from: game.gameDate)!
                score.awayTeamName = game.teams.away.team.teamName
                score.awayTeamAbbreviation = game.teams.away.team.abbreviation
                score.awayTeamRuns = game.linescore.teams.away.runs
                score.awayTeamHits = game.linescore.teams.away.hits
                score.awayTeamErrors = game.linescore.teams.away.errors
                score.awayTeamRecord = "\(game.teams.away.leagueRecord.wins) - \(game.teams.away.leagueRecord.losses)"
                score.homeTeamName = game.teams.home.team.teamName
                score.homeTeamAbbreviation = game.teams.home.team.abbreviation
                score.homeTeamRuns = game.linescore.teams.home.runs
                score.homeTeamHits = game.linescore.teams.home.hits
                score.homeTeamErrors = game.linescore.teams.home.errors
                score.homeTeamRecord = "\(game.teams.home.leagueRecord.wins) - \(game.teams.home.leagueRecord.losses)"
                score.inning = game.linescore.currentInning
                score.inningOrdinal = game.linescore.currentInningOrdinal
                score.inningHalf = game.linescore.inningHalf
                score.gameState = game.status.detailedState
                score.scheduledInnings = game.linescore.scheduledInnings
                score.venueName = game.venue.name
                score.venueCity = game.venue.location.city
                score.venueState = game.venue.location.state
                score.innings = game.linescore.innings
                scores.append(score)
            }
        }
        addTestCases()
        sortedScores.append(contentsOf: scores.sorted(by: {$0.gameDate < $1.gameDate}))
    }
    
    private func addTestCases() {
        //Using this function to show different game state cases
        let gameDateFormatter = DateFormatter()
        gameDateFormatter.dateFormat = gameDateFormat
        let gameDate = gameDateFormatter.date(from: "2018-09-20T23:10:00Z")!
        let awayTeam = "Nationals"
        let awayTeamAbbreviation = "WAS"
        let homeTeam = "Marlins"
        let homeTeamAbbreviation = "MIA"
        let venueName = "LoanDepot Park"
        let venueCity = "Miami"
        let venueState = "Florida"
        let awayTeamRecord = "75-77"
        let homeTeamRecord = "61-92"
        let scheduledInnings = 9
        let nineInnings = getTestInnings(lastInning: 9)
        let tenInnings = getTestInnings(lastInning: 10)
        let sevenInnings = getTestInnings(lastInning: 7)
        let cases = [
            ScoreDisplay(officialDate: currentDate, gamePk: 0, gameDate: gameDate, awayTeamName: awayTeam, awayTeamAbbreviation: awayTeamAbbreviation, awayTeamRecord: awayTeamRecord, homeTeamName: homeTeam, homeTeamAbbreviation: homeTeamAbbreviation, homeTeamRecord: homeTeamRecord, awayTeamRuns: 1, awayTeamHits: 1, awayTeamErrors: 0, homeTeamRuns: 0, homeTeamHits: 0, homeTeamErrors: 0, inning: 10, inningOrdinal: "10th", inningHalf: "Bottom", gameState: "Final", scheduledInnings: scheduledInnings, venueName: venueName, venueCity: venueCity, venueState: venueState, innings: tenInnings),
            ScoreDisplay(officialDate: currentDate, gamePk: 1, gameDate: gameDate, awayTeamName: awayTeam, awayTeamAbbreviation: awayTeamAbbreviation, awayTeamRecord: awayTeamRecord, homeTeamName: homeTeam, homeTeamAbbreviation: homeTeamAbbreviation, homeTeamRecord: homeTeamRecord, awayTeamRuns: 5,awayTeamHits: 1, awayTeamErrors: 0, homeTeamRuns: 0, homeTeamHits: 0, homeTeamErrors: 0, inning: 7, inningOrdinal: "7th", inningHalf: "Top", gameState: "In_Progress", scheduledInnings: scheduledInnings, venueName: venueName, venueCity: venueCity, venueState: venueState, innings: nineInnings),
            ScoreDisplay(officialDate: currentDate, gamePk: 2, gameDate: gameDate, awayTeamName: awayTeam,  awayTeamAbbreviation: awayTeamAbbreviation, awayTeamRecord: awayTeamRecord, homeTeamName: homeTeam, homeTeamAbbreviation: homeTeamAbbreviation, homeTeamRecord: homeTeamRecord, awayTeamRuns: 2, awayTeamHits: 1, awayTeamErrors: 0, homeTeamRuns: 0, homeTeamHits: 0, homeTeamErrors: 0, inning: 7, inningOrdinal: "7th", inningHalf: "Bottom", gameState: "Final", scheduledInnings: scheduledInnings, venueName: venueName, venueCity: venueCity, venueState: venueState, innings: sevenInnings),
            ScoreDisplay(officialDate: currentDate, gamePk: 3, gameDate: gameDate, awayTeamName: awayTeam, awayTeamAbbreviation: awayTeamAbbreviation, awayTeamRecord: awayTeamRecord, homeTeamName: homeTeam, homeTeamAbbreviation: homeTeamAbbreviation, homeTeamRecord: homeTeamRecord, awayTeamRuns: 0, awayTeamHits: 0, awayTeamErrors: 0, homeTeamRuns: 0, homeTeamHits: 0, homeTeamErrors: 0, inning: 0, inningOrdinal: "", inningHalf: "", gameState: "Not_Started", scheduledInnings: scheduledInnings, venueName: venueName, venueCity: venueCity, venueState: venueState, innings: nineInnings)
        ]
        scores.append(contentsOf: cases)
    }
    
    private func getTestInnings(lastInning: Int) -> [Inning] {
        var array = [Inning]()
        for number in 1...lastInning {
            let inning = Inning(num: number, home: InningTeam(runs: 0), away: InningTeam(runs: 0))
            array.append(inning)
        }
       return array
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
        let logoView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        logoView.contentMode = .scaleAspectFit
        logoView.image = UIImage(named: "mlblogo")!
        logoNavigationBar.topItem?.titleView = logoView
        logoNavigationBar.isTranslucent = false
        logoNavigationBar.barTintColor = Colors.backgroundColor
    }
    
    private func configureDateNavigationBar() {
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
        dateNavigationBar.layer.borderWidth = borderWidth
        dateNavigationBar.layer.borderColor = Colors.separatorColor.cgColor
        configureDateNavigationItems(item: dateItemLeft, left: true)
        configureDateNavigationItems(item: dateItemRight, left: false)
        configureDatePicker()
    }
    
    private func configureDateNavigationItems(item: UIBarButtonItem, left: Bool) {
        var image = UIImage()
        if left {
            image = backImage
        } else {
            image = forwardImage
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
        datePicker.layer.cornerRadius = cornerRadiusValue
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
        #warning("come back to this")
        let closePicker = UITapGestureRecognizer(target: self, action: #selector(hideDatePicker))
        dateNavigationBar.addGestureRecognizer(handlePicker)
      //  scoreboardTable.addGestureRecognizer(closePicker)
    }
    
    private func incrementDate(increment: Int, date: Date?) {
        if date == nil {
            currentDate = Calendar.current.date(byAdding: .day, value: increment, to: currentDate)!
        } else {
            currentDate = date!
        }
        configureDateNavigationBar()
        sortedScores = scores.filter({$0.officialDate == currentDate})
        scoreboardTable.reloadData()
    }
    
    @objc func handleDatePicker() {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let indexPath = self.scoreboardTable.indexPathForSelectedRow {
                let controller = segue.destination as! DetailedGameViewController
                controller.score = sortedScores[indexPath.row]
            }
        }
    }
}

extension ScoreboardController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        #warning("should i put his condition in a variable? doesnt work when i try...maybe an enum?")
        if sortedScores.count > 0 {
            return sortedScores.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreboardCell") as! ScoreboardCell
        if sortedScores.count > 0 {
            cell.setData(score: sortedScores[indexPath.row])
            scoreboardTable.separatorStyle  = .singleLine
        } else {
            scoreboardTable.separatorStyle  = .none
            cell.handleNoScheduledGames(hideLabels: true)
        }
        return cell
    }
}
