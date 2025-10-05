//
//  SettingsView.swift
//  NotizenApp Watch App
//
//  Created by Azizbek Asadov on 05.10.2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("lineCount") private var lineCount: Int = 1
    @State private var value: Float = 1.0
    
    var body: some View {
        VStack(spacing: 8) {
            HeaderView(title: "Settings")
            
            Text("Lines: \(lineCount)".uppercased())
                .fontWeight(.bold)
            
            Slider(value: Binding(get: {
                return value
            }, set: { value in
                self.value = value
                self.update()
            }), in: 1...4, step: 1)
                .foregroundStyle(.accent)
            
            
        }
    }
    
    private func update() {
        lineCount = Int(value)
    }
}

#Preview {
    SettingsView()
}
