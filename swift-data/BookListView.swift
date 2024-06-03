//
//  ContentView.swift
//  swift-data
//
//  Created by Nitesh Patil on 03/06/24.
//

import SwiftUI
import SwiftData

struct BookListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Book.title) private var books: [Book]
    @State private var createNewBook = false
    
    var body: some View {
        NavigationStack {
            Group {
                if books.isEmpty {
                    ContentUnavailableView("Please enter a book", systemImage: "book.fill")
                } else {
                    List {
                        ForEach(books) { book in
                            NavigationLink {
                                Text(book.title)
                                EditBookView(book: book)
                            } label: {
                                HStack(spacing: 10) {
                                    book.icon
                                    VStack(alignment: .leading) {
                                        Text(book.title).font(.title)
                                        Text(book.author).foregroundStyle(.secondary)
                                        
                                        if let rating = book.rating {
                                            HStack {
                                                ForEach(1..<rating, id: \.self) {_ in
                                                    Image(systemName: "star.fill")
                                                        .imageScale(.small)
                                                        .foregroundStyle(.yellow)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .onDelete{ indexSet in
                            indexSet.forEach { index in
                                let book = books[index]
                                context.delete(book)
                            }
                        }
                    }
                    
                }
                
            }
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

#Preview {
    BookListView()
        .modelContainer(for: Book.self, inMemory: true)
}
