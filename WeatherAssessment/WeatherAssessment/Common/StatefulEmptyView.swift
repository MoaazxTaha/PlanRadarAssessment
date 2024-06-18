//
//  SessionDataController.swift
//  WeatherAssessment
//
//  Created by Moaaz Ahmed Fawzy Taha on 17/06/2024.
//

import SFSafeSymbols
import SwiftUI

public struct StatefulEmptyView: View {
    var title: String
    var systemSumbl: SFSymbol?

    public init(title: String, systemSumbl: SFSymbol? = nil) {
        self.title = title
        self.systemSumbl = systemSumbl
    }

    public var body: some View {
        VStack(alignment: .center) {
            Spacer()
            if let systemSumbl = systemSumbl {
                Image(systemSymbol: systemSumbl)
                    .font(.title)
                    .foregroundColor(.gray)
                    .padding(.bottom, Style.Padding.half)
            }
            Text(title)
                .foregroundColor(.gray)
            Spacer()
        }
        .padding()
    }
}
