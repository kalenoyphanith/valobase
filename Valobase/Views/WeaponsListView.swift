//
//  WeaponsListView.swift
//  Valobase
//
//  Created by Kalen Oyphanith on 4/19/22.
//

import SwiftUI

struct WeaponsListView: View {
    
    @ObservedObject var dataModel = WeaponsViewModel()
    @Binding var selectedTab: Tabs
    var urlString = "https://valorant-api.com/v1/weapons"
    
    private let sortOptions = ["Weapons A-Z","Heavy","Rifles","Shotguns","Pistols","Sniper","SMGs"]
    @State private var sort = 0
    
    var body: some View {
        GeometryReader { metrics in
            NavigationView {
                ZStack {
                    VStack(alignment: .center) {
                        // our main view
                        if dataModel.data.isEmpty {
                            Text("No Weapons Found")
                                .font(.system(size: 30))
                                .fontWeight(.bold).frame(maxWidth: .infinity, alignment: .center)
                                .onAppear() {
                                    dataModel.isDone = false
                                    dataModel.fetchData(urlString: urlString)
                                }
                                .disabled(!dataModel.isDone)
                               
                        } else {

                            List(dataModel.data) {weapon in
                                // Future changes: ,ake into switch statement
                                if (sort == 1) {
                                    if (weapon.shopData?.category == "Heavy Weapons") {
                                        NavigationLink(destination: WeaponDetailView(selectedTab: $selectedTab, weapon: weapon)) {
                                            WeaponRow(weapon: weapon)
                                        }
                                        .listRowBackground(Color.black)

                                    }
                                    
                                } else if (sort == 2) {
                                    if (weapon.shopData?.category == "Rifles") {
                                        NavigationLink(destination: WeaponDetailView(selectedTab: $selectedTab, weapon: weapon)) {
                                            WeaponRow(weapon: weapon)
                                        }
                                        .listRowBackground(Color.black)

                                    }
                                    
                                } else if (sort == 3) {
                                    if (weapon.shopData?.category == "Shotguns") {
                                        NavigationLink(destination: WeaponDetailView(selectedTab: $selectedTab, weapon: weapon)) {
                                            WeaponRow(weapon: weapon)
                                        }
                                        .listRowBackground(Color.black)

                                    }
                                    
                                } else if (sort == 4) {
                                    if (weapon.shopData?.category == "Pistols") {
                                        NavigationLink(destination: WeaponDetailView(selectedTab: $selectedTab, weapon: weapon)) {
                                            WeaponRow(weapon: weapon)
                                        }
                                        .listRowBackground(Color.black)

                                    }
                                    
                                } else if (sort == 5) {
                                    if (weapon.shopData?.category == "Sniper Rifles") {
                                        NavigationLink(destination: WeaponDetailView(selectedTab: $selectedTab, weapon: weapon)) {
                                            WeaponRow(weapon: weapon)
                                        }
                                        .listRowBackground(Color.black)

                                    }
                                    
                                } else if (sort == 6) {
                                    if (weapon.shopData?.category == "SMGs") {
                                        NavigationLink(destination: WeaponDetailView(selectedTab: $selectedTab, weapon: weapon)) {
                                            WeaponRow(weapon: weapon)
                                        }
                                        .listRowBackground(Color.black)

                                    }
                                    
                                } else {
                                    NavigationLink(destination: WeaponDetailView(selectedTab: $selectedTab, weapon: weapon)) {
                                        WeaponRow(weapon: weapon)
                                    }
                                    .listRowBackground(Color.black)

                                }
                                
                                    
                        
                            } // List
                            .listStyle(PlainListStyle())
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                        
                        Text(dataModel.errorMessage)
                            .foregroundColor(.red)
                            .opacity(dataModel.error ? 1.0 : 0.0)
                    } // VStack
                    
                } // ZStack
                .navigationBarTitle("Weapons", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Picker("Sort", selection: $sort) {
                            ForEach(0 ..< sortOptions.count) {
                                Text(self.sortOptions[$0])
                            } //ForEach
                        } //Picker
                        .pickerStyle(MenuPickerStyle())

                    } //ToolbarItem
                } //toolbar

            }// NavigationView
        } // GeometryReader
    }
}

struct WeaponRow: View {
    var weapon: WeaponStruct
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(.white)
            LazyVStack(alignment: .leading) {
        
                if let displayIcon = weapon.displayIcon {
                    AsyncImage(url: URL(string: "\(displayIcon)")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 100)
                }
                Text("\(weapon.displayName)")
                    .font(.custom("Verdana", size: 20, relativeTo: .title3))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(10)
            } // vstack
        }// ZStack
        .frame(width: UIScreen.main.bounds.size.width - 40, height: 200)
    } // body
}

struct WeaponsListView_Previews: PreviewProvider {
    static var previews: some View {
        WeaponsListView(selectedTab: .constant(Tabs.weapons))
    }
}
