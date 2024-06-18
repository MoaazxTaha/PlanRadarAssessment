//
//  Style.swift
//  WeatherAssessment
//
//  Created by Moaaz Ahmed Fawzy Taha on 17/06/2024.
//

import Foundation

enum Style {
    
    enum Fonts {
        // Headlines
        static let headline: UIFont = .systemFont(ofSize: 16, weight: .bold)
    }
    enum Padding {
        /// 1
        public static let singleUnit: CGFloat = 1.0
        /// 2
        public static let quarter: CGFloat = 2.0
        /// 4
        public static let half: CGFloat = 4.0
        /// 8
        public static let single: CGFloat = 8.0
        /// 12
        public static let medium: CGFloat = 12.0
        /// 16
        public static let double: CGFloat = 16.0
        /// 24
        public static let triple: CGFloat = 24.0
        /// 32
        public static let quadruple: CGFloat = 32.0
        /// 40
        public static let quintuple: CGFloat = 40.0
    }}
