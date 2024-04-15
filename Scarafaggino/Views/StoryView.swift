//
//  StoryView.swift
//  Scarafaggino
//
//  Created by sara hu lihua on 17/12/23.
//



import SwiftUI
import AVKit

struct StoryView: View {
    @Binding var currentGameState: GameState
    @AppStorage("usedcount") var usedcount = false

    var body: some View {
        ZStack {
            
            // Visualizza il video
            VideoPlayer(player: AVPlayer(url: Bundle.main.url(forResource: "scarafaggioStory", withExtension: "mp4")!)) {
                // Puoi personalizzare l'aspetto del video player qui
            }
            .edgesIgnoringSafeArea(.all)
            
            .onAppear {
                NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: nil, queue: .main) { _ in
                    backToMainScreen()
                }
            }
            // Alcuni altri elementi sovrapposti, come il pulsante Back
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        backToMainScreen()
                        usedcount = true
                    }) {
                        HStack {
                            Image("backButton1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            
                        }
                    }
                    .position(CGPoint(x: 30, y: 15.0))
                }
            }
        }
    }

    private func backToMainScreen() {
        // Aggiorna lo stato per tornare alla schermata principale
        self.currentGameState = .mainScreen
        usedcount = true
    }
}

#Preview {
    StoryView(currentGameState: .constant(GameState.story))
}



//
//import SwiftUI
//import AVKit
//
//struct StoryView: View {
//    @Binding var currentGameState: GameState
//
//    var body: some View {
//        ZStack {
//            // Visualizza il video
//            VideoPlayer(player: AVPlayer(url: Bundle.main.url(forResource: "scarafaggioStory", withExtension: "mp4")!)) {
//                // Puoi personalizzare l'aspetto del video player qui
//            }
//            .edgesIgnoringSafeArea(.all)
//
//            // Alcuni altri elementi sovrapposti, come il pulsante Back
//            VStack {
//                Spacer()
//                HStack {
//                    Spacer()
//                    Button(action: {
//                        backToMainScreen()
//                    }) {
//                        HStack {
//                            Text("Skip")
//                                .font(Font.custom("Daydream", size: 14))
//                                .foregroundColor(.white)
//                                .shadow(color: .purple, radius: 10)
//
//                        }
//                    }
//                    .position(CGPoint(x: 50, y: 20.0))
//                }
//            }
//        }
//    }
//
//    private func backToMainScreen() {
//        // Aggiorna lo stato per tornare alla schermata principale
//        self.currentGameState = .mainScreen
//    }
//}

//import SwiftUI
//import AVKit
//
//struct StoryView: View {
//    @Binding var currentGameState: GameState
//
//    var body: some View {
//        ZStack {
//            // Inserisci la tua logica per visualizzare il video qui
//            VideoPlayer(player: AVPlayer(url: Bundle.main.url(forResource: "scarafaggioStory", withExtension: "mp4")!)) {
//                Text("Video not available")
//            }
//            .edgesIgnoringSafeArea(.all)
//
//            Button {
//                backToMainScreen()
//            } label: {
//                HStack {
//                    Text("Back")
//                        .font(Font.custom("Daydream", size: 14))
//                        .foregroundStyle(.white)
//                        .shadow(color:.purple,radius: 10)
//
//                    Image("backButton")
//                        .scaleEffect(0.6)
//                        .shadow(color:.purple,radius: 10)
//                        .padding(EdgeInsets(top: 0, leading: -15, bottom: 0, trailing: 0))
//                }.position(CGPoint(x: 345, y: 20.0))
//            }
//        }
//    }
//
//    private func backToMainScreen() {
//        self.currentGameState = .mainScreen
//    }
//}

//
//
//import SwiftUI
//import AVKit
//
//struct StoryView: View {
//    @Binding var currentGameState: GameState
//
//    var body: some View {
//        ZStack {
//            // Aggiungi AVPlayer per il video
//            VideoPlayer(player: AVPlayer(url: Bundle.main.url(forResource: "scarafaggioStory", withExtension: "mp4")!)) {
//                // Puoi personalizzare il player, ad esempio nascondere i controlli del player.
//            }
//            .ignoresSafeArea()
//
//            // Resto del tuo codice UI
//            Text("Story View")
//
//            Button {
//                backToMainScreen()
//            } label: {
//                HStack {
//                    Text("Back")
//                        .font(Font.custom("Daydream", size: 14))
//                        .foregroundStyle(.white)
//                        .shadow(color:.purple, radius: 10)
//
//                    Image("backButton")
//                        .scaleEffect(0.6)
//                        .shadow(color:.purple,radius: 10)
//                        .padding(EdgeInsets(top: 0, leading: -15, bottom: 0, trailing: 0))
//                }.position(CGPoint(x: 345, y: 20.0))
//            }
//        }
//    }
//
//    private func backToMainScreen() {
//        self.currentGameState = .mainScreen
//    }
//}

//
//#Preview {
//    StoryView(currentGameState: .constant(GameState.story))
//}
//
//import SwiftUI
//
//struct StoryView: View {
//    @Binding var currentGameState: GameState
//
//    var body: some View {
//        // Qui puoi inserire la tua logica per visualizzare il video
//
//        ZStack {
//            Text("Story View")
//
//
//            Button {
//                backToMainScreen()
//            } label: {
//                HStack {
//
//                    Text("Back")
//                        .font(Font.custom("Daydream", size: 14))
//                        .foregroundStyle(.white)
//                        .shadow(color:.purple,radius: 10)
//
//
//
//                    Image("backButton")
//                        .scaleEffect(0.6)
//                        .shadow(color:.purple,radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
//                        .padding(EdgeInsets(top: 0, leading: -15, bottom: 0, trailing: 0))
//                }.position(CGPoint(x: 345, y: 20.0))
//            }
//        }
//    }
//
//
//    private func backToMainScreen() {
//        self.currentGameState = .mainScreen
//    }
//
//
//
//}
//
//
//
