//
//  BarChart.swift
//  StatisticsView
//
//  Created by Hyung Seo Han on 2022/06/18.
//

import SwiftUI

struct BarChart: View {
    //@State var pickerSelectedItem = 0

    @State var dataPoints: [Double]
    @State var number: Double = 38.034535
    @Binding var barTest: Double
    @ObservedObject var ViewModel: viewModel
    
    
    var body: some View {
        HStack(alignment: .bottom,spacing: ViewModel.barSpacing){
            ForEach(0..<ViewModel.dataPoints.count, id: \.self){index in
                VStack{
                    Capsule().frame(width: ViewModel.barWidth, height: CGFloat(ViewModel.dataPoints[index]/ViewModel.maxHeightBar)*140)
                        .foregroundColor(Color.green)
                    Text(ViewModel.barBottom[index])
                        .font(.system(size:15))
                }
                .frame(height: 160, alignment: .bottom)
                .onTapGesture {
                    barTest = ViewModel.dataPoints[index]
                }
                /*
                Text("\(data,specifier: "%.1f")")
                    .font(Font.system(size:12, design: .default))
                 */
            }
        }
    }
}
//" \(TestModel.dataPoints[0],specifier: "%.1f")g"

/*
struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        BarChart(dataPoints: [1.0],
                 barTest: 0.0,
                 ViewModel: viewModel(),
        )
    }
}
*/
