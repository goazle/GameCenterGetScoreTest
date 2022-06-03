//
//  GameCenterHelper.swift
//  GameCenterGetScoreTest
//
//  Created by goazle on 2022/06/01.
//

import GameKit

struct GameCenterHelper {

    static func loginGameCenter() {
        GKLocalPlayer.local.authenticateHandler = { _, error in
            if error != nil {
                print("You are not logged into GameCenter.")
                print(error.debugDescription)
            } else if GKLocalPlayer.local.isAuthenticated {
                print("You are logged into GameCenter.")
            }
        }
    }
}
