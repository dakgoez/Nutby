//
//  UrineToggleStyle.swift
//  Nutby
//
//  Created by Diren Akgöz on 26.07.21.
//

import Foundation
import SwiftUI

struct YesOrNoToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Button {
                configuration.isOn.toggle()
            } label: {
                ToggleItem(isOn: configuration.isOn)
            }
        }
    }
    
    struct ToggleItem: View {

        var isOn = false
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(hex: vi.getDarkBlueColor()))
                    .frame(width: 250, height: 30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: vi.getDarkBlueColor()))
                            .frame(width: 125, height: 30),
                        alignment: isOn ? .trailing : .leading)
                    .animation(.linear(duration: 0.2))
                
                HStack(spacing: 0) {
                    Text("Ja")
                        .frame(width: 250/2, height: 30, alignment: .center)
                        .foregroundColor(isOn ? Color(hex: vi.getDarkBlueColor()) : Color.white)
                        .animation(.linear(duration: 0.2))
                    
                    Text("Nein")
                        .frame(width: 250/2, height: 30, alignment: .center)
                        .foregroundColor(isOn ? Color.white : Color(hex: vi.getDarkBlueColor()))
                        .animation(.linear(duration: 0.2))
                }
            }
        }
    }
}

