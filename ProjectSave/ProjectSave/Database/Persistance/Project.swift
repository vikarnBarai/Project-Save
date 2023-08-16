//
//  Project.swift
//  ProjectSave-CoreData
//
//  Created by Vikarn Barai on 14/08/23.
//

import Foundation
import CoreData

@objc(Project)
public class Project: NSManagedObject {
    
}

extension Project {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Project> {
        return NSFetchRequest<Project>(entityName: self.entityName)
    }
    @NSManaged public var filterName: String
    @NSManaged public var imageURL: String
    @NSManaged public var name: String
    @NSManaged public var sliderValue: Float
    
    static let entityName = "Project"
    
    static func createProject(name: String, imageUrl: String) -> Project {
        let project = Project(context: PersistenceManager.shared.context)
        project.name = name
        project.imageURL = imageUrl
        PersistenceManager.shared.saveContext()
        return project
    }
    
    static func updateImageUrl(name: String, imageURL: String) {
        do {
            if let project = try PersistenceManager.shared.context.fetch(self.fetchRequest()).first(where: {$0.name == name}) {
                project.imageURL = imageURL
                PersistenceManager.shared.saveContext()
            }
        } catch {
            
        }
    }
    
    static func updateName(oldName: String, newName: String) {
        do {
            if let project = try PersistenceManager.shared.context.fetch(self.fetchRequest()).first(where: {$0.name == oldName}) {
                project.name = newName
                PersistenceManager.shared.saveContext()
            }
        } catch {
            
        }
    }
    
    static func deleteProject(name: String) {
        do {
            if let project = try PersistenceManager.shared.context.fetch(self.fetchRequest()).first(where: {$0.name == name}) {
                PersistenceManager.shared.context.delete(project)
                PersistenceManager.shared.saveContext()

            }
        } catch {
            
        }
    }
    static func updateFilter(name: String, filterName: String, sliderValue: Float) {
        do {
            if let project = try PersistenceManager.shared.context.fetch(self.fetchRequest()).first(where: {$0.name == name}) {
                project.filterName = filterName
                project.sliderValue = sliderValue
                PersistenceManager.shared.saveContext()
            }
        } catch {
            
        }
    }
    static func getAllProject() -> [Project]? {
        do {
            return  try PersistenceManager.shared.context.fetch(self.fetchRequest())
        } catch {}
        return nil
    }
        
}

extension Project: Identifiable {
    static var previewData: Project {
            let previewData =  Project(context: PersistenceManager.shared.context)
            previewData.name = "Project 1"
            previewData.filterName = "Filter 1"
            previewData.imageURL = ""
            previewData.sliderValue = 10
            return previewData
    }
}
