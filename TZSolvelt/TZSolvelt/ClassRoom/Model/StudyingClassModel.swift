//
//  StudyingClassModel.swift
//  TZSolvelt
//
//  Created by Default User on 5/2/21.
//

import Foundation

final class StudyingClassModel: Decodable {
    
    let id: Int
    let type: String
    let name: String
    private let updateAt: Int
    private let status: String
    
    enum State: String {
        case inProgress = "inProgress"
        case completed = "completed"
        case notStarted = "notStarted"
        
        var title: String {
            switch self {
            case .inProgress:
                return "In Progress"
            case .completed:
                return "Completed"
            case .notStarted:
                return "Start"
            }
        }
    }
    
    //MARK: - Computed properties
    var classStatus: StudyingClassModel.State? {
        return StudyingClassModel.State(rawValue: status)
    }
    
    var lastUpdate: Date {
        Date(timeIntervalSince1970: TimeInterval(updateAt))
    }
}
