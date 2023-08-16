//
//  BackHeaderView.swift
//  ProjectSave
//
//  Created by Vikarn Barai on 12/08/23.
//

import SwiftUI

struct BackHeaderView: View {
    let title: String
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        HStack {
            Button(action: {
                self.dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.black)
            })

                .padding(.leading)
            Spacer()
            CustomText(string: title, fontWeight: .semibold, font: .title2)
            Spacer()
        }
    }
}

struct BackHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        BackHeaderView(title: "Filter")
    }
}
