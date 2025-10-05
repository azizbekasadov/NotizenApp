//
//  StorageService.swift
//  NotizenApp Watch App
//
//  Created by Azizbek Asadov on 05.10.2025.
//

import Foundation

protocol StorageService {
    @discardableResult
    func fetch<T: Codable>() async -> Result<[T], Error>
    
    @discardableResult
    func save<T: Codable>(_ input: [T]) async -> Result<[T], Error> 
}
