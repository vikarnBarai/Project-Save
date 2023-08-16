//
//  ProjectiewModel.swift
//  ProjectSave
//
//  Created by Vikarn Barai on 14/08/23.
//

import Foundation

class ProjectViewModel: ObservableObject {

    @Published var projectList: [Project]
    @Published var selectedProject: Project?
    init() {
        
        self.projectList = Project.getAllProject() ?? [Project]()
        
    }
    
    private func loadProject() {
        self.projectList = Project.getAllProject() ?? [Project]()
        selectedProject = nil
        
    }
    
    public func renameProject(oldName: String, newName: String) {
        Project.updateName(oldName: oldName, newName: newName)
    }
    
    public func deleteProject(name: String) {
        Project.deleteProject(name: name)
        self.loadProject()
    }
    
}
