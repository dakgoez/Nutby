//
//  EditDiaperChangeView.swift
//  Nutby
//
//  Created by Diren Akgöz on 31.07.21.
//

import Foundation
import SwiftUI

struct EditDiaperChangeView: View {
    
    @State var enteredDiaperChange: DiaperChange
    @ObservedObject var vm : ViewModel
    
    var body: some View {
        VStack(spacing: 25) {
            Spacer().frame(height: 10)
            EditDiaperChange_Information()
            EditDiaperChange_EnterFields(vm: vm, enteredDiaperCHange: enteredDiaperChange)
            Spacer()
        }
    }
}

struct EditDiaperChange_Information: View {
    var body : some View {
        ZStack {
            RoundedRectangle(cornerRadius: vi.getCR())
                .fill(Color(hex: vi.getBabyBlueColor()))
                .frame(width: vi.getRRWidth(), height: 65, alignment: .top)
                .overlay(RoundedRectangle(cornerRadius: vi.getCR()).stroke(Color(hex: vi.getDarkBlueColor()), lineWidth: 1))
            Text("Bitte füllen Sie die unteren Felder aus, \num die Daten des Windelwechsels zu bearbeiten.")
                .font(.system(size: 15))
                .fontWeight(.bold)
                .foregroundColor(Color(hex: vi.getDarkBlueColor()))
        }
    }
}

struct EditDiaperChange_EnterFields: View {
    
    @State var vm : ViewModel
    @State var enteredDiaperCHange : DiaperChange
    @State private var time = Date()
    @State private var urineToggle: Bool = false
    @State private var fecesToggle: Bool = false

    private func resetVars() {
        time = Date()
        urineToggle = false
        fecesToggle = false
    }
    
    var body: some View {
        
        VStack {

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
                    vm.updateDiaperChange(diaperChange: enteredDiaperCHange, f: !fecesToggle, u: !urineToggle, t: time)
                    resetVars()
                } label: {
                    Text("Speichern")
                        .fontWeight(.heavy)
                        .font(.system(size: 15))
                        .background(RoundedRectangle(cornerRadius: vi.getCR())
                                        .fill(Color(hex: vi.getBabyBlueColor()))
                                        .frame(width: 150, height: 50, alignment: .center)
                                        .overlay(RoundedRectangle(cornerRadius: vi.getCR()).stroke(Color(hex: vi.getDarkBlueColor()), lineWidth: 1)))
                }.padding()
                
            }.padding()
            
        }.padding()
    }
}
