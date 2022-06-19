//
//  MainView.swift
//  ggwadang
//
//  Created by seungyeon oh on 2022/06/14.
//

import SwiftUI
import RealmSwift

var today = Date()

// 배경색 선언
let backgroundGreen = LinearGradient(gradient: Gradient(colors: [Color("mint"), Color("green")]), startPoint: .top, endPoint: .bottom)
let backgroundYellow = LinearGradient(gradient: Gradient(colors: [Color("yellow"), Color("orange")]), startPoint: .top, endPoint: .bottom)
let backgroundRed = LinearGradient(gradient: Gradient(colors: [Color("tangerine"), Color("coral")]), startPoint: .top, endPoint: .bottom)
let backgroundBlack = LinearGradient(gradient: Gradient(colors: [Color("gray"), Color("black")]), startPoint: .top, endPoint: .bottom)

struct MainView: View {
    // TODO: RecordDB로부터 오늘 먹은 레코드 불러오기 -> 섭취량 계산
    // TODO: AppStorage에 저장된 사용자 목표 섭취량 가져오기
    @State private var todaySugarValue: Double = 18
//    @State private var sugarGoalValue: Double = 40
    @State var progressValue: Double =  0.9
    @AppStorage(StorageKeys.sugar.rawValue) private var sugar : Double = UserDefaults.standard.double(forKey: "sugar")  // 유저의 설탕값
    let realm = try! Realm()
    //public var testNumber: Float = 9.9
    static var dateFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월 d일"
        return formatter
    }
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color(bgTop(number: progressValue)), Color(bgBottom(number: progressValue))]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        VStack{
            HStack {
                Text(" ")
                    .frame(width: 25, height: 25)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarTitle("", displayMode: .inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("\(today, formatter: MainView.dateFormat)").font(.headline)
                                .foregroundColor(.white)
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: SettingListView()) {
                                Image(systemName: "gearshape")
                                    .foregroundColor(.white)
                            }
                        }
                    }
            }
            ProgressCircleView(progress: self.$progressValue)
            Spacer()
        }
//         오늘의 당(음식 추가한 경우) 진행값 갱신
        .onChange(of: $todaySugarValue.wrappedValue) { _ in
            progressValue = Double(todaySugarValue) / Double(sugar)
        }
        // 유저 설탕 설정값 바뀐 경우 진행값 갱신
        .onChange(of: $sugar.wrappedValue) { _ in
            progressValue = Double(todaySugarValue) / sugar
        }
//        .onChange(of: ) { _ in
//            progressValue = Double(todaySugarValue) / sugar
//        }
        // 뷰가 나타날 때 진행값 갱신
        .onAppear {
            let userRecords = realm.objects(RecordDB.self).filter("date == '\(yyyyMMdd(date: Date()))'")
            var sum : Double = 0
            for temp in userRecords {
                sum += temp.calculatedSugar
            }
            todaySugarValue = sum
            progressValue = Double(todaySugarValue) / sugar
        }

//        .onChange(of: $progressValue.wrappedValue) { _ in
//                .background(backGround(number: progressValue))
//        }
//        .background(backGround(number: progressValue))
    }
    }//end of Body()
    
    //Func backGround()
    func backGround(number: Double) -> LinearGradient {
        if number <= 0.39 {
            return backgroundGreen
        } else if number <= 0.79 {
            return backgroundYellow
        } else if number <= 0.99 {
            return backgroundRed
        } else {
            return backgroundBlack
        }
    }
    //end of backGround()
    
    func bgTop(number: Double) -> String {
        if number <= 0.39 {
            return "mint"
        } else if number <= 0.79 {
            return "yellow"
        } else if number <= 0.99 {
            return "tangerine"
        } else {
            return "gray"
        }
}
    
    func bgBottom(number: Double) -> String {
        if number <= 0.39 {
            return "green"
        } else if number <= 0.79 {
            return "orange"
        } else if number <= 0.99 {
            return "coral"
        } else {
            return "black"
        }
}
    func yyyyMMdd(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let converted = formatter.string(from: date)
        return converted
    }
}
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
