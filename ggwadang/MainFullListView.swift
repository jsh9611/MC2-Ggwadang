//
//  MainFullListView.swift
//  ggwadang
//
//  Created by Hyemin Choi on 2022/06/17.
//

import SwiftUI
import RealmSwift

struct MainFullListView: View {
    @EnvironmentObject var store: RecordStore    
    
    var body: some View {
        VStack{
            Text("\(today, formatter: MainView.dateFormat)").font(.headline)
            List {
                if store.records.isEmpty {
                    Text("기록을 시작해보세요!")
                        .listRowBackground(Color.clear)
                }
                
                ForEach(store.records.filter{ $0.date == "\(dateFormatter(date: today))" }) { record in
                    RecordRow(record: record)
                        .listRowBackground(Color.clear)
                }
            }
            .onAppear{
                UITableView.appearance().backgroundColor = UIColor.white
            }
            Spacer()
        }
    }
}


struct RecordRow: View {
    @EnvironmentObject var store: RecordStore
    let record: Record
    var body: some View {
        HStack {
            VStack (alignment: .leading){
                Text("\(record.small)")
                Text("\(String(format: "%.1f", record.foodAmount))\(record.unit)")
                    .font(.system(size:13))
            }
            Spacer()
            Text("당류 \(String(format: "%.1f", record.calculatedSugar))g")
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

