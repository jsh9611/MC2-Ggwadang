//
//  MainListView.swift
//  ggwadang
//
//  Created by Hyemin Choi on 2022/06/17.
//

import SwiftUI

struct MainListView: View {
    @EnvironmentObject var store: RecordStore
    @State var todayArray: [[String]] = []
    
    var body: some View {
        VStack {
            HStack {
                Text("오늘의 당 섭취")
                Spacer()
                NavigationLink(destination: MainFullListView()) {
                    Text("전체보기").foregroundColor(.accentColor)
                }
                
            }
            ZStack {
                roundedRect()
                if todayArray.count >= 1 {
                    HStack {
                        VStack (alignment: .leading){
                            Text("\(todayArray[0][0])")
                            Text("\(todayArray[0][1])\(todayArray[0][2])")
                                .font(.system(size:13))
                        }
                        Spacer()
                        Text("당류 \(todayArray[0][3])g")
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                }
                else {
                    Text("-")
                }
            }
            ZStack {
                roundedRect()
                if todayArray.count >= 2 {
                    HStack {
                        VStack (alignment: .leading){
                            Text("\(todayArray[1][0])")
                            Text("\(todayArray[1][1])\(todayArray[1][2])")
                                .font(.system(size:13))
                        }
                        Spacer()
                        Text("당류 \(todayArray[1][3])g")
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    
                }
                else {
                    Text("-")
                }
            }
        }
        
        .onAppear {
            // 안좋은 코드
            // 리펙토링이 필요합니다ㅠㅠ
            todayArray = []
            let temp = store.records.filter{ $0.date == "\(dateFormatter(date: today))" }
            for tem in temp {
                todayArray.append([tem.small,String(tem.foodAmount),tem.unit,String(tem.calculatedSugar)])
            }
        }
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20))
    }
}

struct roundedRect : View {
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color.white)
            .frame(width: 350, height: 80)
            .shadow(color: .gray.opacity(0.15), radius: 20, x: 0, y: 3)
            .blur(radius: 0)
    }
}

func dateFormatter(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMMdd"
    let converted = formatter.string(from: date)
    return converted
}
