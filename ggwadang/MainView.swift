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
    @State private var todaySugarValue: Double = 0
    @State var progressValue: Double =  0
    @Binding var isPresented: Bool
    @State var naviLinkActive = false
    @AppStorage(StorageKeys.sugar.rawValue) private var sugar : Double = UserDefaults.standard.double(forKey: "sugar")  // 유저의 설탕값
    let realm = try! Realm()

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
                ProgressCircleView(progress: self.$progressValue)
                Spacer().frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.top, 20)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("\(today, formatter: MainView.dateFormat)").font(.headline)
                        .foregroundColor(.white)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingListView(naviLinkActive: $naviLinkActive), isActive: $naviLinkActive) {
                        Image(systemName: "gearshape")
                            .foregroundColor(.white)
                    }
                }
            }
            // 시트를 닫으면 데이터 값 갱신
            .onChange(of: isPresented) { sheetIsOn in
                if sheetIsOn { return }
                
                let userRecords = realm.objects(RecordDB.self).filter("date == '\(yyyyMMdd(date: Date()))'")
                var sum : Double = 0
                for temp in userRecords {
                    sum += temp.calculatedSugar
                }
                todaySugarValue = sum
                progressValue = Double(todaySugarValue) / sugar
            }

            .onAppear {
                let userRecords = realm.objects(RecordDB.self).filter("date == '\(yyyyMMdd(date: Date()))'")
                var sum : Double = 0
                for temp in userRecords {
                    sum += temp.calculatedSugar
                }
                todaySugarValue = sum
                progressValue = Double(todaySugarValue) / sugar
            }
        }
    }
    //end of Body()
    
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
//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
