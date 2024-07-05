//
//  QuotesListView.swift
//  swift-data
//
//  Created by Nitesh Patil on 03/07/24.
//

import SwiftUI

struct QuotesListView: View {
    @Environment(\.modelContext) private var modelContext
    let book: Book
    @State private var text = ""
    @State private var page = ""
    @State private var selectedQuote: Quote?
    var isEditing: Bool {
        selectedQuote != nil
    }
    
    var body: some View {
        GroupBox {
            HStack {
                LabeledContent("Page") {
                    TextField("Page #", text: $page)
                        .autocorrectionDisabled()
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 150)
                    Spacer()
                }
                
                if isEditing {
                    Button("cancel") {
                        page = ""
                        text = ""
                        selectedQuote = nil
                    }
                    .buttonStyle(.bordered)
                }
                
                Button(isEditing ? "Update" : "Create") {
                    if isEditing {
                        selectedQuote?.text = text
                        selectedQuote?.page = page.isEmpty ? nil : page
                        page = ""
                        text = ""
                        selectedQuote = nil
                    } else {
                        let quote = page.isEmpty ? Quote(text: text) : Quote(text: text, page: page)
                        book.quotes?.append(quote)
                        text = ""
                        page = ""
                        selectedQuote = nil
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(text.isEmpty)
            }
            
            TextEditor(text: $text)
                .border(.secondary)
                .frame(height: 100)
        }
        .padding(.horizontal)
        List {
            let sortedQuotes = book.quotes?.sorted(using: KeyPathComparator(\Quote.creationDate)) ?? []
            ForEach(sortedQuotes) { quote in
                VStack(alignment: .leading) {
                    Text(quote.creationDate, format: .dateTime.month().day().year())
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(quote.text)
                    HStack {
                        Spacer()
                        if let page = quote.page, !page.isEmpty {
                            Text("Page: \(page)")
                        }
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedQuote = quote
                    text = quote.text
                    page = quote.page ?? ""
                }
            }
            .onDelete { indexSet in
                withAnimation {
                    indexSet.forEach { index in
                        if let quote = book.quotes?[index] {
                            modelContext.delete(quote)
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Quotes")
    }
}

#Preview {
    let preview = Preview(Book.self)
    let books = Book.sampleBooks
    preview.addExamples(books)
    return NavigationStack {
        QuotesListView(book: books[4])
            .modelContainer(preview.container)
    }
}
