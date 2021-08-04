//
//  FM_HomeScreen.swift
//  Nutby
//
//  Created by Diren Akgöz on 21.06.21.
//

import SwiftUI

struct Feedinglist: View {
    
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
                
                ForEach(vm.getSavedFeedings_Sorted(baby: choosenBaby, isReset: isReset)) { (feeding) in
                    
                    ZStack(alignment: .leading) {
                        
                        RoundedRectangle(cornerRadius: vi.getCR())
                            .fill(Color(hex: vi.getBabyBlueColor()))
                            .frame(height: 105, alignment: .leading)
                            .overlay(RoundedRectangle(cornerRadius: vi.getCR()).stroke(Color(hex: vi.getDarkBlueColor()), lineWidth: 1))
                        
                        HStack {
                            vi.getPicture(enteredBaby: feeding.baby!, uiPicture: UIImage())
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                                .background(Circle()
                                                .strokeBorder(Color(hex: vi.getDarkBlueColor()),lineWidth: 4)
                                                .background(Circle()
                                                .foregroundColor(Color(hex: vi.getBabyBlueColor()))))
                            
                            VStack(alignment: .leading ) {
                                Text(feeding.baby!.firstName! + " " + feeding.baby!.lastName!)
                                    .font(.system(size: 18))
                                    .fontWeight(.bold)
                                
                                Spacer().frame(height: 10)
                                
                                HStack {
                                    Text("Datum und Uhrzeit:").fontWeight(.medium).font(.system(size: 12))
                                    Text(feeding.time!, formatter: vi.getDateFormatter_DateAndTime())
                                        .font(.system(size: 12))
                                        .fontWeight(.medium)
                                }
                                
                                HStack {
                                    Text("Menge (in ml):\t\t").fontWeight(.medium).font(.system(size: 12))
                                    Text(String(format: "%.0f", feeding.milliliter))
                                        .font(.system(size: 12))
                                        .fontWeight(.medium)
                                }
                            }
                        }.padding()
                        NavigationLink(destination: EditFeedingView(enteredFeeding: feeding ,vm: vm)) {}
                    }
                    .foregroundColor(Color(hex: vi.getDarkBlueColor()))
                    
                }
                .onDelete(perform: vm.deleteFeeding)
            }
            .listStyle(PlainListStyle())
            .navigationBarColor(backgroundColor: vi.getBabyBlueUIC(), tintColor: vi.getDarkBlueUIC())
            .navigationTitle("Fütterungen")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                NavigationLink(
                    destination: AddFeedingView(vm: vm),
                    label: {
                        Label("Add Feeding", systemImage: "plus.circle")
                    })
            }
        }
    }
}

struct FM_HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        Feedinglist(vm: ViewModel())
    }
}
