//
//  EmptyProject.swift
//  ProjectSave
//
//  Created by Vikarn Barai on 15/08/23.
//

import SwiftUI

struct EmptyProjectView: View {
    var body: some View {
        VStack(spacing: 5) {
            Spacer()
            Image("empty-projects")
                .resizable()
                .scaledToFit()
            CustomText(string: "Welcome to FilterApp", fontWeight: .bold, font: .headline)
            CustomText(string: "Please Create Project \n to start.", fontWeight: .regular, font: .subheadline)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
}

struct EmptyProject_Previews: PreviewProvider {
    static var previews: some View {
        EmptyProjectView()
    }
}
