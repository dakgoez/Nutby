//
//  AddDiaperChangeView.swift
//  Nutby
//
//  Created by Diren Akgöz on 26.07.21.
//

import SwiftUI

struct AddDiaperChangeView: View {
    
    @ObservedObject var vm : ViewModel
    
    var body: some View {
        VStack(spacing: 25) {
            Spacer().frame(height: 10)
            DiaperChange_Information()
            DiaperChange_EnterFields(vm: vm)
            Spacer()
        }
    }
}

struct DiaperChange_Information: View {
    var body : some View {
        ZStack {
            RoundedRectangle(cornerRadius: vi.getCR())
                .fill(Color(hex: vi.getBabyBlueColor()))
                .frame(width: vi.getRRWidth(), height: 65, alignment: .top)
                .overlay(RoundedRectangle(cornerRadius: vi.getCR()).stroke(Color(hex: vi.getDarkBlueColor()), lineWidth: 1))
            Text("Bitte füllen Sie die unteren Felder aus, \num einen Windelwechsel einzutragen.")
                .font(.system(size: 17))
                .fontWeight(.bold)
                .foregroundColor(Color(hex: vi.getDarkBlueColor()))
        }
    }
}

struct DiaperChange_EnterFields: View {
    
    @State var vm : ViewModel
    @State private var choosenBabyName: String = "Bitte auswählen"
    @State private var choosenBaby = Babies()//: Babies = Babies()
    @State private var time = Date()
    @State private var urineToggle: Bool = false
    @State private var fecesToggle: Bool = false

    private func resetVars() {
        choosenBabyName = "Bitte auswählen"
        choosenBaby = Babies()
        time = Date()
        urineToggle = false
        fecesToggle = false
    }
    
    private func allPropertiesSelected() -> Bool {
        return (vm.savedBabies.contains(choosenBaby))
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
                Text("Mit Urin?").foregroundColor(Color(hex: vi.getDarkBlueColor()))
                Spacer()
                Toggle(isOn: $urineToggle) {
                }.toggleStyle(YesOrNoToggleStyle())
            }
            
            HStack {
                Text("Mit Stuhlgang?").foregroundColor(Color(hex: vi.getDarkBlueColor()))
                Spacer()
                Toggle(isOn: $fecesToggle) {
                }.toggleStyle(YesOrNoToggleStyle())
            }
            
            HStack {
                Text("Zeit").foregroundColor(Color(hex: vi.getDarkBlueColor()))
                Spacer()
                DatePicker("", selection: $time,  in: ...Date()/*, displayedComponents: .date*/)
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
                        vm.addDiaperChange(f: !fecesToggle, u: !urineToggle, t: time, enteredBaby: choosenBaby)
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

struct AddDiaperChangeView_Previews: PreviewProvider {
    static var previews: some View {
        AddDiaperChangeView(vm: ViewModel())
    }
}
