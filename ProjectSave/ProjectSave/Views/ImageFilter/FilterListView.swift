//
//  EditView.swift
//  ProjectSave
//
//  Created by Vikarn Barai on 12/08/23.
//

import SwiftUI

struct FilterListView: View {
    @Binding var project: Project?
    let image: UIImage
    @State private var selectedFilter: String
    init(project: Binding<Project?>) {
        self._project = project
        selectedFilter = project.wrappedValue?.filterName ?? ""
        if let image = project.wrappedValue?.imageURL.loadImageFromPath() {
            self.image = image
        } else {
            self.image = UIImage()
        }
    }
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            GeometryReader { _ in
                VStack {
                    BackHeaderView(title: "Filter")
                    Spacer()
                    imageView
                    Spacer()
                    filterListView
                }
            }
        }.onChange(of: selectedFilter) { newValue in
            project?.filterName = newValue
        }
    }
    
    private var imageView: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        }
    }
    private var filterListView: some View {
        FiltersView(selectedFilter: $selectedFilter, image: self.image, sliderValue: project?.sliderValue ?? 0.0) { sliderValue in
            project?.sliderValue = sliderValue
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        FilterListView(project: .constant(Project.previewData))
    }
}
