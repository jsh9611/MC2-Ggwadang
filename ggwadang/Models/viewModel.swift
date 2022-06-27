//
//  viewModel.swift
//  ggwadang
//
//  Created by Hyung Seo Han on 2022/06/14.
//

import SwiftUI
import RealmSwift

class viewModel: ObservableObject{
    @Published var selection: Int
    @Published var dataPoints: [Double]
    @Published var values: [Double]
    @Published var barBottom: [String]
    @Published var maxHeightBar: Double
    @Published var barWidth: CGFloat
    @Published var barSpacing: CGFloat
    let weeks = ["일","월","화","수","목","금","토"]
    let months = ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"]
    
    init() {
        //SegControl에서의 Picker
        self.selection = 0
        //Barchart에서의 Data Points
        self.dataPoints = [0,0,0,0,0,0,0]
        //Barchart에서 밑의 표시 글
        self.barBottom = weeks
        //Piechart에서의 Data
        self.values = [0,0,0,0,0,0,0,0,0]
        self.maxHeightBar = 0
        self.barWidth = 20
        self.barSpacing = 20
    }

    func getTotalSugar(section: Int, records: [Record]){
//        //만약에 동일한 section을 누른다면 아무런 변화 없음
//        if(self.selection == section){
//            
//        }
        //각각의 section별로의 데이터 추출
        switch section{
        //Week Info
        case 0:
            self.values = getWeekSugarAmountForPieChart(records: records)
            self.dataPoints = getWeekSugarAmountForBarChart(records: records)
            self.barBottom = weeks
            if(dataPoints.max() == 0){
                self.maxHeightBar = 1
            }
            else{
                self.maxHeightBar = dataPoints.max()!
            }
            self.barWidth = 20
            self.barSpacing = 20
        
   
        //Month Info
        case 1:
            self.values = getYearSugarAmountForPieChart(records: records)
            self.dataPoints = getMonthSugarAmountForBarChart(records: records)
            self.barBottom = months
            if(dataPoints.max() == 0){
                self.maxHeightBar = 1
            }
            else{
                self.maxHeightBar = dataPoints.max()!
            }
            self.barWidth = 13
            self.barSpacing = 6.5
        default:
            print("wow")
        }
    }
    //DB의 데이터와 관련하여 날짜 계산할 때
    func testForWeek() -> [Int]{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let currentWeek = Calendar.current.component(.weekday, from: date)
        
        var modifyToSunday = 0
        if (currentWeek != 1){
            modifyToSunday = currentWeek - 1
        }
        var sundayOfWeek = Calendar.current.date(byAdding: .day, value: -modifyToSunday, to: date)!
       
        var test: [Int] = []
        test.append(Int(dateFormatter.string(from: sundayOfWeek))!)
        //일~토까지 데이트를 더함
        for _ in 1..<7{
            sundayOfWeek = Calendar.current.date(byAdding: .day, value: 1,to: sundayOfWeek)!
            test.append(Int(dateFormatter.string(from: sundayOfWeek))!)
        }
        return (test)
    }
    
    //월별 계산
    func testForMonth() -> [Int]{
        var months:[Int] = []
        //현재 날짜를 구하기
        let date = Date()
        //날짜의 Format 형성하는 객체 생성
        let dateFormatter = DateFormatter()
        //날짜 Format 설정
        dateFormatter.dateFormat = "yyyy"
        //현재 시점으로의 연도 구하기
        let stringDate = dateFormatter.string(from: date)
        //해당 연도의 첫번째 날짜
        let myDateComponents = DateComponents(year: Int(stringDate),month: 1,day: 1)
        //해당 연도의 마지막 날짜
        let myDateComponents1 = DateComponents(year: Int(stringDate),month: 12,day: 31)
        //날짜 포멧팅 변경
        dateFormatter.dateFormat = "yyyyMMdd"
        //캘린더 객체 생성
        let calendar = Calendar.current
        //DateComponent에서 Date 객체형태로 변환
        let firstDayOfYear = calendar.date(from: myDateComponents)!
        let endDayOfYear = calendar.date(from: myDateComponents1)!
        
        months.append(Int(dateFormatter.string(from: firstDayOfYear))!)
        var firstDaysOfMonth = Calendar.current.date(byAdding: .month, value: 1, to: firstDayOfYear)!
        for _ in 0..<11{
            months.append(Int(dateFormatter.string(from: firstDaysOfMonth))!)
            firstDaysOfMonth = Calendar.current.date(byAdding: .month, value: 1, to: firstDaysOfMonth)!
        }
        months.append(Int(dateFormatter.string(from: endDayOfYear))!)
        return months
    }
    
