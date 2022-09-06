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
                }
                
                ForEach(store.records.filter{ $0.date == "\(dateFormatter(date: today))" }) { record in
                    RecordRow(record: record)
                        .listRowBackground(Color.clear)
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
    @EnvironmentObject var store: RecordStore
    @State private var showAlert = false
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
            Button(action: {showAlert.toggle()}) {
                Image(systemName: "trash.fill")
            }
            .alert("기록 삭제", isPresented: $showAlert) {
                Button("삭제", role: .destructive) {deleteRecord()}
                Button("취소", role: .cancel) {}
            } message: {
                Text("'\(record.small)'을/를 삭제하시겠습니까?")
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}

extension RecordRow {
    func deleteRecord() {
        store.delete(id: record.id)
    }
}

