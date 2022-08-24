//
//  PieSliceView.swift
//  StatisticsView
//
//  Created by Hyung Seo Han on 2022/06/17.
//
//  비율에 맞게 해당 카테고리가 차지하는 비율만큼 각도를 구해서 원을 그리는 뷰
//
//

import SwiftUI

struct PieSliceView: View {
    var pieSliceData : PieSliceData
    var innerSliceView : CGFloat
    var testColor: [[Color]] = [[Color.blue,Color.black],[Color.pink,Color.orange]]
    var body: some View {
        HStack{
            GeometryReader{geometry in
                let width: CGFloat = max(geometry.size.width, geometry.size.height)
                let height = width
                
                let center  = CGPoint(x: width * 0.5, y:height * 0.5)
                let pieStartAngle = Angle(degrees: -90)+pieSliceData.startAngle
                let pieEndAngle = Angle(degrees: -90)+pieSliceData.endAngle
               
                Path{ path in
                    
                    path.move(to: center)
                    path.addArc(
                        center: center,
                        radius: width * 0.47 * innerSliceView,
                        startAngle: pieStartAngle,
                        endAngle: pieEndAngle,
                        clockwise: false)
                }
                .fill(AngularGradient(
                    gradient: Gradient(colors: pieSliceData.color),
                    center: .center,
                    startAngle: Angle(degrees: -90)+pieSliceData.startAngle,
                    endAngle: Angle(degrees: -90)+pieSliceData.endAngle
                ))
            }
            .aspectRatio(1, contentMode: .fit)
                VStack(alignment:.leading, spacing:10){
                    HStack{
                        Circle()
                            .foregroundColor(Color("BreadStart"))
                            .frame(width: 15, height: 15)
                        Text("빵")
                    }
                    HStack{
                        Circle()
                            .foregroundColor(Color("SnackStart"))
                            .frame(width: 15, height: 15)
                        Text("과자류")
                    }
                    HStack{
                        Circle()
                            .foregroundColor(Color("NutsStart"))
                            .frame(width: 15, height: 15)
                        Text("견과류, 떡")
                    }
                    HStack{
                        Circle()
                            .foregroundColor(Color("DrinkStart"))
                            .frame(width: 15, height: 15)
                        Text("음료")
                    }
                    HStack{
                        Circle()
                            .foregroundColor(Color("DairyStart"))
                            .frame(width: 15, height: 15)
                        Text("유가공품")
                    }
                    HStack{
                        Circle()
                            .foregroundColor(Color("IceCreamStart"))
                            .frame(width: 15, height: 15)
                        Text("아이스크림")
                    }
                    HStack{
                        Circle()
                            .foregroundColor(Color("ChocolateStart"))
                            .frame(width: 15, height: 15)
                        Text("초콜릿")
                    }
                    HStack{
                        Circle()
                            .foregroundColor(Color("CandyStart"))
                            .frame(width: 15, height: 15)
                        Text("캔디, 젤리")
                    }
                    HStack{
                        Circle()
                            .foregroundColor(Color("CaramelStart"))
                            .frame(width: 15, height: 15)
                        Text("캐러맬, 양갱")
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 40))
                .font(.system(size:15, weight: .regular))
            }
        //.border(Color.blue)
    }
}


struct PieSliceView_Previews: PreviewProvider {
    static var previews: some View {
        PieSliceView(pieSliceData: PieSliceData(
            startAngle: Angle(degrees: 0.0),
            endAngle: Angle(degrees: 220.0),
            color: [Color.black,Color.pink]),
                     innerSliceView: 1
        )
    }
}
