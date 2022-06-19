//
//  SegmentedPicker.swift
//  StatisticsView
//
//  Created by Hyung Seo Han on 2022/06/15.
//

import SwiftUI

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}

struct SegmentedPicker: View {
    //Text Property 설정
    private static let ActiveSegmentColor: Color = Color("CustomColor")
    private static let BackgroundColor : Color = Color.white
    private static let ShadowColor: Color = Color.black.opacity(0.2)
    
    //Text가 선택되었을때와 아닐때의 색깔 변경
    private static let TextColor: Color = Color.black
    private static let SelectedTextColor: Color = Color.white
    private static let TextFont: Font = .system(size: 12)
    
    //Picker 설정
    private static let SegmentCornerRadius: CGFloat = 20
    private static let ShadowRadius: CGFloat = 4
    
    //글자에서부터 Padding 시전
    private static let SegmentXPadding: CGFloat = 16
    private static let SegmentYPadding: CGFloat = 8
    private static let PickerPadding: CGFloat = 0
        
    //Animation 설정
    private static let AnimationDuration: Double = 0.1
    
    private var activeSegmentView: AnyView{
        // 1. Don't show the active segment until we have initialized the view
        let isInitialized: Bool = segmentSize != .zero
        if !isInitialized { return EmptyView().eraseToAnyView() }
        
        return // Note: return here will return the RoundedRect on the next line
            RoundedRectangle(cornerRadius: SegmentedPicker.SegmentCornerRadius)
                .foregroundColor(SegmentedPicker.ActiveSegmentColor)
                .shadow(
                    color: SegmentedPicker.ShadowColor,
                    radius: SegmentedPicker.ShadowRadius
                )
                // 2. Define frame from `segmentSize`
                .frame(width: self.segmentSize.width, height: self.segmentSize.height)
                // 3. Offset from the leading edge (see below ZStack) by a computed amount
                .offset(x: self.computeActiveSegmentHorizontalOffset(), y: 0)
                // 4. Introduce a linear animation to show sliding between segments
                .animation(Animation.linear(duration: SegmentedPicker.AnimationDuration))
                .eraseToAnyView() // Make SwiftUI happy :) this is the same as AnyView(...)
    }
    
    //Picker property 설정
    //SegView에서 생성된 viewModel 참조
    @ObservedObject var ViewModel: viewModel
    @State private var segmentSize: CGSize = .zero
    
    //사용자가 먹은 음식들 저장된 DB데이터
    let records : [Record]
    
    private let numbers: [String] = ["주","월","년"]
    var body: some View {
        ZStack(alignment: .leading){
            self.activeSegmentView
            HStack {
                ForEach(0..<self.numbers.count, id: \.self) { index in
                    self.getSegmentView(for: index)
                }
            }
        }
        .padding(SegmentedPicker.PickerPadding)
        .background(SegmentedPicker.BackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: SegmentedPicker.ShadowColor,
                radius: SegmentedPicker.ShadowRadius
        )
    }
    
    private func getSegmentView(for index: Int) -> AnyView{
        //check the index number is available
        guard index < self.numbers.count else{
            return EmptyView().eraseToAnyView()
        }
        let isSelected = ViewModel.selection == index
        return AnyView(
            Text(self.numbers[index])
                .foregroundColor(isSelected ? SegmentedPicker.SelectedTextColor : SegmentedPicker.TextColor)
                //텍스트의 라인을 제한할 때 사용함(1줄로 표기해야하므로 1로 사용함)
                .lineLimit(1)
                .padding(.vertical, SegmentedPicker.SegmentYPadding)
                .padding(.horizontal, SegmentedPicker.SegmentXPadding)
                //텍스트의 크기가 달라도 같은 공간을 차지할 수 있게끔 View Divide
                .frame(minWidth: 0, maxWidth: .infinity)
                .modifier(SizeAwareViewModifier(viewSize: self.$segmentSize))
                //각각의 요소마다 해당 기능이 부여가 되고 있으니,
                //해당 탭을 누르면 해당 뷰의 Index로 값이 변경됨
                .onTapGesture {
                    self.onItemTap(index: index)
                }
                .eraseToAnyView()
                )
    }
    
    //해당 되는 숫자의 탭을 눌렀을 때의 index값 변경을 위한 function
    private func onItemTap(index: Int) {
        guard index < self.numbers.count else {
            return
        }
        ViewModel.getTotalSugar(section: index, records: self.records)
        ViewModel.selection = index
        
    }
    
    private func computeActiveSegmentHorizontalOffset() -> CGFloat {
        CGFloat(ViewModel.selection) * (self.segmentSize.width + SegmentedPicker.SegmentXPadding / 2)
    }
}
    
/*
struct SegmentedPicker_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedPicker(ViewModel: viewModel())
    }
}
 */

