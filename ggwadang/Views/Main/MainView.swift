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
    @State var naviLinkActive = false
    @Binding var todaySugarValue: Double
    @Binding var isPresented: Bool
    @AppStorage(StorageKeys.sugar.rawValue) private var sugar : Double = UserDefaults.standard.double(forKey: "sugar")
    
    let realm = try! Realm()
    
    static var dateFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월 d일"
        return formatter
    }
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color(bgTop(number: Double(todaySugarValue) / sugar)), Color(bgBottom(number: Double(todaySugarValue) / sugar))]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack{
                ProgressCircleView(todaySugarValue: self.$todaySugarValue)
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
        }
    }
    
    // MARK: - 배경색 변경을 위한 함수
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
    
}
