//
//  ContentView.swift
//  StatisticsView
//
//  Created by Hyung Seo Han on 2022/06/11.
//

import SwiftUI
import Foundation

//SegView Start
struct SegView: View {
    //@EnvironmentObject var store: RecordStore
    @State var testtest: Double = 0.0
    @State var stringTest: String = ""
    @State var changeStatus: Bool = false
    @State var barTest: Double = 0.0
    @EnvironmentObject var store: RecordStore
    //store.record에서 가져온 DB 데이터
    let records : [Record]
    
    //SegView에서 객체 생성 후, SegPicker에서 해당 모델 관찰
    @StateObject var TestModel = viewModel()
    
    
    //@State var dataPoints: [double] -> BarChart에 들어갈 내용 -> 주/월/년 별로의 실질 데이터
    //@State var values: [Int] -> PieChart에 들어가 내용 -> 각 당 그람수
    //@State
    
    //Body View Start
    var body: some View {
        ScrollView{
            VStack(){
                //Setting Icon
//                Image(systemName: "gearshape")
//                    .resizable()
//                        .frame(width: 21.0, height: 21.0)
//                        .padding()
//                    .frame(width: 350, alignment: .trailing)
                
                //Segment Picker View
                SegmentedPicker(ViewModel: TestModel, records: self.records)
                    .frame(width: 350)
                //End of Segment Picker View
                
                
                //BarChart Start
                VStack{
                    VStack(alignment:.leading){
                        Text("섭취한 당류")
                            .font(.callout)
                        Text(" \(barTest,specifier: "%.1f")g")
                            .font(.system(size: 28,weight: .bold))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 0))
                
                    BarChart(dataPoints: TestModel.dataPoints,
                             barTest: self.$barTest,
                             ViewModel: TestModel
                    )
                    .frame(maxWidth: .infinity, minHeight: 180,maxHeight: 180,alignment: .bottom)
                    
                        
                }
                
                //End of BarChart
                
                //PieChart Section Start
                VStack{
                    //Text Rendering for PieChartView
                    VStack(alignment:.leading){
                        Text("선택한 카테고리")
                            .font(.callout)
                        Text("\(stringTest) \(testtest,specifier: "%.1f")g")
                            .font(.system(size: 28,weight: .bold))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 20, leading: 10, bottom: -10, trailing: 0))
                    //End of Text Rendering for PieChartView
                //PieChartView
                PieChartView(testtest: $testtest,
                             stringtestt: $stringTest,
                             values: TestModel.values,
                             colors: [[Color("BreadEnd"),Color("BreadStart")],
                                      [Color("SnackEnd"), Color("SnackStart")],
                                      [Color("NutsEnd"),Color("NutsStart")],
                                      [Color("DrinkEnd"), Color("DrinkStart")],
                                      [Color("DairyEnd"),Color("DairyStart")],
                                      [Color("IceCreamEnd"),Color("IceCreamStart")],
                                      [Color("ChocolateEnd"), Color("ChocolateStart")],
                                      [Color("CandyEnd"),Color("CandyStart")],
                                      [Color("CaramelEnd"),Color("CaramelStart")]
                                     ],
                                     
                            innerRadiusFraction: 0.42)
                    .scaledToFit()
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: -100, trailing: 0))
                }
                
                //End of PieChart Section
            }
            //End of First VStack View -> Rendering Whole View
        }
        //End of Scroll View
        .onAppear{
            TestModel.getTotalSugar(section: TestModel.selection, records: records)
        }
        
    }
    //End of Body View
    
}
//End of SegView struct

struct SegView_Previews: PreviewProvider {
    static var previews: some View {
        SegView(
            records: [],
            TestModel: viewModel()
        )
    }
}

//format %.1f
