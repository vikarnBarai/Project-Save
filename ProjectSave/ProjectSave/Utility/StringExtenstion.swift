//
//  StringExtenstion.swift
//  ProjectSave
//
//  Created by Vikarn Barai on 14/08/23.
//

import Foundation
import UIKit

extension String {
    
    // Write image to directory
    func writeImageToPath(_ image: UIImage) -> String {
        
        let path = "\(self).jpg"
        let uploadURL = URL.createFolder(folderName: "project")!.appendingPathComponent(path)

        if !FileManager.default.fileExists(atPath: uploadURL.path) {
            print("File does NOT exist -- \(uploadURL) -- is available for use")
            
            if let data = image.jpegData(compressionQuality: 0.9) {
                do {
                    print("Write image")
                    try data.write(to: uploadURL)
                } catch {
                    print("Error Writing Image: \(error)")
                }

            } else {
                print("Image is nil")
            }
        } else {
            print("This file exists -- something is already placed at this location")
        }
        return self
    }

    // load image from directory
    func loadImageFromPath() -> UIImage? {

        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

        let folderURL = documentsURL.appendingPathComponent("project")
        let path = "\(self).jpg"
        let fileURL = folderURL.appendingPathComponent(path)

        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                let data = try Data.init(contentsOf: fileURL)
                let image = UIImage(data: data)
                return image
            } catch {
                print("error getting image")
            }
        } else {
            print("No image in directory")
        }

        return nil
    }
}

extension URL {
    static func createFolder(folderName: String) -> URL? {
        let fileManager = FileManager.default
        // Get document directory for device, this should succeed
        if let documentDirectory = fileManager.urls(for: .documentDirectory,
                                                    in: .userDomainMask).first {
            // Construct a URL with desired folder name
            let folderURL = documentDirectory.appendingPathComponent(folderName)
            // If folder URL does not exist, create it
            if !fileManager.fileExists(atPath: folderURL.path) {
                do {
                    // Attempt to create folder
                    try fileManager.createDirectory(atPath: folderURL.path,
                                                    withIntermediateDirectories: true,
                                                    attributes: nil)
                } catch {
                    // Creation failed. Print error & return nil
                    print(error.localizedDescription)
                    return nil
                }
            }
            // Folder either exists, or was created. Return URL
            return folderURL
        }
        // Will only be called if document directory not found
        return nil
    }
}