    func getMonthSugarAmountForBarChart(records: [Record])-> [Double]{
        //오늘 날짜가 속한 연도의 1월 1일부터 12월 31일까지 날짜 구하기
        let date = testForMonth()
        //해당 연도에 속하는 유저 DB레코드만 뽑아오기 위한 빈 배열 선언
        var test: [Record] = []
        //연도에 맞는 데이터만 솎아내서 배열에 삽입
        for record in records{
            if (Int(record.date)! >= date[0] && Int(record.date)! <= date[12]){
                test.append(record)
            }
        }
        //바 차트에 들어갈 데이터 계산을 위한 데이터 값 변수 초기화
        var data: [Double] = [0,0,0,0,0,0,0,0,0,0,0,0]
        //월별로 데이터 삽입
        for record in test{
            //2월 1일보다 작을때
            if(Int(record.date)!<date[1]){
                data[0] += record.calculatedSugar
            }
            else if(Int(record.date)!<date[2]){
                data[1] += record.calculatedSugar
            }
            else if(Int(record.date)!<date[3]){
                data[2] += record.calculatedSugar
            }
            else if(Int(record.date)!<date[4]){
                data[3] += record.calculatedSugar
            }
            else if(Int(record.date)!<date[5]){
                data[4] += record.calculatedSugar
            }
            else if(Int(record.date)!<date[6]){
                data[5] += record.calculatedSugar
            }
            else if(Int(record.date)!<date[7]){
                data[6] += record.calculatedSugar
            }
            else if(Int(record.date)!<date[8]){
                data[7] += record.calculatedSugar
            }
            else if(Int(record.date)!<date[9]){
                data[8] += record.calculatedSugar
            }
            else if(Int(record.date)!<date[10]){
                data[9] += record.calculatedSugar
            }
            else if(Int(record.date)!<date[11]){
                data[10] += record.calculatedSugar
            }
            else if(Int(record.date)!<date[12]){
                data[11] += record.calculatedSugar
            }
            else{
                data = [0,0,0,0,0,0,0,0,0,0,0,0]
            }
        }
        return data
    }
    
    //Bar Chart에 들어갈 Data
    func getWeekSugarAmountForBarChart(records: [Record]) -> [Double]{
        let date = testForWeek()
        var test: [Record] = []
        
        //DB에서 해당 주 데이터 가져오기
        for record in records {
            if (Int(record.date)! >= date[0] && Int(record.date)! <= date[6]){
                test.append(record)
            }
        }

        var data: [Double] = [0,0,0,0,0,0,0]
        for record in test{
            switch record.date{
            case String(date[0]):
                data[0] += record.calculatedSugar
            case String(date[1]):
                data[1] += record.calculatedSugar
            case String(date[2]):
                data[2] += record.calculatedSugar
            case String(date[3]):
                data[3] += record.calculatedSugar
            case String(date[4]):
                data[4] += record.calculatedSugar
            case String(date[5]):
                data[5] += record.calculatedSugar
            case String(date[6]):
                data[6] += record.calculatedSugar
            default:
                data = [0,0,0,0,0,0,0]
            }
        }
        return (data)
    }
    
    //Pie Chart에 들어갈 Month Data
    func getYearSugarAmountForPieChart(records: [Record]) -> [Double]{
        let date = testForMonth()
        var test: [Record] = []
        
        //DB에서 해당 주 데이터 가져오기
        for record in records {
            if (Int(record.date)! >= date[0] && Int(record.date)! <= date[12]){
                test.append(record)
            }
        }
        //각 카테고리별로의 변수
        var bread: Double = 0
        var snack: Double = 0
        var nuts: Double = 0
        var drinks: Double = 0
        var dairy: Double = 0
        var icecream: Double = 0
        var chocolate: Double = 0
        var candy: Double = 0
        var caramel: Double = 0
        
        //레코드에 따라서 함유량 더하기
        for record in test{
            switch String(record.large){
            case "베이커리":
                bread += record.calculatedSugar
            case "과자":
                snack += record.calculatedSugar
            case "떡·견과류":
                nuts += record.calculatedSugar
            case "음료":
                drinks += record.calculatedSugar
            case "유가공품":
                dairy += record.calculatedSugar
            case "아이스크림":
                icecream += record.calculatedSugar
            case "초콜릿":
                chocolate += record.calculatedSugar
            case "캔디·젤리":
                candy += record.calculatedSugar
            case "캐러멜·양갱":
                caramel += record.calculatedSugar
            default:
                self.values = [0,0,0,0,0,0,0,0,0]
            }
        }
        //값들을 리턴해줌으로써 파이차트에서 다시 그릴 수 있음.
        return ([bread,snack,nuts,drinks,dairy,icecream,chocolate,candy,caramel])
    }
    
    //Pie Chart에 들어갈 Week Data
    func getWeekSugarAmountForPieChart(records: [Record]) -> [Double]{
        let date = testForWeek()
        var test: [Record] = []
        
        //DB에서 해당 주 데이터 가져오기
        for record in records {
            if (Int(record.date)! >= date[0] && Int(record.date)! <= date[6]){
                test.append(record)
            }
        }
        //각 카테고리별로의 변수
        var bread: Double = 0
        var snack: Double = 0
        var nuts: Double = 0
        var drinks: Double = 0
        var dairy: Double = 0
        var icecream: Double = 0
        var chocolate: Double = 0
        var candy: Double = 0
        var caramel: Double = 0
        
        //레코드에 따라서 함유량 더하기
        for record in test{
            switch String(record.large){
            case "베이커리":
                bread += record.calculatedSugar
            case "과자":
                snack += record.calculatedSugar
            case "떡·견과류":
                nuts += record.calculatedSugar
            case "음료":
                drinks += record.calculatedSugar
            case "유가공품":
                dairy += record.calculatedSugar
            case "아이스크림":
                icecream += record.calculatedSugar
            case "초콜릿":
                chocolate += record.calculatedSugar
            case "캔디·젤리":
                candy += record.calculatedSugar
            case "캐러멜·양갱":
                caramel += record.calculatedSugar
            default:
                self.values = [0,0,0,0,0,0,0,0,0]
            }
        }
        //값들을 리턴해줌으로써 파이차트에서 다시 그릴 수 있음.
        return ([bread,snack,nuts,drinks,dairy,icecream,chocolate,candy,caramel])
    }
    
    
}
