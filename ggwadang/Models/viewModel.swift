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
    
    init() {
        self.selection = 0
        self.dataPoints = [35.7868, 100.7, 150.7, 20.7, 50.7, 10, 100]
        self.values = [0,0,0,0,0,0,0,0,0]
    }
    
    //통계에 대한 기준 설정?
    //해당일(오늘)을 기준으로 주는 해당일이 속한 주
    //월은 해당 일이 속한 달의 1~4주
    //연은 2022년
    func getTotalSugar(section: Int, records: [Record]){
        //For Sorting
        var sortedRecords = records
        sortedRecords.sort{
            $0.large < $1.large
        }
        //만약에 동일한 section을 누른다면 아무런 변화 없음
        if(self.selection == section){
            return
        }
        
        //각각의 section별로의 데이터 추출
        switch section{
        case 0:
            getSugarAmountFromUsers(records: sortedRecords)
        case 1:
            self.values = [0,0,100,100,100,100,100,100,100] 
        case 2:
            print("")
        default:
            print("wow")
        }
    }
    
    func getSugarAmountFromUsers(records: [Record]){
        var bread: Double = 0
        var snack: Double = 0
        var nuts: Double = 0
        var drinks: Double = 0
        var dairy: Double = 0
        var icecream: Double = 0
        var chocolate: Double = 0
        var candy: Double = 0
        var caramel: Double = 0
    
        for record in records{
            print(record.large)
            switch String(record.large){
            case "과자":
                snack += record.calculatedSugar
            case "떡·견과류":
                nuts += record.calculatedSugar
            case "베이커리":
                bread += record.calculatedSugar
            case "아이스크림":
                icecream += record.calculatedSugar
            case "유가공품":
                dairy += record.calculatedSugar
            case "음료":
                drinks += record.calculatedSugar
            case "초콜릿":
                chocolate += record.calculatedSugar
            case "캐러멜, 양갱":
                caramel += record.calculatedSugar
            case "캔디":
                candy += record.calculatedSugar
            default:
                self.values = [0,0,0,0,0,0,0,0,0]
            }
        }
        self.values = [snack,nuts,bread,icecream,dairy,drinks,chocolate,caramel,candy]
    }
}
