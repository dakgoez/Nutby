//
//  BabyInformationView.swift
//  Nutby
//
//  Created by Diren Akgöz on 21.07.21.
//

import SwiftUI
import SwiftUICharts

struct BabyInformationView : View {
    
    @State var enteredBaby: Babies
    @ObservedObject var vm : ViewModel
    @State var showingPopover : Bool = false
    
    var body: some View {
        
        ScrollView(.vertical) {
            Baby_Info_View(baby: enteredBaby, vm: vm)
                .onTapGesture {
                    showingPopover = true
                }
                .popover(isPresented: $showingPopover) {
                    EditBabyView(enteredBaby: enteredBaby, vm: vm)
                }
                .padding()
            
            FeedingDiagram(baby: enteredBaby, vm: vm).padding()
            
            Spacer().frame(height: 25)
            
            DiaperChangeDiagram(baby: enteredBaby, vm: vm).padding()

            Spacer().frame(height: 100)
        }

    }
}

struct Baby_Info_View : View {
    
    @State var baby: Babies
    @State var vm: ViewModel
    
    var body: some View {

        ZStack() {
            RoundedRectangle(cornerRadius: vi.getCR())
                .fill(Color(hex: vi.getBabyBlueColor()))
                .overlay(RoundedRectangle(cornerRadius: vi.getCR()).stroke(Color(hex: vi.getDarkBlueColor()), lineWidth: 2))
                .frame(height: 175, alignment: .center)
            
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    vi.getPicture(enteredBaby: baby, uiPicture: UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 75, height: 75)
                        .clipShape(Circle())
                        .background(Circle()
                                        .strokeBorder(Color(hex: vi.getDarkBlueColor()),lineWidth: 4)
                                        .background(Circle()
                                        .foregroundColor(Color(hex: vi.getBabyBlueColor()))))
            
                    VStack(alignment: .leading) {
                        Text(baby.firstName! + " " + baby.lastName!)
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                        
                        Spacer().frame(height: 10)
                        
                        Text("Geschlecht:\t" + baby.gender!).fontWeight(.medium)
                        HStack(spacing: 0) {
                            Text("Geboren am:\t").fontWeight(.medium)
                            Text(baby.birthDate!, formatter: vi.getDateFormatter_Date()).fontWeight(.medium)
                        }
                    }.padding()
                }
                HStack {
                    Text("Zuletzt gefüttert:\t").fontWeight(.medium)
                    if (vm.getLastFeedingOf_Condition(baby: baby) == nil) {
                        Text("...").fontWeight(.medium)
                    } else {
                        Text(vm.getSavedFeedings_Sorted().first(where: { (f: Feedings) -> Bool in
                            f.baby == baby
                        })!.time!, formatter: vi.getDateFormatter_DateAndTime())
                            .fontWeight(.medium)
                    }
                }
                HStack {
                    Text("Zuletzt gewickelt:\t").fontWeight(.medium)
                    if (vm.getLastDiaperChangeOf_Condition(baby: baby) == nil) {
                        Text("...").fontWeight(.medium)
                    } else {
                        Text(vm.getSavedDiaperChanges_Sorted().first(where: { (dc: DiaperChange) -> Bool in
                            dc.baby == baby
                        })!.time!, formatter: vi.getDateFormatter_DateAndTime())
                            .fontWeight(.medium)
                    }
                }
            }
            .foregroundColor(Color(hex: vi.getDarkBlueColor()))
        }
    }
}

struct FeedingDiagram : View  {
    @State var baby: Babies
    @State var vm: ViewModel
    @State var fromDate = Date()
    @State var toDate = Date()
    
    var body: some View {
        
        VStack {
            
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: vi.getCR())
                    .fill(Color(.white))
                    .overlay(RoundedRectangle(cornerRadius: vi.getCR()).stroke(Color(hex: vi.getDarkBlueColor()), lineWidth: 2))
                    .frame(height: 350, alignment: .center)
                
                VStack {
                    if(vm.getSavedFeedingNumbersFromTo(baby: baby, from: fromDate, to: toDate) == []){
                        LineView(data: [0], title: "\tFütterung").padding() // Github: SwiftUI Charts
                    } else {
                        LineView(data: vm.getSavedFeedingNumbersFromTo(baby: baby, from: fromDate, to: toDate), title: "\tFütterung").padding()
                    }
                }
            }
            
            HStack {
                Text("Von:")
                DatePicker("", selection: $fromDate,  in: ...Date(), displayedComponents: .date)
                    .fixedSize()
                    .datePickerStyle(DefaultDatePickerStyle())
                    .foregroundColor(Color(hex: vi.getDarkBlueColor()))
                Text("Bis:")
                DatePicker("", selection: $toDate,  in: ...Date(), displayedComponents: .date)
                    .fixedSize()
                    .datePickerStyle(DefaultDatePickerStyle())
                    .foregroundColor(Color(hex: vi.getDarkBlueColor()))
            }.foregroundColor(Color(hex: vi.getDarkBlueColor()))
        }
    }
}


struct DiaperChangeDiagram : View  {
    @State var baby: Babies
    @State var vm: ViewModel
    @State var fromDate = Date()
    @State var toDate = Date()
    @State var urine : Bool = true
    @State var feces : Bool = true
    
    var body: some View {
        
        VStack {
        
            ZStack() {
                RoundedRectangle(cornerRadius: vi.getCR())
                    .fill(Color(.white))
                    .overlay(RoundedRectangle(cornerRadius: vi.getCR()).stroke(Color(hex: vi.getDarkBlueColor()), lineWidth: 2))
                    .frame(height: 50, alignment: .center)
                
                HStack {
                    Text("Anzahl der Windelwechsel:")
                    Text(String(format: "%.0f",(vm.getSavedDiaperChangeNumbersFromTo(baby: baby, from: fromDate, to: toDate, u: urine, f: feces))))
                }
            }
            Spacer().frame(height: 10)
            VStack {
                HStack {
                    Text("Mit Urin?")
                    Spacer()
                    Toggle(isOn: $urine) {
                    }.toggleStyle(YesOrNoToggleStyle())
                }
                
                HStack {
                    Text("Mit Stuhlgang?")
                    Spacer()
                    Toggle(isOn: $feces) {
                    }.toggleStyle(YesOrNoToggleStyle())
                }
                
                HStack {
                    Text("Von:")
                    DatePicker("", selection: $fromDate,  in: ...Date(), displayedComponents: .date)
                        .fixedSize()
                        .datePickerStyle(DefaultDatePickerStyle())
                        .foregroundColor(Color(hex: vi.getDarkBlueColor()))
                    
                    Text("Bis:")
                    DatePicker("", selection: $toDate,  in: ...Date(), displayedComponents: .date)
                        .fixedSize()
                        .datePickerStyle(DefaultDatePickerStyle())
                        .foregroundColor(Color(hex: vi.getDarkBlueColor()))
                }
            }
        }
        .foregroundColor(Color(hex: vi.getDarkBlueColor()))
    }
}


struct BabyInformationView_Previews: PreviewProvider {
    static var previews: some View {
        BabyInformationView(enteredBaby: Babies(), vm: ViewModel())
    }
}
