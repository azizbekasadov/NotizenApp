//
//  HeaderView.swift
//  NotizenApp Watch App
//
//  Created by Azizbek Asadov on 05.10.2025.
//

import SwiftUI

struct HeaderView: View {
    var title: String = ""
    
    var body: some View {
        VStack {
            if !title.isEmpty {
                Text(title.uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.accent)
            }
            
            HStack {
                Capsule()
                    .frame(height: 1)
                
                Image(systemName: "note.text")
                
                Capsule()
                    .frame(height: 1)
            }
            .foregroundStyle(.accent)
            .padding(.bottom, 3)
        }
    }
}
