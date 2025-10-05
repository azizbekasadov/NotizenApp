//
//  CreditsView.swift
//  NotizenApp Watch App
//
//  Created by Azizbek Asadov on 05.10.2025.
//

import SwiftUI

struct CreditsView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
            Image(systemName: "figure.run.square.stack.fill")
                .imageScale(.large)
            
            HeaderView(title: "Credits")
            
            Text("Azizbek A. Zürich, Schwiiz 2025")
                .lineLimit(nil)
                .foregroundStyle(.primary)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
            
            Text("Azizbek A. Zürich, Schwiiz 2025")
                .font(.footnote)
                .lineLimit(nil)
                .foregroundStyle(.secondary)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    CreditsView()
}
