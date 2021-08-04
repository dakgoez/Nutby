//
//  DM_HomeScreen.swift
//  Nutby
//
//  Created by Diren Akgöz on 21.06.21.
//

import SwiftUI

struct DiaperChangelist: View {
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.dateFormat = "dd.MM.y"
        return formatter
    }()
    
    @ObservedObject var vm : ViewModel
    @State private var selectedTab = 0
    @State private var choosenBaby : Babies = Babies()
    @State private var choosenBabyName: String = "Bitte auswählen"
    @State private var isReset : Bool = true
    
    var body: some View {
        
        NavigationView {

            List {
                
                HStack {
                    Text("Baby").foregroundColor(Color(hex: vi.getDarkBlueColor()))
                    
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: vi.getCR())
                            .fill(Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(hex: vi.getDarkBlueColor()), lineWidth: 1))
                        
                        Menu(choosenBabyName) {
                            ForEach(vm.savedBabies) { (entity) in
                                Button {
                                    choosenBabyName = entity.firstName!
                                    choosenBaby = entity
                                    isReset = false
                                } label: {
                                    Text(entity.firstName! + " " + entity.lastName!)
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        choosenBabyName = "Bitte auswählen"
                        choosenBaby = Babies()
                        isReset = true
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: vi.getCR())
                                .fill(Color(.white))
                                .frame(width: 30, height: 30)
                                .overlay(RoundedRectangle(cornerRadius: vi.getCR()).stroke(Color(hex: vi.getDarkBlueColor()), lineWidth: 1))
                            Text("X").foregroundColor(Color(hex: vi.getDarkBlueColor()))
                        }
                    }
                }
                
                ForEach(vm.getSavedDiaperChanges_Sorted(baby: choosenBaby, isReset: isReset)) { (diaperChange) in
                    
                    ZStack(alignment: .leading) {
                        
                        RoundedRectangle(cornerRadius: vi.getCR())
                            .fill(Color(hex: vi.getBabyBlueColor()))
                            .frame(height: 105, alignment: .leading)
                            .overlay(RoundedRectangle(cornerRadius: vi.getCR()).stroke(Color(hex: vi.getDarkBlueColor()), lineWidth: 1))
                        
                        HStack {
                            vi.getPicture(enteredBaby: diaperChange.baby!, uiPicture: UIImage())
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                                .background(Circle()
                                                .strokeBorder(Color(hex: vi.getDarkBlueColor()),lineWidth: 4)
                                                .background(Circle()
                                                .foregroundColor(Color(hex: vi.getBabyBlueColor()))))
                            
                            VStack(alignment: .leading ) {
                                Text(diaperChange.baby!.firstName! + " " + diaperChange.baby!.lastName!)
                                    .font(.system(size: 18))
                                    .fontWeight(.bold)
                                
                                Spacer().frame(height: 10)
                                
                                HStack {
                                    Text("Datum und Uhrzeit:").fontWeight(.medium).font(.system(size: 12))
                                    Text(diaperChange.time!, formatter: vi.getDateFormatter_DateAndTime())
                                        .font(.system(size: 12))
                                        .fontWeight(.medium)
                                }
                                
                                HStack {
                                    Text("Mit Urin:\t\t\t").fontWeight(.medium).font(.system(size: 12))
                                    if (vm.getLastDiaperChangeOf_Condition(baby: diaperChange.baby!) == nil) {
                                        Text("...").fontWeight(.medium).font(.system(size: 12))
                                    } else {
                                        Text(diaperChange.urine ? "Ja" : "Nein").fontWeight(.medium).font(.system(size: 12))
                                    }
                                }
                                
                                HStack {
                                    Text("Mit Stuhlgang:\t").fontWeight(.medium).font(.system(size: 12))
                                    if (vm.getLastDiaperChangeOf_Condition(baby: diaperChange.baby!) == nil) {
                                        Text("...").fontWeight(.medium).font(.system(size: 12))
                                    } else {
                                        Text(diaperChange.feces ? "Ja" : "Nein").fontWeight(.medium).font(.system(size: 12))
                                    }
                                }
                            }
                        }.padding()
                        NavigationLink(destination: EditDiaperChangeView(enteredDiaperChange: diaperChange, vm: vm)) {}
                    }
                    .foregroundColor(Color(hex: vi.getDarkBlueColor()))
                }
                .onDelete(perform: vm.deleteDiaperChange)
            }
            .listStyle(PlainListStyle())
            .navigationBarColor(backgroundColor: vi.getBabyBlueUIC(), tintColor: vi.getDarkBlueUIC())
            .navigationTitle("Windelwechsel")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                NavigationLink(
                    destination: AddDiaperChangeView(vm: vm),
                    label: {
                        Label("Add Feeding", systemImage: "plus.circle")
                    })
            }
        }
        
    }
}

struct DM_HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        DiaperChangelist(vm: ViewModel())
    }
}
