//
//  FileManagerStorageService.swift
//  NotizenApp Watch App
//
//  Created by Azizbek Asadov on 05.10.2025.
//

import Foundation

final class FileManagerStorageService: NSObject, StorageService {

    enum FileManagerStorageServiceError: Error {
        case invalidDocumentDirectory
        case other(String)
    }
    
    @discardableResult
    func fetch<T: Codable>() async -> Result<[T], Error> {
        guard let documentDirectory = getDocumentDirectory() else {
            return .failure(FileManagerStorageServiceError.invalidDocumentDirectory)
        }

        do {
            let url = documentDirectory.appendingPathComponent("\(T.self)".lowercased())
            let data = try Data(contentsOf: url)
            let result = try JSONDecoder().decode([T].self, from: data)
            return .success(result)
        } catch {
            return .failure(FileManagerStorageServiceError.other(error.localizedDescription))
        }
    }
    
    @discardableResult
    func save<T: Codable>(_ input: [T]) async -> Result<[T], Error> {
        guard let documentDirectory = getDocumentDirectory() else {
            return .failure(FileManagerStorageServiceError.invalidDocumentDirectory)
        }

        do {
            let data = try JSONEncoder().encode(input)
            let url = documentDirectory.appendingPathComponent("\(T.self)".lowercased())
            try data.write(to: url)
            let updatedRecords: Result<[T], Error> = await self.fetch()
            return updatedRecords
        } catch {
            return .failure(FileManagerStorageServiceError.other(error.localizedDescription))
        }
    }
    
    private func getDocumentDirectory() -> URL? {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return path
    }
}
