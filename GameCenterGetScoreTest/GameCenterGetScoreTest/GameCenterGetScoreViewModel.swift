//
//  GameCenterGetScoreViewModel.swift
//  GameCenterGetScoreTest
//
//  Created by goazle on 2022/06/02.
//

import GameKit

class GameCenterGetScoreViewModel: ObservableObject {

    // World score
    @Published private(set) var worldHighScore = 0
    // Your score
    @Published private(set) var yourHighScore = 0

    func loadScore() {
        print("load scores from Loaderboarder.")
        if GKLocalPlayer.local.isAuthenticated {
            print("You are logged in. Start to load scores from Game Center.")
            // Get the Leaderboard ID of this app that you have previously registered in App Store Connect
            // (only one ID is registered here).
            GKLocalPlayer.local.loadDefaultLeaderboardIdentifier(completionHandler: { (leaderboardIdentifer, error) in
                if error != nil { // Error occured
                    print(error!.localizedDescription)
                } else { // Got the loaderBoarderIdentifier for this app.
                    // Load scores
                    if let leaderboarderId = leaderboardIdentifer {
                        print("Default leaderboardIdentifer is \(leaderboarderId).")
                        GKLeaderboard.loadLeaderboards(IDs: [leaderboarderId]) { (boards, _) in
                            boards?.first?.loadEntries(for: .global, timeScope: .allTime, range: NSRange(location: 1, length: 1), completionHandler: {(local, entries, _, _) in
                                // If entries are loaded, set the value to worldHighScore
                                if let entries = entries {
                                    self.worldHighScore = entries[0].score
                                }
                                // If local is loaded, set the value to yourHighScore
                                if let local = local {
                                    self.yourHighScore = local.score
                                }
                            })
                        }
                    }
                }
            })
        } else {
            // If you are not logged into GameCenter, displayed scores is set to zero.
            self.worldHighScore = 0
            self.yourHighScore = 0
        }
    }

}
