//
//  BarChart.swift
//  StatisticsView
//
//  Created by Hyung Seo Han on 2022/06/18.
//

import SwiftUI

struct BarChart: View {
    @State var pickerSelectedItem = 0

    @State var dataPoints: [[Double]] = [
        [35.7868, 100.7, 150.7, 20.7, 50.7, 10, 100],
        [30.7, 140.7, 20.7, 50.7, 90.7, 100, 60],
        [150, 40, 60, 80.7, 120.7, 110.7, 20]
    ]
    @State var number: Double = 38.034535
    var body: some View {
        HStack (alignment: .bottom, spacing: 20){
            BarView(value: dataPoints[pickerSelectedItem][0], week: "월")
                    .onTapGesture {
                        number = dataPoints[pickerSelectedItem][0]
                    }
                BarView(value: dataPoints[pickerSelectedItem][1], week: "화")
                    .onTapGesture {
                        number = dataPoints[pickerSelectedItem][1]
                    }
                BarView(value: dataPoints[pickerSelectedItem][2], week: "수")
                    .onTapGesture {
                        number = (dataPoints[pickerSelectedItem][2])
                    }
                BarView(value: dataPoints[pickerSelectedItem][3], week: "목")
                    .onTapGesture {
                        number = (dataPoints[pickerSelectedItem][3])
                    }
                BarView(value: dataPoints[pickerSelectedItem][4], week: "금")
                    .onTapGesture {
                        number = (dataPoints[pickerSelectedItem][4])
                    }
                BarView(value: dataPoints[pickerSelectedItem][5], week: "토")
                    .onTapGesture {
                        number = (dataPoints[pickerSelectedItem][5])
                    }
                BarView(value: dataPoints[pickerSelectedItem][6], week: "일")
                    .onTapGesture {
                        number = (dataPoints[pickerSelectedItem][6])
                    }
            }
    }
}

struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        BarChart()
    }
}
