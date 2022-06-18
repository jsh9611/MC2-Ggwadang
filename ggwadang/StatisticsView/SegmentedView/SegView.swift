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
    @StateObject var TestModel = viewModel()
    @State var testtest: Int = 0
    @State var stringTest: String = ""
    
    //@State var dataPoints: [double] -> BarChart에 들어갈 내용 -> 주/월/년 별로의 실질 데이터
    //@State var values: [Int] -> PieChart에 들어가 내용 -> 각 당 그람수
    //@State
    
    //Body View Start
    var body: some View {
        ScrollView{
            VStack(){
                //Setting Icon
                Image(systemName: "gearshape")
                    .resizable()
                        .frame(width: 21.0, height: 21.0)
                        .padding()
                    .frame(width: 350, alignment: .trailing)
                
                //Segment Picker View
                SegmentedPicker(ViewModel: TestModel)
                    .frame(width: 350)
                //End of Segment Picker View
                
                
                //BarChart Start
                VStack{
                    VStack(alignment:.leading){
                        Text("섭취한 당류")
                            .font(.callout)
                        Text("  \(testtest)g")
                            .font(.system(size: 28,weight: .bold))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
                
                    BarChart()
                        .frame(maxWidth: .infinity)
//                        .border(Color.blue)
                    
                }
                
                //End of BarChart
                
                //Spacer(minLength: 1000)
                
                //PieChart Section Start
                VStack{
                    //Text Rendering for PieChartView
                    VStack(alignment:.leading){
                        Text("선택한 카테고리")
                            .font(.callout)
                        Text("\(stringTest) \(testtest)g")
                            .font(.system(size: 28,weight: .bold))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
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
                    .padding(EdgeInsets(top: -20, leading: 10, bottom: -100, trailing: 0))
                }
                .border(Color.black)

                //End of PieChart Section
            }
            
            //End of First VStack View -> Rendering Whole View
        }
        
        //End of Scroll View
    }
    
    //End of Body View
    
    func selectedNumber(number: Int) -> Text{
        switch number{
        case 0:
            return Text("주뷰")
        case 1:
            return Text("월뷰")
        case 2:
            return Text("연뷰")
        default:
            return Text("none")
        }
    }
}
//End of SegView struct

struct SegView_Previews: PreviewProvider {
    static var previews: some View {
        SegView(
            TestModel: viewModel()
        )
    }
}

//format %.1f
