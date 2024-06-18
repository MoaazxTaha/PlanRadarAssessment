//
//  WeatherAssessmentApp.swift
//  WeatherAssessment
//
//  Created by Moaaz Ahmed Fawzy Taha on 15/06/2024.
//

import SwiftUI

@main
struct WeatherAssessmentApp: App {
    let coredataController = CoreDataController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coredataController.container.viewContext)
        }
    }
}
