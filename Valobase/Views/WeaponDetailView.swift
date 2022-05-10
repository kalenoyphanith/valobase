//
//  WeaponDetailView.swift
//  Valobase
//
//  Created by Kalen Oyphanith on 5/1/22.
//

import SwiftUI

struct WeaponDetailView: View {
    @Binding var selectedTab: Tabs
    var weapon: WeaponStruct
    
    var body: some View {
        
        Form {
            Section() {
                WeaponImage(weapon: weapon)
            }
            
            Section(){
    
                if (weapon.displayName == "Melee") {
                    Text("NO DATA FOR MELEE")
                }

                if let category = weapon.shopData?.category {
                    Text("\(weapon.displayName)")
                        .bold()
                    Text("Cost: $\(weapon.shopData!.cost)")

                    Text("in \(category)")
                        .foregroundColor(.gray)
                        .listRowSeparator(.hidden)
                }

                Text("Stats")
                    .foregroundColor(.red)
                    .bold()

                if let fireRate = weapon.weaponStats?.fireRate {
                    Text("Fire Rate: \(String(format:"%.2f", fireRate))rds/s")
                        .listRowSeparator(.hidden)
                    Text("Equip Time: \(String(format:"%.2f", weapon.weaponStats!.equipTimeSeconds))s")
                    
                    Text("Reload Time: \(String(format:"%.2f", weapon.weaponStats!.reloadTimeSeconds))s")
                        
                    Text("Damage Range in Meters (0 - 30)")
                        .bold()
                    Text("Head Damage: -\(String(format:"%.2f", weapon.weaponStats!.damageRanges![0].headDamage))")
                        .listRowSeparator(.hidden)

                    Text("Body Damage: -\(String(format:"%.2f", weapon.weaponStats!.damageRanges![0].bodyDamage))")
                        .listRowSeparator(.hidden)

                    Text("Leg Damage: -\(String(format:"%.2f", weapon.weaponStats!.damageRanges![0].legDamage))")
                        .listRowSeparator(.hidden)


                    /* Another range but getting index error
                    if let damage = weapon.weaponStats?.damageRanges?[1]{

                        Text("Damage Range: 30 - 50")
                        Text("Head Damage: \(String(format:"%.2f", damage.headDamage))")
                        Text("Body Damage: \(String(format:"%.2f", damage.bodyDamage))")
                        Text("Leg Damage: \(String(format:"%.2f", damage.legDamage))")
                    }
                     */
                }
                
            } // Section
            
            // loop through all the skins
            // unable to get all images since some are null
            Section() {
                Text("Skins")
                    .bold()
                let skin1: String? = weapon.skins?[0].displayName
                if skin1 != nil{
                    ForEach((weapon.skins)!, id: \.id) { result in
                        Text("\(result.displayName)")
                    }

                }
            }
            
        }// Form
        .navigationBarTitle("\(weapon.displayName)")
        .background(Color.black)
        .onAppear { // ADD THESE
          UITableView.appearance().backgroundColor = .clear
        }
        .onDisappear {
          UITableView.appearance().backgroundColor = .systemGroupedBackground
        }
    } // body
}//WeaponDetailView

struct WeaponImage: View {
    var weapon: WeaponStruct
    var body: some View {
        
        HStack() {
            // https://developer.apple.com/documentation/swiftui/asyncimage
            if let displayIcon = weapon.displayIcon {
                AsyncImage(url: URL(string: "\(displayIcon)")) { phase in
                    if let image = phase.image {
                        image.resizable() // Displays the loaded image.
                    } else if phase.error != nil {
                        Image(systemName: "exclamationmark.icloud")
                            .frame(height: 250)// Indicates an error.
                    } else {
                        Image(systemName: "photo")
                            .frame(height: 250)// Acts as a placeholder.
                    }
                }
                .frame(height: 100)
            }
        
        } // vstack
    } // body
}
struct WeaponDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WeaponDetailView(selectedTab: .constant(Tabs.weapons), weapon: WeaponsViewModel().data.first!)
    }
}
