//
//  NewBookView.swift
//  swift-data
//
//  Created by Nitesh Patil on 03/06/24.
//

import SwiftUI

struct NewBookView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var author = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Book title", text: $title)
                TextField("Author", text: $author)
                
                Button("Create") {
                    let newBook = Book(title: title, author: author)
                    context.insert(newBook)
                    dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .buttonStyle(.borderedProminent)
                .padding(.vertical)
                .disabled(title.isEmpty || author.isEmpty)
                .navigationTitle("New book")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NewBookView()
}
