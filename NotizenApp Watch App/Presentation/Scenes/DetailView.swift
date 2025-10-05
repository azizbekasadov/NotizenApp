//
//  DetailView.swift
//  NotizenApp Watch App
//
//  Created by Azizbek Asadov on 05.10.2025.
//

import SwiftUI

struct DetailView: View {
    @State private var isCreditsPresented = false
    @State private var isSettingsPresented = false
    
    let note: Note
    let count: Int
    let index: Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
            HeaderView()
            
            ScrollView(.vertical) {
                Text(note.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            
            FooterView()
        }
        .padding(3)
    }
    
    @ViewBuilder
    private func FooterView() -> some View {
        HStack(alignment: .center) {
            Button {
                isSettingsPresented.toggle()
            } label: {
                Image(systemName: "gear")
                    .imageScale(.large)
            }
            .buttonStyle(.plain)
            
            Spacer()
            
            Text("\(index + 1) / \(count)")
            
            Spacer()
            
            Button {
                isCreditsPresented.toggle()
            } label: {
                Image(systemName: "info.circle")
                    .imageScale(.large)
            }
            .buttonStyle(.plain)
        }
        .foregroundStyle(.secondary)
        .sheet(isPresented: $isCreditsPresented) {
            CreditsView()
        }
        .sheet(isPresented: $isSettingsPresented) {
            SettingsView()
        }
    }
}

#Preview {
    DetailView(
        note: Note(text: "Hello World!"),
        count: 5,
        index: 0
    )
}
