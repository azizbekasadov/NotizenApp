//
//  Note.swift
//  NotizenApp Watch App
//
//  Created by Azizbek Asadov on 05.10.2025.
//

import Foundation

struct Note: Identifiable, Hashable, Codable {
    let id: UUID
    let text: String
    let createdAt: Date
    var updatedAt: Date? = nil
    ///
    ///
    init(
        id: UUID = UUID(),
        text: String,
        createdAt: Date = Date(),
        updatedAt: Date? = nil
    ) {
        self.id = id
        self.text = text
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
