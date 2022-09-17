//
//  HomeView.swift
//  ggwadang
//
//  Created by kimjimin on 2022/06/19.
//

import SwiftUI
import RealmSwift

struct HomeView: View {
    @State private var todaySugarValue: Double = 0
    @Binding var isPresented: Bool
    
    let realm = try! Realm()
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .bottom) {
                    MainView(todaySugarValue: $todaySugarValue, isPresented: $isPresented)
                    StatusView(todaySugarValue: $todaySugarValue, isPresented: $isPresented).padding(.bottom, 20)
                }
                MainListView(isPresented: $isPresented)
            }
            
            // MARK: - 시트를 닫으면 데이터 값 갱신
            .onChange(of: isPresented) { sheetIsOn in
                if sheetIsOn { return }

                let userRecords = realm.objects(RecordDB.self).filter("date == '\(yyyyMMdd(date: Date()))'")
                var sum : Double = 0
                for temp in userRecords {
                    sum += temp.calculatedSugar
                }
                todaySugarValue = sum
            }
            
            // MARK: - 시트가 등장하면 값 갱신
            .onAppear {
                let userRecords = realm.objects(RecordDB.self).filter("date == '\(yyyyMMdd(date: Date()))'")
                var sum : Double = 0
                for temp in userRecords {
                    sum += temp.calculatedSugar
                }
                todaySugarValue = sum
            }
            
            // MARK: - 백그라운드로 들어갔다가 켜졌을 때 업데이트 한다
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                print("나갔다 들어왓더니 업데이트 했어요")
                let userRecords = realm.objects(RecordDB.self).filter("date == '\(yyyyMMdd(date: Date()))'")
                var sum : Double = 0
                for temp in userRecords {
                    sum += temp.calculatedSugar
                }
                todaySugarValue = sum
            }
        }
    }
}
extension HomeView {
    func yyyyMMdd(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let converted = formatter.string(from: date)
        return converted
    }
}
