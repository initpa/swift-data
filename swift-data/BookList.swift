//
//  BookList.swift
//  swift-data
//
//  Created by Nitesh Patil on 04/06/24.
//

import SwiftUI
import SwiftData

struct BookList: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Book.status) private var books: [Book]
    
    init(sortOrder: SortOrder) {
        let sortDescriptors: [SortDescriptor<Book>] = switch sortOrder {
        case .status:
            [SortDescriptor(\Book.status), SortDescriptor(\Book.title)]
        case .title:
            [SortDescriptor(\Book.title)]
        case .author:
            [SortDescriptor(\Book.author)]
        }
        _books = Query(sort: sortDescriptors)
    }
    
    var body: some View {
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
    }
}

#Preview {
    let preview = Preview(Book.self)
    preview.addExamples(Book.sampleBooks)
    
    return NavigationStack {
        BookList(sortOrder: .status)
    }
        .modelContainer(preview.container)
}
