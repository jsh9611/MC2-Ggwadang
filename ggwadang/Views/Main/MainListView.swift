//
//  MainListView.swift
//  ggwadang
//
//  Created by Hyemin Choi on 2022/06/17.
//

import SwiftUI
import RealmSwift

struct MainListView: View {
    @EnvironmentObject var store: RecordStore
    @State var todayArray: [[String]] = []
    @State private var todaySugarValue: Double = 0
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("오늘의 당 섭취").bold()
                Spacer()
                NavigationLink(destination: MainFullListView()) {
                    Image(systemName: "chevron.right")
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(todayArray,id: \.self) { food in
                        FoodCell(food: food)
                    }
                }
                .padding(.top, 10)
            }
            .frame(height: 150)
        }
        .padding(20)
        .onChange(of: isPresented) { sheetIsOn in
            if sheetIsOn { return }
            todayArray = []
            let todayRecords = store.records.filter{ $0.date == "\(dateFormatter(date: today))" }
            for record in todayRecords {
                todayArray.append([record.large, record.small])
            }
        }
        
        .onAppear {
            todayArray = []
            let todayRecords = store.records.filter{ $0.date == "\(dateFormatter(date: today))" }
            for record in todayRecords {
                todayArray.append([record.large, record.small])
            }
        }
    }
}

struct FoodCell: View {
    let food: [String]!
    let categoryEmoji = ["과자":"🍪", "떡·견과류":"🍡", "베이커리":"🥐", "아이스크림":"🍦", "유가공품":"🥛", "음료":"🥤", "초콜릿":"🍫", "캐러멜·양갱":"🍮", "캔디·젤리":"🍭"]
    
    var body: some View {
        VStack {
            Text(categoryEmoji[food[0]] ?? "🍪")
                .modifier(FittingFontSizeModifier())
                .frame(width: 50, height: 50)
                .cornerRadius(25)
                .padding(15)
                .background(Circle().fill(Color.gray.opacity(0.1)))
            
            Text(food[1])
                .font(.subheadline)
                .multilineTextAlignment(.leading)
        }
    }
}

func dateFormatter(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMMdd"
    let converted = formatter.string(from: date)
    return converted
}
