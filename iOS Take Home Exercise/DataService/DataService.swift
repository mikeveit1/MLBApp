//
//  DataService.swift
//  iOS Take Home Exercise
//
//  Created by Michael Veit on 10/8/21.
//  Copyright © 2021 Lewanda, David. All rights reserved.
//

import Foundation

class DataService {
    static let shared = DataService()
    
    public func getData(date: String, completion: (Data) -> Void, errorHandler: (Error) -> Void) {
        guard let url =  URL(string: "https://statsapi.mlb.com/api/v1/schedule?hydrate=team(league),venue(location,timezone),linescore&date=\(date)&sportId=1,51&language=en") else { return }
        do {
            let data = try Data(contentsOf: url)
            completion(data)
        } catch {
            errorHandler(error)
        }
    }
}
