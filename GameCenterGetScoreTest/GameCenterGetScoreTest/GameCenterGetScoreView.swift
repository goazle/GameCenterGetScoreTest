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
                Button {
                    viewModel.loadScore()
                } label: {
                    Text("Load Score")
                }
                .buttonStyle(.borderedProminent)
                Text("Load latest scores if you are logged into GameCenter.").font(.caption)
            }.padding()

            Text("WorldScore : \(viewModel.worldHighScore)")
            Text("myScore : \(viewModel.yourHighScore)")
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameCenterGetScoreView()
    }
}
