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
    @State var todayRecords: [Record] = []
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("오늘의 당 섭취").bold()
                Spacer()
                NavigationLink(destination: MainFullListView()) {
                    Image(systemName: "chevron.right")
                        .font(.headline)
                }
            }
            
            if todayRecords.isEmpty {
                EmptyCell(isPresented: $isPresented)
                    .frame(height: 150)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(todayRecords) { food in
                            FoodCell(food: food)
                        }
                    }
                    .padding(.top, 10)
                }
                .frame(height: 150)
            }
        }
        .padding(20)
        .onChange(of: isPresented) { sheetIsOn in
            if sheetIsOn { return }
            todayRecords = store.records.filter{ $0.date == "\(dateFormatter(date: today))" }
        }
        .onAppear {
            todayRecords = store.records.filter{ $0.date == "\(dateFormatter(date: today))" }
        }
        .fullScreenCover(isPresented: $isPresented, content: {LargeCategoryView(isPresented: self.$isPresented).environmentObject(self.store)})
    }
}

struct FoodCell: View {
    let food: Record!
    let categoryEmoji = ["과자":"🍪", "떡·견과류":"🍡", "베이커리":"🥐", "아이스크림":"🍦", "유가공품":"🥛", "음료":"🥤", "초콜릿":"🍫", "캐러멜·양갱":"🍮", "캔디·젤리":"🍭"]
    
    var body: some View {
        VStack {
            Text(categoryEmoji[food.large] ?? "🍪")
                .modifier(FittingFontSizeModifier())
                .frame(width: 50, height: 50)
                .cornerRadius(25)
                .padding(15)
                .background(Circle().fill(Color.gray.opacity(0.1)))
            
            Text(food.small)
                .padding(.top, 10)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
        }
    }
}

struct EmptyCell: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Button(action: {isPresented.toggle()}) {
            Image(systemName: "plus")
                .font(.title)
                .frame(width: 50, height: 50)
                .padding(15)
                .cornerRadius(25)
                .foregroundColor(Color("CustomColor"))
                .background(Circle().fill(Color.gray.opacity(0.1)))
            }
            
            Text("간식을 기록해 보세요")
                .padding(.top, 10)
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
