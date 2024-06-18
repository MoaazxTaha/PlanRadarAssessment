//
//  CoreDataController.swift
//  WeatherAssessment
//
//  Created by Moaaz Ahmed Fawzy Taha on 17/06/2024.
//

import CoreData
import Foundation

class CoreDataController: ObservableObject {
    let container = NSPersistentContainer(name: "WeatherRecords")
    
    static let shared = CoreDataController()
    init() {
        retriveSavedData()
    }
    
    func retriveSavedData() {
        container.loadPersistentStores { description, error in
            if let error {
                print("## Failed to load Core Data with error: \(error.localizedDescription)")
            }
        }
        
    }
}
