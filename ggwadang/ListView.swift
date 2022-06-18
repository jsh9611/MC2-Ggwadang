//
//  ListView.swift
//  ggwadang
//
//  Created by kimjimin on 2022/06/16.
//

import SwiftUI
import RealmSwift

struct ListView: View {
    @EnvironmentObject var store: RecordStore
    @EnvironmentObject var food: FoodStore
    @State var isPresented = false
    
    var body: some View {
        VStack{
            List {
                if store.records.isEmpty {
                    Text("List is now empty...")
                }
                ForEach(store.records) { record in
                    RecordRow(record: record)
                }
            }
            Spacer()
            Button {
                isPresented.toggle()
            } label: {
                Image(systemName: "plus")
            }
            .fullScreenCover(isPresented: $isPresented, content: {LargeCategoryView(isPresented: self.$isPresented).environmentObject(self.store)})
        }
    }
    
}

struct FoodRow: View {
//    @EnvironmentObject var food: FoodStore
    let record: Food
    
    var body: some View {
        HStack {
            Text("\(record.large) > \(record.medium) > \(record.small) / \(record.sugarPerGram)")
        }
    }
}

struct RecordRow: View {
    @EnvironmentObject var store: RecordStore
    let record: Record
    
    var body: some View {
        HStack {
            Text("\(record.large) > \(record.medium) > \(record.small) / \(record.date)")
            Spacer()
            Text("\(record.calculatedSugar, specifier: "%.1f")g").bold()
            Button(action: deleteRecord) {
                Image(systemName: "trash.circle.fill")
            }
        }
    }
}

extension RecordRow {
    func deleteRecord() {
        withAnimation {
            store.delete(id: record.id)
        }
    }
}

