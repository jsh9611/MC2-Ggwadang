//
//  IntakeAmountView.swift
//  ggwadang
//
//  Created by kimjimin on 2022/06/16.
//

import SwiftUI

struct IntakeAmountView: View {
    @FocusState private var isFocused: Bool
    
    @EnvironmentObject var store: RecordStore
    @EnvironmentObject var food: FoodStore
    
    @Binding var isPresented: Bool
    @State var Today = Date.now
    @Binding var large_isSelected: String
    @Binding var medium_isSelected: String
    @Binding var small_isSelected: String
    
    let categoryEmoG = ["과자":"🍪", "떡·견과류":"🍡", "베이커리":"🥐", "아이스크림":"🍦", "유가공품":"🥛", "음료":"🥤", "초콜릿":"🍫", "캐러멜·양갱":"🍮", "캔디·젤리":"🍭"]
    
    let servingCategory = ["1/3", "1/2", "1", "2", "3", "직접입력"]
    let categoryRate : [Double] = [0.333, 0.5, 1, 2, 3, -1] // 계산하기 쉽도록 테이블 작성
    @State var isSelected = [false, false, false, false, false, false]
    @State private var showingAlert = false // 0 g/ml 입력하면 뜨게 하는 용도
    
    @State var directTyping = false
    @State var buttonState : Int = 0    // 현재 선택한 카테고리명
    
