//
//  Babylist3.swift
//  Nutby
//
//  Created by Diren Akgöz on 20.06.21.
//

import SwiftUI
import UIKit

let vi = ViewInformation()

struct Babylist: View {
    @ObservedObject var vm : ViewModel
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {

            List() {
                ForEach(vm.savedBabies) { (entity) in

                    ZStack(alignment: .leading) {
                        
                        RoundedRectangle(cornerRadius: vi.getCR())
                            .fill(Color(hex: vi.getBabyBlueColor()))
                            .frame(height: 105, alignment: .leading)
                            .overlay(RoundedRectangle(cornerRadius: vi.getCR()).stroke(Color(hex: vi.getDarkBlueColor()), lineWidth: 1))
                        
                        HStack {
                            vi.getPicture(enteredBaby: entity, uiPicture: UIImage())
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                                .background(Circle()
                                                .strokeBorder(Color(hex: vi.getDarkBlueColor()),lineWidth: 4)
                                                .background(Circle()
                                                .foregroundColor(Color(hex: vi.getBabyBlueColor()))))
                            
                            VStack(alignment: .leading ) {
                                Text(entity.firstName! + " " + entity.lastName!)
                                    .font(.system(size: 18))
                                    .fontWeight(.bold)
                                
                                Spacer().frame(height: 10)
                                
                                HStack {
                                    Text("Zuletzt gefüttert:\t").fontWeight(.medium).font(.system(size: 12))
                                    if (vm.getLastFeedingOf_Condition(baby: entity) == nil) {
                                        Text("...").fontWeight(.medium).font(.system(size: 12))
                                    } else {
                                        Text(vm.getSavedFeedings_Sorted().first(where: { (f: Feedings) -> Bool in
                                            f.baby == entity
                                        })!.time!, formatter: vi.getDateFormatter_DateAndTime())
                                            .font(.system(size: 12))
                                            .fontWeight(.medium)
                                    }
                                }
                                HStack {
                                    Text("Zuletzt gewickelt:\t").fontWeight(.medium).font(.system(size: 12))
                                    if (vm.getLastDiaperChangeOf_Condition(baby: entity) == nil) {
                                        Text("...").fontWeight(.medium).font(.system(size: 12))
                                    } else {
                                        Text(vm.getSavedDiaperChanges_Sorted().first(where: { (dc: DiaperChange) -> Bool in
                                            dc.baby == entity
                                        })!.time!, formatter: vi.getDateFormatter_DateAndTime())
                                            .font(.system(size: 12))
                                            .fontWeight(.medium)
                                    }
                                }
                            }
                        }.padding()
                        NavigationLink(destination: BabyInformationView(enteredBaby: entity, vm: vm)) {}
                    }
                    .foregroundColor(Color(hex: vi.getDarkBlueColor()))
                }
                .onDelete(perform: vm.deleteBaby)
            }
            .listStyle(PlainListStyle())
            .navigationBarColor(backgroundColor: vi.getBabyBlueUIC(), tintColor: vi.getDarkBlueUIC())
            .navigationTitle("Ihre Babies")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                NavigationLink(
                    destination: AddBabyView(vm: vm),
                    label: {
                        Label("Add Baby", systemImage: "plus.circle")
                    })
            }
        }
    }
}

struct Babylist_Previews: PreviewProvider {
    static var previews: some View {
        Babylist(vm: ViewModel())
    }
}
