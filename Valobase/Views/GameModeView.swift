//
//  GameModeView.swift
//  Valobase
//
//  Created by Kalen Oyphanith on 5/1/22.
//

import SwiftUI

struct GameModeView: View {
    @ObservedObject var dataModel = ModeViewModel()
    @Binding var selectedTab: Tabs
    var urlString = "https://valorant-api.com/v1/gamemodes"
    
    var body: some View {
        GeometryReader { metrics in
            NavigationView {
                ZStack {
                    VStack(alignment: .center) {
                        // our main view
                        if dataModel.data.isEmpty {
                            Text("No Modes Found")
                                .font(.system(size: 30))
                                .fontWeight(.bold).frame(maxWidth: .infinity, alignment: .center)
                                .onAppear() {
                                    dataModel.isDone = false
                                    dataModel.fetchData(urlString: urlString)
                                }
                                .disabled(!dataModel.isDone)
                               
                        } else {
                            
                            List(dataModel.data) {mode in
                                GameModeRow(mode: mode)
                            } // List
                            .listStyle(PlainListStyle())
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                        
                        Text(dataModel.errorMessage)
                            .foregroundColor(.red)
                            .opacity(dataModel.error ? 1.0 : 0.0)
                    } // VStack
                    
                } // ZStack
                .navigationBarTitle("Game Modes", displayMode: .inline)

            }// NavigationView
        } // GeometryReader
    }//body
}// gamemodeview

struct GameModeRow: View {
    var mode: GameModeStruct
    var body: some View {

        HStack {

                
                if let displayIcon = mode.displayIcon {
                    AsyncImage(url: URL(string: "\(displayIcon)")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 100, height: 100)
                    .background(.black)
                }
                
            VStack() {
                if let duration = mode.duration {
                    /* if the displayName is either onboarding or practice, display: Unlimited time
                    if (mode.displayName == "Onboarding" || mode.displayName == "PRACTICE") {
                        Text("Unlimited Time")
                        font(.custom("Verdana", size: 20, relativeTo: .title3))
                            .foregroundColor(.black)
                    }
                     */
                    Text("\(mode.displayName)")
                        .font(.custom("Verdana", size: 20, relativeTo: .title3))
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                        .padding(10)
                        .listRowSeparator(.hidden)
                    
                    Text("\(duration)")
                        .font(.custom("Verdana", size: 20, relativeTo: .title3))
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                        .padding(10)
                }
            }
        }// ZStack
        .frame(width: UIScreen.main.bounds.size.width - 40, height: 200)
    } // body
}
struct GameModeView_Previews: PreviewProvider {
    static var previews: some View {
        GameModeView(selectedTab: .constant(Tabs.modes))
    }
}
