//
//  MainView.swift
//  ggwadang
//
//  Created by seungyeon oh on 2022/06/14.
//

import SwiftUI

var today = Date()

// 배경색 선언
let backgroundGreen = LinearGradient(gradient: Gradient(colors: [Color("mint"), Color("green")]), startPoint: .top, endPoint: .bottom)
let backgroundYellow = LinearGradient(gradient: Gradient(colors: [Color("yellow"), Color("orange")]), startPoint: .top, endPoint: .bottom)
let backgroundRed = LinearGradient(gradient: Gradient(colors: [Color("tangerine"), Color("coral")]), startPoint: .top, endPoint: .bottom)
let backgroundBlack = LinearGradient(gradient: Gradient(colors: [Color("gray"), Color("black")]), startPoint: .top, endPoint: .bottom)

struct MainView: View {
    // TODO: RecordDB로부터 오늘 먹은 레코드 불러오기 -> 섭취량 계산
    // TODO: AppStorage에 저장된 사용자 목표 섭취량 가져오기
    @State private var todaySugarValue: Int = 18
    @State private var sugarGoalValue: Int = 40
    @State var progressValue: Float =  0.9
    
    //public var testNumber: Float = 9.9
    static var dateFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월 d일"
        return formatter
    }
    
    var body: some View {
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
                            NavigationLink(destination: EmptyView()) {
                                Image(systemName: "gearshape")
                                    .foregroundColor(.white)
                            }
                        }
                    }
            }
            ProgressCircleView(progress: self.$progressValue)
            Spacer()
        }
        .background(backGround(number: progressValue))
        
    }//end of Body()
    
    //Func backGround()
    func backGround(number: Float) -> LinearGradient {
        if progressValue <= 0.39 {
            return backgroundGreen
        } else if progressValue <= 0.79 {
            return backgroundYellow
        } else if progressValue <= 0.99 {
            return backgroundRed
        } else {
            return backgroundBlack
        }
    }
    //end of backGround()
}
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
