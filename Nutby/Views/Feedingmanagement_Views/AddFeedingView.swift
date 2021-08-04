//
//  AddFeedingView.swift
//  Nutby
//
//  Created by Diren Akgöz on 22.07.21.
//

import SwiftUI

struct AddFeedingView: View {
    
    @ObservedObject var vm : ViewModel
    
    var body: some View {
        VStack(spacing: 25) {
            Spacer().frame(height: 10)
            Feeding_Information()
            Feeding_EnterFields(vm: vm)
            Spacer()
        }
    }
}

struct Feeding_Information: View {
    var body : some View {
        ZStack {
            RoundedRectangle(cornerRadius: vi.getCR())
                .fill(Color(hex: vi.getBabyBlueColor()))
                .frame(width: vi.getRRWidth(), height: 65, alignment: .top)
                .overlay(RoundedRectangle(cornerRadius: vi.getCR()).stroke(Color(hex: vi.getDarkBlueColor()), lineWidth: 1))
            Text("Bitte füllen Sie die unteren Felder aus, \num eine Fütterung einzutragen.")
                .font(.system(size: 17))
                .fontWeight(.bold)
                .foregroundColor(Color(hex: vi.getDarkBlueColor()))
        }
    }
}

struct Feeding_EnterFields: View {
    
    @State var vm : ViewModel
    @State private var choosenBabyName: String = "Bitte auswählen"
    @State private var milliliter : Float = Float()
    @State private var milliliterString : String = ""
    @State private var time = Date()
    @State private var choosenBaby = Babies()

    private func resetVars() {
        choosenBabyName = "Bitte auswählen"
        milliliter = Float()
        milliliterString = ""
        time = Date()
        choosenBaby = Babies()
    }
    
    private func allPropertiesSelected() -> Bool {
        return (vm.savedBabies.contains(choosenBaby) && milliliterString != "")
    }
    
    var body: some View {
        
        VStack {
            
            HStack {
                Text("Baby").foregroundColor(Color(hex: vi.getDarkBlueColor()))
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: vi.getCR())
                        .fill(Color.white)
                        .frame(width: vi.getWidth(), height: vi.getHeight(), alignment: .center)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(hex: vi.getDarkBlueColor()), lineWidth: 1))
                    
                    Menu(choosenBabyName) {
                        ForEach(vm.savedBabies) { (entity) in
                            Button {
                                choosenBabyName = entity.firstName ?? "No Name"
                                choosenBaby = entity
                            } label: {
                                Text(entity.firstName! + " " +  entity.lastName!)
                            }
                        }
                    }
                }
            }

            HStack {
                Text("Menge (in ml)").foregroundColor(Color(hex: vi.getDarkBlueColor()))
                Spacer()
                TextField("\tBitte Menge in ml eintragen", text: $milliliterString)
                    .frame(width: vi.getWidth(), height: vi.getHeight(), alignment: .center)
                    .overlay(RoundedRectangle(cornerRadius: vi.getCR()).stroke(Color(hex: vi.getDarkBlueColor())))
                    .keyboardType(.decimalPad)
            }
            
            HStack {
                Text("Zeit").foregroundColor(Color(hex: vi.getDarkBlueColor()))
                Spacer()
                DatePicker("", selection: $time,  in: ...Date())
                    .fixedSize()
                    .datePickerStyle(DefaultDatePickerStyle())
                    .foregroundColor(Color(hex: vi.getDarkBlueColor()))
            }

            HStack(spacing: 100) {
                Button {
                    resetVars()
                } label: {
                    Text("Verwerfen")
                        .fontWeight(.heavy)
                        .font(.system(size: 15))
                        .background(RoundedRectangle(cornerRadius: vi.getCR())
                                        .fill(Color(hex: vi.getBabyBlueColor()))
                                        .frame(width: 150, height: 50, alignment: .center)
                                        .overlay(RoundedRectangle(cornerRadius: vi.getCR()).stroke(Color(hex: vi.getDarkBlueColor()), lineWidth: 1)))
                }.padding()
                
                Button {
                    if(allPropertiesSelected()) {
                        milliliter = (milliliterString as NSString).floatValue
                        vm.addFeeding(t: time, ml: milliliter, enteredBaby: choosenBaby)
                        resetVars()
                    }
                } label: {
                    Text("Speichern")
                        .fontWeight(.heavy)
                        .font(.system(size: 15))
                        .background(RoundedRectangle(cornerRadius: vi.getCR())
                                        .fill(allPropertiesSelected() ? Color(hex: vi.getBabyBlueColor()) : Color(hex: vi.getLightGray()))
                                        .frame(width: 150, height: 50, alignment: .center)
                                        .overlay(RoundedRectangle(cornerRadius: vi.getCR()).stroke(Color(hex: vi.getDarkBlueColor()), lineWidth: 1)))
                }.padding()
                
            }.padding()
            
        }.padding()
    }
}


struct AddFeedingView_Previews: PreviewProvider {
    static var previews: some View {
        AddFeedingView(vm: ViewModel())
    }
}
