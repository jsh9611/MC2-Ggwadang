//
//  BarChartModel.swift
//  StatisticsView
//
//  Created by Hyung Seo Han on 2022/06/18.
//

import SwiftUI

struct BarStickView{
    public var value: CGFloat
    public var label: String
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack {
                Capsule().frame(width: 20, height: value)
                    .foregroundColor(.green)
                Text(label)
                    .font(.system(size:15))
            }
        }
    }
}
