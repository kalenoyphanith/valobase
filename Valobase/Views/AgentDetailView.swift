//
//  AgentDetailView.swift
//  Valobase
//
//  Created by Kalen Oyphanith on 4/27/22.
//

import SwiftUI

struct AgentDetailView: View {
    
    @Binding var selectedTab: Tabs
    var agent: AgentStruct
        
    var body: some View {
        Form {
            
            Section() {
                AgentImage(agent: agent)
            }
            
            //potential loop for abilities
            if let role = agent.role?.displayName {
                Section() {
                    Text("\(agent.displayName)")
                        .bold()
                        .listRowSeparator(.hidden)

                    Text("\(role)")
                        .foregroundColor(.gray)
                        .listRowSeparator(.hidden)

                    Text("\(agent.description)")
                        .padding([.bottom, .trailing], 20)
                    
                              
                } // section
            }
            
            Section() {
                Text("Abilities")
                    .bold()
                if let abilities1 = agent.abilities?[0].displayName {
                    Text("\(abilities1)")
                        .foregroundColor(.red)
                        .bold()
                   Text("\((agent.abilities?[0].description)!)")

                }
                
                if let abilities2 = agent.abilities?[1].displayName {
                    Text("\(abilities2)")
                        .foregroundColor(.red)
                        .bold()
                    Text("\((agent.abilities?[1].description)!)")

                }
                
                if let abilities3 = agent.abilities?[2].displayName {
                    Text("\(abilities3)")
                        .foregroundColor(.red)
                        .bold()

                    Text("\((agent.abilities?[2].description)!)")
                }
                
                Text("Ultimate")
                    .bold()
                if let abilities4 = agent.abilities?[3].displayName {
                    Text("\(abilities4)")
                        .foregroundColor(.red)
                        .bold()

                    Text("\((agent.abilities?[3].description)!)")
                        .padding([.bottom, .trailing], 20)
                }
                
            }

        } // Form
        .navigationBarTitle("\(agent.displayName)")
        .background(Color.black)
        .onAppear { // ADD THESE
          UITableView.appearance().backgroundColor = .clear
        }
        .onDisappear {
          UITableView.appearance().backgroundColor = .systemGroupedBackground
        } // https://swiftuirecipes.com/blog/styling-swiftui-form
    } // body
} //DetailView

struct AgentImage: View {
    var agent: AgentStruct
    var body: some View {
        
        HStack() {
            // https://developer.apple.com/documentation/swiftui/asyncimage
            if let fullPortraitV2 = agent.fullPortraitV2 {
                AsyncImage(url: URL(string: "\(fullPortraitV2)")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 350, height: 350)
            }
        
        } // vstack
    } // body
}

struct AgentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AgentDetailView(selectedTab: .constant(Tabs.agents), agent: AgentViewModel().data.first!)
    }
}
