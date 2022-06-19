//
//  StatusView.swift
//  ggwadang
//
//  Created by kimjimin on 2022/06/18.
//

import SwiftUI
import RealmSwift

struct StatusView: View {
    
    // TODO: RecordDB로부터 오늘 먹은 레코드 불러오기 -> 섭취량 계산
    @State private var intakeSugar: Double = 15
    let realm = try! Realm()
    // TODO: AppStorage에 저장된 사용자 목표 섭취량 가져오기
    @AppStorage(StorageKeys.sugar.rawValue) private var sugar : Double = UserDefaults.standard.double(forKey: "sugar")
    
    var body: some View {
        // 오늘 날짜에 대해서만 불러온다.
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .opacity(0.2)
                .frame(width: 350, height: 80)
            HStack {
                VStack {
                    Text("섭취량")
                        .font(.system(size:15, weight: .medium))
                    Spacer()
                        .frame(height: 5)
                    
                    // Double에 맞게 변경(소수점 1자리만 표현! - 소수점 2째자리에서 반올림함)
                    Text("\(String(format: "%.1f", intakeSugar))g")
                        .fontWeight(.bold)
                }
                Spacer()
                    .frame(width: 35)
                Divider()
                    .background(Color.white)
                    .frame(height: 40)
                    .overlay(.white)
                Spacer()
                    .frame(width: 35)
                VStack {
                    Text("목표량")
                        .font(.system(size:15, weight: .medium))
                    Spacer()
                        .frame(height: 5)
                    Text("\((String(format: "%.1f", sugar)))g")
                        .fontWeight(.bold)
                }
                Spacer()
                    .frame(width: 35)
                Divider()
                    .background(Color.white)
                    .frame(height: 40)
                    .overlay(.white)
                Spacer()
                    .frame(width: 35)
                
                VStack {
                    Text("남은 양")
                        .font(.system(size:15, weight: .medium))
                    Spacer()
                        .frame(height: 5)
                    Text("\(String(format: "%.1f", (sugar - intakeSugar)))g")
                        .fontWeight(.bold)
                }
            }
            .foregroundColor(.white)
        }
        .onAppear {
            let userRecords = realm.objects(RecordDB.self).filter("date == '\(yyyyMMdd(date: Date()))'")
            var sum : Double = 0
            for temp in userRecords {
                sum += temp.calculatedSugar
            }
            intakeSugar = sum
        }
    }
    func yyyyMMdd(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let converted = formatter.string(from: date)
        return converted
    }

}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView()
    }
}


