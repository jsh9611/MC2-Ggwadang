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
            List {
                if store.records.filter{ $0.date == "\(dateFormatter(date: today))" }.isEmpty {
                    Text("기록을 시작해보세요!")
                        .listRowBackground(Color.clear)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                ForEach(store.records.filter{ $0.date == "\(dateFormatter(date: today))" }) { record in
                    RecordRow(record: record)
                        .listRowBackground(Color.clear)
                        .swipeActions(edge: .trailing) {
                            Button(action: {
                                store.delete(id: record.id)
                            }) {
                                Image(systemName: "trash")
                            }.tint(.red)
                        }
                }
                
            }
            .navigationTitle("\(today, formatter: MainView.dateFormat)")
            .onAppear {
                UITableView.appearance().backgroundColor = UIColor.white
            }
            Spacer()
        }
    }
}

struct RecordRow: View {
    let record: Record
    
    var body: some View {
        HStack {
            VStack (alignment: .leading){
                Text("\(record.small)")
                Text("\(String(format: "%1.f", record.foodAmount))\(record.unit)")
                    .font(.system(size:13))
            }
            Spacer()
            Text("당류 \(String(format: "%.1f", record.calculatedSugar))g")
        }.frame(height: 50)
    }
}

