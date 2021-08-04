//
//  NutbyViewModel.swift
//  Nutby
//
//  Created by Diren Akgöz on 17.05.21.
//

import SwiftUI
import CoreData

class ViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedBabies : [Babies] = []
    @Published var savedFeedings : [Feedings] = []
    @Published var savedDiaperChanges : [DiaperChange] = []
    
    init() {
        container = NSPersistentContainer(name: "NutbyContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            }
        }
        fetchBabies()
        fetchFeedings()
        fetchDiaperChanges()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchBabies()
            fetchFeedings()
            fetchDiaperChanges()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
    
    
    // -: BABYMANAGEMENT
    func addBaby(fn: String, ln: String, g: Bool, bD: Date, i: UIImage) -> Void {
        let newBaby = Babies(context: container.viewContext)
        newBaby.firstName = fn
        newBaby.lastName = ln
        newBaby.birthDate = bD
        newBaby.picture = i.jpegData(compressionQuality: 1.0)
        
        if(g == true) {
            newBaby.gender = "Weiblichh"
        } else {
            newBaby.gender = "Männlich"
        }
        saveData()
    }
    
    func updateBaby(entity: Babies, f: String, l: String, date: Date, image: UIImage) {
        entity.firstName = f
        entity.lastName = l
        entity.birthDate = date
        entity.picture = image.jpegData(compressionQuality: 1.0)
        saveData()
    }
    
    func deleteBaby(indexSet: IndexSet){
        guard let index = indexSet.first else { return }
        let entity = savedBabies[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func fetchBabies() {
        let request = NSFetchRequest<Babies>(entityName: "Babies")
        
        do {
            savedBabies = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
     
    // -: FEEDINGMANAGEMENT
    func addFeeding(t: Date, ml: Float, enteredBaby: Babies) -> Void {
        let newFeeding = Feedings(context: container.viewContext)
        newFeeding.time = t
        newFeeding.milliliter = ml
        newFeeding.baby = enteredBaby
        saveData()
    }
    
    func updateFeeding(feeding: Feedings, t: Date, ml: Float) {
        feeding.time = t
        feeding.milliliter = ml
        saveData()
    }
    
    func deleteFeeding(indexSet: IndexSet){
        guard let index = indexSet.first else { return }
        let entity = savedFeedings[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func fetchFeedings() {
        let request = NSFetchRequest<Feedings>(entityName: "Feedings")
        
        do {
            savedFeedings = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func getLastFeedingOf_Condition(baby: Babies) -> Feedings? {
        savedFeedings.last { (feeding) -> Bool in
            feeding.baby == baby
        }
    }
    
    func getSavedFeedings_Sorted() -> [Feedings] {
        var feedingList = savedFeedings
        feedingList.sort { (f1: Feedings, f2: Feedings) -> Bool in
            f1.time! >= f2.time!
        }
        return feedingList
    }
    
    func getSavedFeedings_Sorted(baby: Babies, isReset: Bool) -> [Feedings] {
        
        if(isReset) {
            return getSavedFeedings_Sorted()
        }
        
        var feedingList = getSavedFeedings_Sorted()
        feedingList.removeAll { (feeding) -> Bool in
            feeding.baby != baby
        }

        return feedingList
    }
    
    func getSavedFeedingNumbersFromTo(baby: Babies, from: Date, to: Date) -> [Double] {
        var feedings_List : [Double] = []

        getSavedFeedings_Sorted().forEach { (feeding) in
            if((Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: feeding.time!)! >= Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: from)!)
                && ((Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: feeding.time!)! <= Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: to)!))
                && (feeding.baby == baby)) {
                
                feedings_List.append(Double(feeding.milliliter))
            }
        }
        
        return feedings_List.reversed()
    }
    
    func getSavedFeedingNumbers() -> [Double] {
        var feedings_List : [Double] = []

        getSavedFeedings_Sorted().forEach { (feeding) in
            feedings_List.append(Double(feeding.milliliter))
        }
        
        return feedings_List
    }
    
    
    // -: DIAPERMANAGEMENT
    func addDiaperChange(f: Bool, u: Bool, t: Date, enteredBaby: Babies) -> Void {
        let newDiaperChange = DiaperChange(context: container.viewContext)
        newDiaperChange.feces = f
        newDiaperChange.urine = u
        newDiaperChange.time = t
        newDiaperChange.baby = enteredBaby
        saveData()
    }
    
    func updateDiaperChange(diaperChange: DiaperChange, f: Bool, u: Bool, t: Date) {
        diaperChange.feces = f
        diaperChange.urine = u
        diaperChange.time = t
        saveData()
    }
 
    func deleteDiaperChange(indexSet: IndexSet){
        guard let index = indexSet.first else { return }
        let entity = savedDiaperChanges[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func fetchDiaperChanges() {
        let request = NSFetchRequest<DiaperChange>(entityName: "DiaperChange")
        
        do {
            savedDiaperChanges = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func getLastDiaperChangeOf_Condition(baby: Babies) -> DiaperChange? {
        savedDiaperChanges.last { (diaperChange) -> Bool in
            diaperChange.baby == baby
        }
    }
    
    func getSavedDiaperChanges_Sorted() -> [DiaperChange] {
        var diaperChangeList = savedDiaperChanges
        diaperChangeList.sort { (dc1: DiaperChange, dc2: DiaperChange) -> Bool in
            dc1.time! >= dc2.time!
        }
        return diaperChangeList
    }
    
    func getSavedDiaperChangeNumbersFromTo(baby: Babies, from: Date, to: Date, u: Bool, f: Bool) -> Double {
        var diaperChange_List_Numbers = [DiaperChange]()
        savedDiaperChanges.forEach { (dc) in
            if((Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: dc.time!)! >= Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: from)!)
                && ((Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: dc.time!)! <= Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: to)!)
                && (dc.urine == !u)
                && (dc.feces == !f)
                && (dc.baby == baby))) {
            
                diaperChange_List_Numbers.append(dc)
            }
        }
        
        return Double(diaperChange_List_Numbers.count)
    }
    
    func getSavedDiaperChanges_Sorted(baby: Babies, isReset: Bool) -> [DiaperChange] {
        
        if(isReset) {
            return getSavedDiaperChanges_Sorted()
        }
        
        var diaperChangeList = getSavedDiaperChanges_Sorted()
        diaperChangeList.removeAll { (dc) -> Bool in
            dc.baby != baby
        }

        return diaperChangeList
    }
}