    @State var foodAmount : Double = 0  // 섭취하는 음식의 총량
    @State var calculatedSugar: Double = 0
    @State var unit = ""
        
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    // TextField에 숫자를 표시하려면 NumberFormatter 를 사용해야 합니다
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        ForEach(food.foods.filter{
            $0.large == large_isSelected &&
            $0.medium == medium_isSelected &&
            $0.small == small_isSelected
        }) { foo in // 똥이에요
            VStack{
                ZStack {
                    // 위에 배경부분
                    LinearGradient(gradient: Gradient(colors: [Color(hex: 0x80BBB7), Color(hex: 0x80BF88)]),
                                   startPoint: .top, endPoint: .center)
                    .edgesIgnoringSafeArea(.all)
                    
                    HStack {
                        VStack {
                            VStack {
                                HStack {
                                    Text("\(small_isSelected)") // 최대 11글자
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .lineLimit(1)
                                    Spacer()
                                }
                                
                                
                                HStack {
                                    VStack (alignment: .leading){
                                        Text("당류 \(String(format: "%.1f", foodAmount*(Double(foo.sugarPerGram) ?? 0)))g")
                                            .font(.title3)
                                            .fontWeight(.bold)
                                        HStack {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 15)
                                                    .fill(Color.white)
                                                    .opacity(0.1)
                                                    .shadow(color: .black.opacity(0.15), radius: 20, y: 3)
                                                
                                                HStack {
                                                    
                                                    TextField("\(foo.servingSize)",
                                                              value: $foodAmount,
                                                              formatter: formatter)
                                                    .frame(height: 60)
                                                    .padding(.leading, 10)
                                                    .focused($isFocused)    // 텍스트필드를 바라보도록 활성화
                                                    .keyboardType(.numberPad)
                                                    .font(.title2)
                                                    
                                                    Text("\(foo.unit)")
                                                        .font(.title2)
                                                        .fontWeight(.bold)
                                                        .padding(.trailing, 5)
                                                    Spacer()
                                                }
                                                
                                            }.frame(width: 110, height: 60)
                                            
                                        }
                                        
                                        
                                    }
                                    
                                    Spacer()
                                    Text("\(categoryEmoG[foo.large] ?? "🍪")")
                                        .modifier(FittingFontSizeModifier()) // .resizable()처럼 사용하기 위해 추가함
                                        .frame(width: 100, height: 100)
                                }
                                
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            
                            
                        }
                    }
                }
                .frame(height: 250) // 스캐치 기준 300이라 일단 이렇게함
                
                LazyVGrid(columns: gridItemLayout, spacing: 10) {
                    ForEach((0 ..< servingCategory.count - 1), id: \.self) { num in
                        // 이전에 눌렀던 버튼을 해제한 뒤 현재 num에 대한 버튼을 활성화
                        Button {
                            // 직접입력을 눌렀다가 다른 버튼을 누르는 경우 포커스 해제
                            if isFocused { isFocused.toggle() }
                            // 이전에 눌렀던 버튼을 해제
                            self.isSelected[buttonState].toggle()
                            // 이번에 눌렀던 버튼의 index를 저장하고 버튼 활성화
                            buttonState = num
                            self.isSelected[buttonState].toggle()
                            // 각 버튼의 배수 x 개당(컵,개,덩어리) 용량 = 선택한 용량
                            foodAmount = Double(String(format: "%.0f", categoryRate[buttonState] * (Double(foo.servingSize) ?? 0) )) ?? 0
                        } label: {
                            HStack {
                                Text("\(servingCategory[num])")
                                Text("\(foo.servingUnit)")
                            }
                            .padding()
                            .foregroundColor(self.isSelected[num] ? Color.white : Color.black)
                        }
                        .frame(width: 110, height: 60)
                        .background(RoundedRectangle(cornerRadius: 15)
                            .fill(self.isSelected[num] ? Color(hex: 0x6CADA5) : Color.white)
                            .shadow(color: .gray.opacity(0.15), radius: 20, y: 3)
                                    
                        )
                    }
                    
                    Button {
                        // 직접입력
                        // 이전에 눌렀던 버튼을 해제
                        self.isSelected[buttonState].toggle()
                        buttonState = servingCategory.count - 1
                        self.isSelected[buttonState].toggle()
                        // 텍스트 필드에 대한 focus를 On
                        isFocused = true
                    } label: {
                        Text("직접입력")
                            .fontWeight(.bold)
                            .padding()
                            .foregroundColor(Color(hex: 0x6CADA5))
                        
                    }
                    .frame(width: 110, height: 60)
                    .background(RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .shadow(color: .gray.opacity(0.15), radius: 20, y: 3))
                    .overlay(RoundedRectangle(cornerRadius: 15)
                        .stroke(self.isFocused ? Color(hex: 0x6CADA5) : Color.clear, lineWidth: 2))
                    
                }
                .padding(.top, 10)
                .padding(.horizontal, 10)
                // 등장과 동시에 foodAmount에 값을 넣어준다.(디폴트로 선택한 0번 버튼의 값이 들어감)
                .onAppear {
                    isSelected[buttonState].toggle()
                    foodAmount = Double(String(format: "%.0f", categoryRate[buttonState] * (Double(foo.servingSize) ?? 0) )) ?? 0
                    unit = foo.unit
                }
                
                Spacer()
                Button {
                    if foodAmount <= 0 || foodAmount > 10000 {
                        showingAlert.toggle()
                    } else {
                        calculatedSugar = (Double(foo.sugarPerGram)! * foodAmount )
                        saveRecord()
                        isPresented.toggle()
                    }
                } label: {
                    Text("추가하기")
                        .frame(width: (UIScreen.main.bounds.width)*0.9, height: 56)
                        .foregroundColor(Color.white)
                }
                .background(RoundedRectangle(cornerRadius: 30).fill(Color(hex: 0x6CADA5)))
                .padding(.vertical, 20)
                .alert("범위 초과", isPresented: $showingAlert) {
                    Button("OK") {
                        isFocused.toggle()
                        foodAmount = Double(foo.servingSize)!
                    }
                } message: {
                    Text("0~10000 사이의 값을 입력해주세요.")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action:{
                        isPresented.toggle()
                    }){Image(systemName: "xmark")}
                }
            }
        }
    }
}

extension IntakeAmountView {
    func saveRecord() {
        store.create(
            date: dateFormatter(date: Today),
            large: large_isSelected,
            medium: medium_isSelected,
            small: small_isSelected,
            calculatedSugar: calculatedSugar,
            foodAmount: foodAmount,
            unit: unit)
    }
}
