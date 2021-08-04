//
//  EditFeedingView.swift
//  Nutby
//
//  Created by Diren Akgöz on 31.07.21.
//

import Foundation
import SwiftUI

struct EditFeedingView: View {
    
    @State var enteredFeeding: Feedings
    @ObservedObject var vm : ViewModel
    
    var body: some View {
        VStack(spacing: 25) {
            Spacer().frame(height: 10)
            EditFeeding_Information()
            EditFeeding_EnterFields(vm: vm, enteredFeeding: enteredFeeding)
            Spacer()
        }
    }
}

struct EditFeeding_Information: View {
    var body : some View {
        ZStack {
            RoundedRectangle(cornerRadius: vi.getCR())
                .fill(Color(hex: vi.getBabyBlueColor()))
                .frame(width: vi.getRRWidth(), height: 65, alignment: .top)
                .overlay(RoundedRectangle(cornerRadius: vi.getCR()).stroke(Color(hex: vi.getDarkBlueColor()), lineWidth: 1))
            Text("Bitte füllen Sie die unteren Felder aus, \num die Daten der Fütterung zu bearbeiten.")
                .font(.system(size: 17))
                .fontWeight(.bold)
                .foregroundColor(Color(hex: vi.getDarkBlueColor()))
        }
    }
}

struct EditFeeding_EnterFields: View {
    
    @State var vm : ViewModel
    @State var enteredFeeding: Feedings
    @State private var milliliter : Float = Float()
    @State private var milliliterString : String = ""
    @State private var time = Date()
    @State private var choosenBaby = Babies()

    private func resetVars() {
        milliliter = Float()
        milliliterString = ""
        time = Date()
        choosenBaby = Babies()
    }
    
    private func allPropertiesSelected() -> Bool {
        return (milliliterString != "")
    }
    
    var body: some View {
        
        VStack {

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
                        vm.updateFeeding(feeding: enteredFeeding, t: time, ml: milliliter)
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
