//
//  ProjectListView.swift
//  ProjectSave
//
//  Created by Vikarn Barai on 12/08/23.
//

import SwiftUI
import PhotosUI

struct ProjectListView: View {
    private var gridItemLayout  = [GridItem(), GridItem()]
    @ObservedObject var viewModel: ProjectViewModel
    
    @State private var pickerItem: PhotosPickerItem?
    init( viewModel: ProjectViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.background.ignoresSafeArea()
            if !viewModel.projectList.isEmpty {
                projectList
            } else {
                emptyProject
            }
            buttonView
            
        }
        
        .fullScreenCover(item: $viewModel.selectedProject) { _ in
            FilterListView(project: $viewModel.selectedProject)
        }
        .onChange(of: pickerItem) { newValue in
            Task {
                if let data = try? await newValue?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        let projectName = "Project\(viewModel.projectList.count)"
                        let project = Project.createProject(name: "Project\(viewModel.projectList.count)", imageUrl: projectName.writeImageToPath(uiImage))
                        viewModel.projectList.append(project)
                        self.viewModel.selectedProject =  project
                    }
                }
            }
        }
    }
        
    private var projectList: some View {
            ScrollView(.vertical, showsIndicators: false) {
                GeometryReader { geo in
                    LazyVGrid(columns: gridItemLayout, alignment: .center, spacing: 5) {
                        ForEach(viewModel.projectList, id: \.self) { project in
                            ProjectView(project: project)
                                .frame(width: geo.size.width/2.1, height: 180)
                                .clipped()
                                .environmentObject(viewModel)
                            
                                .onTapGesture {
                                    self.viewModel.selectedProject = project
                                }
                        }
                    }
                }
            }.padding(5)
        
    }
    private var buttonView: some View {
        PhotosPicker(selection: $pickerItem, matching: .images) {
            HStack {
                Image(systemName: "plus")
                    .fontWeight(.bold)
                    .font(.title3)
                CustomText(string: "Create Project", fontWeight: .bold, font: .title3, textColor: .white)

            }.foregroundColor(.white)
                .font(.body)
                .fontWeight(.bold)
                .frame(width: 250, height: 60)
                .background(Color.buttonColor)
                .mask(RoundedRectangle(cornerRadius: 15))
                .padding(.bottom)
        }
    }
    
    private var emptyProject: some View {
        EmptyProjectView()
    }

}

struct ProjectListView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectListView(viewModel: ProjectViewModel())
    }
}
