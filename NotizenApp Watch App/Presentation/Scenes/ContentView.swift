//
//  ContentView.swift
//  NotizenApp Watch App
//
//  Created by Azizbek Asadov on 05.10.2025.
//

import SwiftUI

struct ContentView: View {
    private let storageService = FileManagerStorageService()
    
    @AppStorage("lineCount") private var lineCount: Int = 1
    @State private var notes: [Note] = []
    @State private var selectedNote: Note?
    @State private var text: String = ""
    @State private var errorMessage: String?
    
    var body: some View {
        VStack {
            HStack(
                alignment: .center,
                spacing: 6
            ) {
                TextField("Add new note", text: $text)
                
                Spacer()
                
                Button {
                    addNote()
                } label: {
                    Image(systemName: "plus")
                        .font(.headline)
                        .bold()
                        .foregroundStyle(.background)
                        .padding(14)
                }
                .buttonStyle(.plain)
                .frame(maxWidth: .infinity)
                .background(text.isEmpty ? .accent.opacity(0.5) : .accent)
                .clipShape(Circle())
                .disabled(text.isEmpty)
                .fixedSize()
            }
            
            Group {
                if notes.isEmpty {
                    Spacer()
                    Image(systemName: "note.text")
                        .font(.title)
                        .foregroundStyle(.tertiary)
                    Spacer()
                } else {
                    List(selection: $selectedNote) {
                        ForEach(0..<notes.count, id: \.self) { index in
                            NavigationLink {
                                DetailView(
                                    note: notes[index],
                                count: notes.count,
                                    index: index
                                )
                            } label: {
                                HStack {
                                    Capsule()
                                        .frame(width: 4)
                                        .foregroundStyle(.accent)
                                    
                                    Text(notes[index].text)
                                        .font(.caption)
                                        .foregroundStyle(.primary)
                                        .lineLimit(lineCount)
                                }
                            }

                        }
                        .onDelete(perform: deleteNote(offsets:))
                    }
                }
            }
        }
        .navigationTitle("Notizen")
        .onAppear {
            Task {
                await MainActor.run {
                    fetchNotizen()
                }
            }
        }
    }
    
    private func deleteNote(offsets: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offsets)
            
            Task {
                await storageService.save(self.notes)
            }
        }
    }
    
    private func addNote() {
        guard !text.isEmpty else {
            return
        }
        
        let note = Note(text: text)
        notes.append(note)
        text = ""
        
        saveChanges()
    }
    
    private func saveChanges() {
        Task {
            let result = await storageService.save(self.notes)
            
            switch result {
            case .success(let success):
                self.notes = success
            case .failure(let failure):
                errorMessage = failure.localizedDescription
            }
        }
    }
    
    private func fetchNotizen() {
        Task {
            let result: Result<[Note], Error> = await storageService.fetch()
            
            switch result {
            case .success(let success):
                self.notes = success
            case .failure(let failure):
                errorMessage = failure.localizedDescription
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
