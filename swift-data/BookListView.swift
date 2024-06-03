//
//  ContentView.swift
//  swift-data
//
//  Created by Nitesh Patil on 03/06/24.
//

import SwiftUI

struct BookListView: View {
    @State private var createNewBook = false
    
    var body: some View {
        NavigationStack {
            VStack {
            }
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
}
