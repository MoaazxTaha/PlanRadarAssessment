//
//  LocationModel.swift
//  TryCitiesListView
//
//  Created by Moaaz Ahmed Fawzy Taha on 14/06/2024.
//

import Foundation
import MapKit
import Combine

public struct LocationModel: Hashable, Identifiable {
    public var id = UUID()
    var title: String
    var subtitle: NSMutableAttributedString
    
    init(mapItem: MKMapItem) {
        let attributedString = NSMutableAttributedString(string: mapItem.placemark.title ?? "")
        self.title = mapItem.placemark.title ?? ""
        self.subtitle = NSMutableAttributedString(string: mapItem.placemark.subtitle ?? "")
    }
    
    init(suggesionItem: MKLocalSearchCompletion) {
        let titleAttributedString = NSMutableAttributedString(string: suggesionItem.title)
        let boldFont = UIFont.boldSystemFont(ofSize: 16)
        let boldAttributes: [NSAttributedString.Key: Any] = [.font: boldFont]
        let highlightedRanges = suggesionItem.titleHighlightRanges.map { $0.rangeValue}
        
        highlightedRanges.forEach {
            titleAttributedString.addAttributes(boldAttributes, range:  $0)
        }
        self.title = suggesionItem.title
        
        let subtitleAttributedString = NSMutableAttributedString(string: suggesionItem.title)
        let subtitleHighlightedRanges = suggesionItem.titleHighlightRanges.map { $0.rangeValue}
        
        subtitleHighlightedRanges.forEach {
            subtitleAttributedString.addAttributes(boldAttributes, range:  $0)
        }

        self.subtitle = subtitleAttributedString
    }
}
