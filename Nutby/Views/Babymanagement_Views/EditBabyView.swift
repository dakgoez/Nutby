//
//  EditBabyView.swift
//  Nutby
//
//  Created by Diren Akgöz on 28.07.21.
//

import Foundation

import SwiftUI

struct EditBabyView: View {
    
    @State var enteredBaby: Babies
    @ObservedObject var vm : ViewModel
    
    var body: some View {
        VStack(spacing: 25) {
            Spacer().frame(height: 10)
            EditBaby_Information()
            EditBaby_EnterFields(vm: vm, enteredBaby: enteredBaby)
            Spacer()
        }
    }
}

struct EditBaby_Information: View {
    var body : some View {
        ZStack {
            RoundedRectangle(cornerRadius: vi.getCR())
                .fill(Color(hex: vi.getBabyBlueColor()))
                .frame(width: vi.getRRWidth(), height: 65, alignment: .top)
                .overlay(RoundedRectangle(cornerRadius: vi.getCR()).stroke(Color(hex: vi.getDarkBlueColor()), lineWidth: 1))
            Text("Bitte füllen Sie die unteren Felder aus, \num die Daten Ihres Babys zu bearbeiten.")
                .font(.system(size: 17))
                .fontWeight(.bold)
                .foregroundColor(Color(hex: vi.getDarkBlueColor()))
        }
    }
}

struct EditBaby_EnterFields: View {
    var vm : ViewModel
    @State var enteredBaby : Babies
    @State private var genderToggle: Bool = false
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var birthDate = Date()
    @State private var image = UIImage(systemName: "camera.circle")?.withTintColor(vi.getDarkBlueUIC(), renderingMode: .alwaysOriginal)
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    
    private func resetVars() {
        genderToggle = false
        firstname = ""
        lastname = ""
        birthDate = Date()
        image = UIImage(systemName: "camera.circle")?.withTintColor(vi.getDarkBlueUIC(), renderingMode: .alwaysOriginal)
    }
    
    private func allPropertiesSelected() -> Bool {
        return (firstname != "" && lastname != "")
    }
    
    var body: some View {
        VStack {
            
            HStack {

                Image(uiImage: image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                    .background(Circle()
                                    .strokeBorder(Color(hex: vi.getDarkBlueColor()),lineWidth: 4)
                                    .background(Circle()
                                    .foregroundColor(Color(hex: vi.getBabyBlueColor()))))
                    .shadow(radius: 10)
                    .onTapGesture { self.shouldPresentActionScheet = true }
                    .sheet(isPresented: $shouldPresentImagePicker) {
                        SUImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, image: self.$image, isPresented: self.$shouldPresentImagePicker)
                    }.actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
                        ActionSheet(title: Text("Auswahl"), message: Text("Bitte wählen Sie Ihren bevorzugten Modus, um ein Profilbild festzulegen."), buttons: [ActionSheet.Button.default(Text("Kamera"), action: {
                                self.shouldPresentImagePicker = true
                                self.shouldPresentCamera = true
                        }), ActionSheet.Button.default(Text("Bibliothek"), action: {
                                self.shouldPresentImagePicker = true
                                self.shouldPresentCamera = false
                        }), ActionSheet.Button.default(Text("Foto löschen"), action: {
                                self.image = UIImage(systemName: "camera.circle")?.withTintColor(vi.getDarkBlueUIC(), renderingMode: .alwaysOriginal)
                        }), ActionSheet.Button.cancel()])
                    }
 
                
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: vi.getCR())
                        .fill(Color(hex: vi.getBabyBlueColor()))
                        .frame(width: vi.getWidth(), height: 50, alignment: .center)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(hex: vi.getDarkBlueColor()), lineWidth: 1))
                        .overlay(Text("Nehmen Sie ein Profilbild von Ihrem Baby auf (optional)")
                                    //.font(.system(size: 15))
                                    .foregroundColor(Color(hex: vi.getDarkBlueColor()))
                                    .fontWeight(.medium))
                }

            }
            
            HStack {
                Text("Geschlecht").foregroundColor(Color(hex: vi.getDarkBlueColor()))
                Spacer()
                Toggle(isOn: $genderToggle) {
                }.toggleStyle(GenderToggleStyle())
            }
            
            HStack {
                Text("Vorname").foregroundColor(Color(hex: vi.getDarkBlueColor()))
                Spacer()
                TextField("\tBitte Vornamen eintragen", text: $firstname)
                    .frame(width: vi.getWidth(), height: vi.getHeight(), alignment: .center)
                    .overlay(RoundedRectangle(cornerRadius: vi.getCR()).stroke(Color(hex: vi.getDarkBlueColor())))
            }

            HStack {
                Text("Nachname").foregroundColor(Color(hex: vi.getDarkBlueColor()))
                Spacer()
                TextField("\tBitte Nachnamen eintragen", text: $lastname)
                    .frame(width: vi.getWidth(), height: vi.getHeight(), alignment: .center)
                    .overlay(RoundedRectangle(cornerRadius: vi.getCR()).stroke(Color(hex: vi.getDarkBlueColor())))
            }
            
            HStack {
                Text("Geburtsdatum").foregroundColor(Color(hex: vi.getDarkBlueColor()))
                Spacer()
                DatePicker("", selection: $birthDate,  in: ...Date(), displayedComponents: .date)
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
                                        .frame(width: vi.getButtonWidth(), height: vi.getButtonHeight(), alignment: .center)
                                        .overlay(RoundedRectangle(cornerRadius: vi.getCR()).stroke(Color(hex: vi.getDarkBlueColor()), lineWidth: 1)))
                }.padding()
                
                Button {
                    if(allPropertiesSelected()) {
                        vm.updateBaby(entity: enteredBaby, f: firstname, l: lastname, date: birthDate, image: image!)
                        resetVars()
                    }
                } label: {
                    Text("Speichern")
                        .fontWeight(.heavy)
                        .font(.system(size: 15))
                        .background(RoundedRectangle(cornerRadius: vi.getCR())
                                        .fill(allPropertiesSelected() ? Color(hex: vi.getBabyBlueColor()) : Color(hex: vi.getLightGray()))
                                        .frame(width: vi.getButtonWidth(), height: vi.getButtonHeight(), alignment: .center)
                                        .overlay(RoundedRectangle(cornerRadius: vi.getCR()).stroke(Color(hex: vi.getDarkBlueColor()), lineWidth: 1)))
                }.padding()
                
            }.padding()
            
        }.padding()
    }
}
