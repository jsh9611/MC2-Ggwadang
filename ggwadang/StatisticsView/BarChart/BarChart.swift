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
    var body: some View {
        HStack (alignment: .bottom, spacing: 20){
                Text("hello")
            }
        }
    }


struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        BarChart(dataPoints: [1.0])
    }
}
