//
//  AgentsListView.swift
//  Valobase
//
//  Created by Kalen Oyphanith on 4/19/22.
//

import SwiftUI

struct AgentsListView: View {
    @ObservedObject var dataModel = AgentViewModel()
    @Binding var selectedTab: Tabs
    var urlString = "https://valorant-api.com/v1/agents"
    
    private let sortOptions = ["A-Z", "Initiator", "Duelist", "Controller", "Sentinel"]
    @State private var sort = 0
    
    var body: some View {
        GeometryReader { metrics in
            NavigationView {
                ZStack {
                    VStack(alignment: .center) {
                        // our main view
                        if dataModel.data.isEmpty {
                            Text("No Agents Found")
                                .font(.system(size: 30))
                                .fontWeight(.bold).frame(maxWidth: .infinity, alignment: .center)
                                .onAppear() {
                                    dataModel.isDone = false
                                    dataModel.fetchData(urlString: urlString)
                                }
                                .disabled(!dataModel.isDone)
                        } else {
                            List(dataModel.data) {agent in
                                if (sort == 1) {
                                    if (agent.role?.displayName == "Initiator") {
                                        NavigationLink(destination: AgentDetailView(selectedTab: $selectedTab, agent: agent)) {
                                            AgentRow(agent: agent)
                                        }// NavigationLink
                                        .listRowBackground(Color.black)
                                    }
                                } else if (sort == 2) {
                                    if (agent.role?.displayName == "Duelist") {
                                        NavigationLink(destination: AgentDetailView(selectedTab: $selectedTab, agent: agent)) {
                                            AgentRow(agent: agent)
                                        }// NavigationLink
                                        .listRowBackground(Color.black)
                                    }
                                } else if (sort == 3) {
                                    if (agent.role?.displayName == "Controller") {
                                        NavigationLink(destination: AgentDetailView(selectedTab: $selectedTab, agent: agent)) {
                                            AgentRow(agent: agent)
                                        }// NavigationLink
                                        .listRowBackground(Color.black)
                                    }
                                } else if (sort == 4) {
                                    if (agent.role?.displayName == "Sentinel") {
                                        NavigationLink(destination: AgentDetailView(selectedTab: $selectedTab, agent: agent)) {
                                            AgentRow(agent: agent)
                                        }// NavigationLink
                                        .listRowBackground(Color.black)
                                    }
                                }
                                else {
                                
                                    NavigationLink(destination: AgentDetailView(selectedTab: $selectedTab, agent: agent)) {
                                        AgentRow(agent: agent)
                                        
                                        

                                    }// NavigationLink
                                    .listRowBackground(Color.black)
                           
                                }
                                
                            } // List
                            .listStyle(PlainListStyle())
                            .frame(maxWidth: .infinity, alignment: .center)
                            
//                            .background(.black)
                            
                        }
                        
//                        Spacer()
//
//                        Button {
//                            dataModel.isDone = false
//                            dataModel.fetchData(urlString: urlString)
//                        } label : {
//                            Text("fetch")
//                        }
//                        .disabled(!dataModel.isDone)
//
//                        Text(dataModel.errorMessage)
//                            .foregroundColor(.red)
//                            .opacity(dataModel.error ? 1.0 : 0.0)
                    } // VStack
                } // ZStack
                .navigationBarTitle("Agents", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Picker("Sort", selection: $sort) {
                            //Text("A-Z").tag(0)
                            ForEach(0 ..< sortOptions.count) {
                                Text(self.sortOptions[$0])
                            } //ForEach
                        } //Picker
                        .pickerStyle(SegmentedPickerStyle())
                    } //ToolbarItem
                } //toolbar

            }// NavigationView
        } // GeometryReader
    } // body
} // AgentsListView

struct AgentRow: View {
    var agent: AgentStruct
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(.white)
            HStack() {
                
                Text("\(agent.displayName)")
                    .font(.custom("Verdana", size: 20, relativeTo: .title3))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(12)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                
                Spacer()
                // https://developer.apple.com/documentation/swiftui/asyncimage
                if let bustPortrait = agent.bustPortrait {
                    AsyncImage(url: URL(string: "\(bustPortrait)")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 200, height: 200)
                }
            
            } // Hstack
            //.padding(10)

        }// Zstack
        .frame(width: UIScreen.main.bounds.size.width - 40, height: 200)
        //.padding(10)

    } // body
}

struct AgentsListView_Previews: PreviewProvider {
    static var previews: some View {
        AgentsListView(selectedTab: .constant(Tabs.agents))
    }
}
    
//ParksListView(selectedTab: .constant(Tabs.parksList)).environmentObj
//weapon: WeaponsViewModel().data.first!
