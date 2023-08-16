//
//  CustomText.swift
//  ProjectSave
//
//  Created by Vikarn Barai on 13/08/23.
//

import SwiftUI

struct CustomText: View {
    let string: String
    let fontWeight: Font.Weight
    let font: Font
    var textColor: Color = .black
    var body: some View {
        Text(string)
            .font(font)
            .fontWeight(fontWeight)
            .foregroundColor(textColor)
    }
}

struct CustomText_Previews: PreviewProvider {
    static var previews: some View {
        CustomText(string: "Text", fontWeight: .bold, font: .title2)
    }
}
