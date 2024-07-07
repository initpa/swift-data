//
//  GenreView.swift
//  swift-data
//
//  Created by Nitesh Patil on 07/07/24.
//

import SwiftUI
import SwiftData

struct GenreView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Bindable var book: Book
    @Query(sort: \Genre.name) var genres: [Genre]
    
    
    var body: some View {
        NavigationStack {
            Group {
                if genres.isEmpty {
                    ContentUnavailableView {
                        Image(systemName: "bookmark.fill")
                            .font(.largeTitle)
                    } description: {
                        Text("You need to create some genres")
                    } actions: {
                        Button("Create Genre") {
                            
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    List {
                        ForEach(genres) { genre in
                            HStack {
                                if let bookGenres = book.genres {
                                    if bookGenres.isEmpty {
                                        Button {
                                            addRemove(genre)
                                        } label: {
                                            Image(systemName: "circle")
                                        }
                                        .foregroundStyle(genre.hexColor)
                                    } else {
                                        Button {
                                            addRemove(genre)
                                        } label: {
                                            Image(systemName: bookGenres.contains(genre) ? "circle.fill" : "circle")
                                        }
                                        .foregroundStyle(genre.hexColor)
                                    }
                                }
                                Text(genre.name)
                            }
                        }
                    }
                }
            }
            .navigationTitle(book.title)
        }
    }
    
    func addRemove(_ genre: Genre) {
        if let bookGenres = book.genres {
            if bookGenres.isEmpty {
                book.genres?.append(genre)
            } else {
                if bookGenres.contains(genre),
                   let index = bookGenres.firstIndex(where: {$0.id == genre.id}) {
                    book.genres?.remove(at: index)
                } else {
                    book.genres?.append(genre)
                }
            }
        }
    }
}

#Preview {
    let preview = Preview(Book.self)
    let books = Book.sampleBooks
    let genres = Genre.samplesGenres
    preview.addExamples(genres)
    preview.addExamples(books)
    books[1].genres?.append(genres[0])
    return GenreView(book: books[1])
        .modelContainer(preview.container)
}
