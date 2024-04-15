//
//  CreditsView.swift
//  Scarafaggino
//
//  Created by sara hu lihua on 18/12/23.
//

import SwiftUI


struct CreditsView: View {
    @Binding var currentGameState: GameState
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            // Background Image
            Image("backgroundCavern") // Assuming "backgroundCavern" is the image name
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text("Credits")
                    .font(Font.custom("Daydream", size: 12))
                    .scaleEffect(y: 2.0)
                    .foregroundColor(Color(red: 220 / 255, green: 150 / 255, blue: 255 / 255))
                    .shadow(color: .black, radius: 10)
                    .padding(.bottom, 20) // Adjust padding
                
                VStack(spacing: 10) {
                    Text("Gianrocco Di Tommaso")
                        .font(Font.custom("Daydream", size: 14))
                        .foregroundColor(.white)
                        .shadow(color: .purple, radius: 10)
                    
                    Text("Sara Hu")
                        .font(Font.custom("Daydream", size: 14))
                        .foregroundColor(.white)
                        .shadow(color: .purple, radius: 10)
                    
                    Text("Beniamino Gentile")
                        .font(Font.custom("Daydream", size: 14))
                        .foregroundColor(.white)
                        .shadow(color: .purple, radius: 10)
                    
                    Text("Alessandra Amorico")
                        .font(Font.custom("Daydream", size: 14))
                        .foregroundColor(.white)
                        .shadow(color: .purple, radius: 10)
                }
                
                Spacer()
            }
        }
               .overlay(
                   Button(action: {
                       backToMainScreen() // Method to return to the main screen
                       presentationMode.wrappedValue.dismiss()
                   }) {
                       Image("backButton1") // Replace "backButton" with your image name
                                           .resizable()
                                           .aspectRatio(contentMode: .fit)
                                           .frame(width: 40, height: 40) // Adjust the frame size
                                           .padding()
                   }
                    // Adjust top padding
                   .padding(.trailing, 20) // Adjust leading padding
                   , alignment: .topTrailing // Align the button to the top left
               )
           }
           
           private func backToMainScreen() {
               // Update the state to return to the main screen
               self.currentGameState = .mainScreen
           }
       }

#Preview {
    CreditsView(currentGameState: .constant(GameState.credits))
}


//#Preview {
//    CreditsView(currentGameState: .constant(100), presentationMode: dismiss(1))
//}
