//
//  FiltersView.swift
//  ProjectSave
//
//  Created by Vikarn Barai on 13/08/23.
//

import SwiftUI

struct FiltersView: View {
    @Binding var selectedFilter: String
    let image: UIImage
    @State var sliderValue: Float
    let sliderChangeValue: (Float) -> Void

    var body: some View {
        VStack {
            sliderView
            filterView
        }
    }
    
    private var filterView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(0...10, id: \.self) { index in
                    ZStack(alignment: .bottom) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                        CustomText(string: "Filter \(index)", fontWeight: .semibold, font: .subheadline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                            .padding(.bottom, 2)
                            .background(Color.filterText)
                    }
                        .frame(width: 100, height: 100, alignment: .center)
                        .clipped()
                        .cornerRadius(5)
                        .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(
                                            selectedFilter == "Filter \(index)" ? Color.borderColor : Color.clear, lineWidth: 2)
                                )
                        .onTapGesture {
                            selectedFilter = "Filter \(index)"
                        }
                }
            }
            .frame(height: 100)
        }.padding(.bottom, 20)
        .onChange(of: sliderValue) { newValue in
                sliderChangeValue(newValue)
        }
    }
    
    private var sliderView: some View {
        Slider(
                value: $sliderValue,
                in: 0...100,
                step: 5
            ) {
                
                Text("EditingValue")
            } minimumValueLabel: {
                Text("0")
            } maximumValueLabel: {
                Text("100")
            }
        
    }
}

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView(selectedFilter: .constant(""), image: UIImage(named: "2")!, sliderValue: 0.0) { _ in
            
        }
    }
}
