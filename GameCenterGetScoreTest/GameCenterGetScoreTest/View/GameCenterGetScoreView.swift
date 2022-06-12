//
//  GameCenterGetScoreView.swift
//  GameCenterGetScoreTest
//
//  Created by goazle on 2022/06/01.
//

import SwiftUI

struct GameCenterGetScoreView: View {

    @ObservedObject private var viewModel = GameCenterGetScoreViewModel()

    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("After logging into GameCenter, the latest scores are automatically loaded.").font(.caption)
                Text("WorldScore : \(viewModel.autoLoadScore.worldScore)")
                Text("myScore : \(viewModel.autoLoadScore.yourScore)")
            }.padding()
            .border(.blue, width: 1.0)

            VStack {
                Text("Tap the button to load the latest score if you are already logged in to GameCenter.").font(.caption)
                Button {
                    viewModel.buttonTapped()
                } label: {
                    Text("Load Score")
                }
                .buttonStyle(.borderedProminent)
                // Text("Load latest scores if you are logged into GameCenter.").font(.caption)
                Text("WorldScore : \(viewModel.manualLoadScore.worldScore)")
                Text("myScore : \(viewModel.manualLoadScore.yourScore)")
            }.padding()
            .border(.blue, width: 1.0)

            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameCenterGetScoreView()
    }
}
