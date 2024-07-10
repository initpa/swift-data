//
//  ContentView.swift
//  swift-data
//
//  Created by Nitesh Patil on 03/06/24.
//

import SwiftUI
import SwiftData

enum SortOrder: LocalizedStringResource, Identifiable, CaseIterable {
    case status, title, author
    var id: Self {
        self
    }
}

struct BookListView: View {
    @State private var createNewBook = false
    @State private var sortOrder = SortOrder.status
    @State private var filter = ""
    
    var body: some View {
        NavigationStack {
            Picker("", selection: $sortOrder) {
                ForEach(SortOrder.allCases) { sortOrder in
                    Text("Sort by: \(sortOrder.rawValue)").tag(sortOrder)
                }
            }
            .buttonStyle(.bordered)
            BookList(sortOrder: sortOrder, filterString: filter)
                .searchable(text: $filter, prompt: Text("filter on title or author"))
            .listStyle(.plain)
            .padding()
            .navigationTitle("MyBooks")
            .toolbar{
                Button {
                    createNewBook = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                }
            }
            .sheet(isPresented: $createNewBook) {
                NewBookView()
                    .presentationDetents([.medium])
            }
        }
    }
}

#Preview("English") {
    let preview = Preview(Book.self)
    let books = Book.sampleBooks
    let genres = Genre.samplesGenres
    preview.addExamples(books)
    preview.addExamples(genres)
    return BookListView()
        .modelContainer(preview.container)
}

#Preview("German") {
    let preview = Preview(Book.self)
    let books = Book.sampleBooks
    let genres = Genre.samplesGenres
    preview.addExamples(books)
    preview.addExamples(genres)
    return BookListView()
        .modelContainer(preview.container)
        .environment(\.locale, Locale(identifier: "DE"))
}

