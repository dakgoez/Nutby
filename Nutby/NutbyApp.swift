//
//  NutbyApp.swift
//  Nutby
//
//  Created by Diren Akgöz on 17.05.21.
//

import SwiftUI

@main
struct NutbyApp: App {
    var body: some Scene {
        WindowGroup {
            //Babylist(vm: NutbyViewModel())
            ParentView(vm : ViewModel())
        }
    }
}
