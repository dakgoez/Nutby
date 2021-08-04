//
//  ParentView.swift
//  Nutby
//
//  Created by Diren Akgöz on 21.06.21.
//

import SwiftUI

extension TabView {
    func tintColor(color: UIColor) -> some View {
        UITabBar.appearance().barTintColor = color
        UITabBar.appearance().unselectedItemTintColor = .black
        return self
    }
}

extension UITabBarController {

}

struct ParentView: View {
    @ObservedObject var vm : ViewModel
    @State private var selectedTab = 0
    var vi = ViewInformation()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            Feedinglist(vm: vm)
                .tabItem {
                    Label("Fütterungen", systemImage: "mouth")
                }
                .tag(0)
            
            DiaperChangelist(vm: vm)
                .tabItem {
                    Label("Windelwechsel", systemImage: "arrow.left.arrow.right")
                }
                .tag(1)
            
            Babylist(vm: vm)
                .tabItem {
                    Label("Babies", systemImage: "face.smiling")
                }
                .tag(2)
        }
        .tintColor(color: vi.getBabyBlueUIC())
        .accentColor(Color(vi.getDarkBlueUIC()))
    }
}

struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView(vm: ViewModel())
    }
}
