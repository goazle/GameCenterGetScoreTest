//
//  GameCenterGetScoreViewModel.swift
//  GameCenterGetScoreTest
//
//  Created by goazle on 2022/06/02.
//

import GameKit

class GameCenterGetScoreViewModel: ObservableObject {

    // score(load when tap the button)
    @Published private(set) var manualLoadScore = Score()

    // score(automatically loaded after logging into GameCenter)
    @Published private(set) var autoLoadScore = Score()

    init() {
        // add notification observer. After change GameCenter auth status, works using block
        NotificationCenter.default.addObserver(
            forName: .GKPlayerAuthenticationDidChangeNotificationName,
            object: nil,
            queue: OperationQueue.main,
            using: { _ in
                // this block is called whether authentication succeeds or fails.
                self.authenticationChanged()
            }
        )
    }

    private func authenticationChanged() {
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
                                if let entries = entries,
                                   entries.isEmpty == false {
                                    self.autoLoadScore.worldScore = entries[0].score
                                }
                                // If local is loaded, set the value to yourHighScore
                                if let local = local {
                                    self.autoLoadScore.yourScore = local.score
                                }
                            })
                        }
                    }
                }
            })
        }
    }

    func buttonTapped() {
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
                                if let entries = entries,
                                   entries.isEmpty == false {
                                    self.manualLoadScore.worldScore = entries[0].score
                                }
                                // If local is loaded, set the value to yourHighScore
                                if let local = local {
                                    self.manualLoadScore.yourScore = local.score
                                }
                            })
                        }
                    }
                }
            })
        }
    }

}
