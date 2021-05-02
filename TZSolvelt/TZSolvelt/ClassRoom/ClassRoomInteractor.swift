//
//  ClassRoomInteractor.swift
//  TZSolvelt
//
//  Created by Default User on 5/3/21.
//

import Foundation

protocol ClassRoomInteractorProtocol {
    
    var coursesCount: Int { get }
    
    func loadData()
    func courceAt(indexPath: IndexPath) -> StudyingClassModel
    func searchCourseFor(text: String)
}

protocol ClassRoomInteractorOutput: AnyObject {
    func updateData()
    
    func showLoader()
    func hideLoader()
}

final class ClassRoomInteractor {
    
    //MARK: - Internal properties
    weak var output: ClassRoomInteractorOutput?
    
    //MARK: - Private properties
    private var dataService: DataManager
    private var allCourses: [StudyingClassModel] = []
    private var courses: [StudyingClassModel] = [] {
        didSet {
            output?.updateData()
        }
    }
    
    //MARK: - Initialization
    init(dataManager: DataManager = DataManager.shared) {
        self.dataService = dataManager
    }
}

extension ClassRoomInteractor: ClassRoomInteractorProtocol {
    
    func searchCourseFor(text: String) {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            courses = allCourses
            return
        }
        courses = allCourses.filter({ $0.name.lowercased().contains(text.lowercased()) })
    }
    
    var coursesCount: Int {
        return courses.count
    }
    
    func courceAt(indexPath: IndexPath) -> StudyingClassModel {
        return courses[indexPath.row]
    }
    
    func loadData() {
        output?.showLoader()
        dataService.fetchData { [weak self] (result) in
            self?.output?.hideLoader()
            switch result {
            case .success(let courses):
                self?.allCourses = courses
                self?.courses = courses
                
            case .failure(let error):
                print("Error \(error.localizedDescription)")
            }
        }
    }
}
