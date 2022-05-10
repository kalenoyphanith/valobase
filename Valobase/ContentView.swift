//
//  ContentView.swift
//  Valobase
//
//  Created by Kalen Oyphanith on 4/19/22.
//

import SwiftUI

enum Tabs: Hashable {
    case agents
    case weapons
    case modes
    
}

struct ContentView: View {
    
    @State private var selectedTab = Tabs.agents
    
    var body: some View {
        TabView(selection: $selectedTab){
            
            AgentsListView(selectedTab: $selectedTab)
                .tabItem{
                    Image(systemName: "person.3.fill")
                    Text("Agents")
                }
                .tag(Tabs.agents)
            
            WeaponsListView(selectedTab: $selectedTab)
                .tabItem{
                    Image("imageName")
                    Text("Weapons")
                }
                .tag(Tabs.weapons)
                
            
            GameModeView(selectedTab: $selectedTab)
                .tabItem{
                    Image(systemName: "gamecontroller.fill")
                    Text("Game Modes")
                }
                .tag(Tabs.modes)
            
        }//TabView
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
