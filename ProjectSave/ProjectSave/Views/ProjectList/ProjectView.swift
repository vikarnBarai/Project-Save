//
//  ProjectView.swift
//  ProjectSave
//
//  Created by Vikarn Barai on 12/08/23.
//

import SwiftUI

struct ProjectView: View {
    let project: Project
    @EnvironmentObject var viewModel: ProjectViewModel
    @State private var showingDeleteConfirm: Bool = false
    @State private var showingRenameConfirm: Bool = false
    @State private var projectName: String = ""
    @State private var isRenameAlert: Bool  = false
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if let image = project.imageURL.loadImageFromPath() {
                Image(uiImage: image)
                    .resizable()
                    .frame(height: 130)
                    .clipped()
            }
            HStack {
                CustomText(string: project.name, fontWeight: .semibold, font: .title3)
                Spacer()
                Button {
                    showingRenameConfirm.toggle()
                }label: {
                    Image("dots")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 25)
                        .padding(.horizontal, 5)
                }
            }
        }.padding(5)
        .background(.regularMaterial)
        .border(.pink)
        .mask(Rectangle())
        .shadow(radius: 7, x: 0, y: 5)
        .clipped()
        
        .confirmationDialog("Are you sure you want delete project?", isPresented: $showingDeleteConfirm) {
            Button("Yes") {
                withAnimation(.easeOut) {
                    viewModel.deleteProject(name: project.name)}
                }
            Button("No") {  }
            
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want delete project?")
        }
        .confirmationDialog("Project", isPresented: $showingRenameConfirm) {
            Button("Rename") { isRenameAlert.toggle() }
            Button("Delete") { showingDeleteConfirm.toggle()  }
            
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Project")
        }
        .alert("Rename Project", isPresented: $isRenameAlert) {
                   TextField("Enter Project name", text: $projectName)
                       .textInputAutocapitalization(.never)
                
            Button("Done", action: {
                if projectName.count > 3 {
                    withAnimation(.easeOut) {
                        viewModel.renameProject(oldName: project.name, newName: projectName)
                    }
                }
                
            })
                   Button("Cancel", role: .cancel) { }
               } message: {
                   
               }
    }
}

struct ProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView(project: Project.previewData)
            .environmentObject(ProjectViewModel())
            .frame(width: 200, height: 200)
    }
}
