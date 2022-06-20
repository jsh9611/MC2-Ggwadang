//
//  PieChartView.swift
//  StatisticsView
//
//  Created by Hyung Seo Han on 2022/06/17.
//

import SwiftUI


struct PieChartView: View {
    @Binding var testtest: Double
    @Binding var stringtestt: String
    public let values: [Double]
    public var colors: [[Color]]
    public var innerRadiusFraction: CGFloat
    public let category: [String] = ["빵","과자류","견과류, 떡","음료","유가공품","아이스크림","초콜릿","캔디, 젤리","캐러멜, 양갱"]
    
    //값의 총량과 비례하게 각각의 값에 해당되는 각도를 구하여 PieSliceData 구조체를 형성,
    //임시 배열에 추가하여
    //slices 배열 -> PieSliceData의 모음집이 들어가있음.
    var slices: [PieSliceData] {
        let sum = values.reduce(0, +)
        var endDeg: Double = 0
        var tempSlices: [PieSliceData] = []
        
        for (i, value) in values.enumerated() {
            let degrees: Double = value * 360 / Double(sum)
            tempSlices.append(PieSliceData(startAngle: Angle(degrees: endDeg), endAngle: Angle(degrees: endDeg + degrees), color: colors[i]))
            //LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom
            //다음 파이 조각의 시작 각도를 구하기 위한 작업
            endDeg += degrees
        }
        
        //어쨌든 원 모양의 그래프가 반환이 됨
        return tempSlices
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                ForEach(0..<self.values.count){ i in
                    PieSliceView(pieSliceData: self.slices[i],innerSliceView: 1)
                        .onTapGesture {
                            testtest = values[i]
                            stringtestt = category[i]
                        }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                
                //중간 원 그리기
                PieSliceView(pieSliceData:PieSliceData(
                    startAngle: Angle(degrees: 0.0),
                    endAngle: Angle(degrees: 360.0),
                    color: [Color.white, Color.white]
                ),
                innerSliceView: self.innerRadiusFraction)
                    .onTapGesture {
                        testtest = .zero
                        stringtestt = ""
                    }
            }
            .padding(EdgeInsets(top: -60, leading: 0, bottom: -40, trailing: 0))
        }
    }
}

/*
struct PieChartView_Previews: PreviewProvider {
    @State var testtesttest: Double = 100.0
    static var previews: some View {
        PieChartView(testtest: $testtesttest, values: [1300, 500, 300], colors: [Color.blue, Color.green, Color.orange], innerRadiusFraction: 0.5)
    }
}
*/
