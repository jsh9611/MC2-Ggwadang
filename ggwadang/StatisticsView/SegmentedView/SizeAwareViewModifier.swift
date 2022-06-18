//
//  SizeAwareViewModifier.swift
//  StatisticsView
//
//  Created by Hyung Seo Han on 2022/06/15.
//

import SwiftUI

struct SizePreferenceKey: PreferenceKey{
    //retrieve the data that contains width and height information.
    typealias Value = CGSize
    static var defaultValue: CGSize = .zero
    static func reduce(
        value: inout CGSize,
        nextValue: () -> CGSize) {
            value = nextValue()
        }
}

struct BackgroundGeometryReader: View{
    var body: some View{
        GeometryReader{geometry in
            return Color
                .clear
                .preference(key: SizePreferenceKey.self, value: geometry.size)
        }
    }
}

struct SizeAwareViewModifier: ViewModifier {
    @Binding private var viewSize: CGSize
    
    init(viewSize: Binding<CGSize>){
        self._viewSize = viewSize
    }
    
    func body(content: Content) -> some View {
        content
            .background(BackgroundGeometryReader())
            .onPreferenceChange(SizePreferenceKey.self, perform: {if self.viewSize != $0 {self.viewSize = $0}})
    }
}



