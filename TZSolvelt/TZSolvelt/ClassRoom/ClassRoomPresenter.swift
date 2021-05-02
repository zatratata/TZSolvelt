//
//  ClassRoomPresenter.swift
//  TZSolvelt
//
//  Created by Default User on 5/3/21.
//

import Foundation

protocol ClassRoomViewPresenterProtocol {
    
    var coursesCount: Int { get }

    func viewDidLoad()
    func courceAt(indexPath: IndexPath) -> StudyingClassModel
    func searchBarTextDidChange(text: String)
}


final class ClassRoomViewPresenter {
    
    //MARK: - Internal properties
    weak var view: ClassRoomViewProtocol?
    
    //MARK: - Private properties
    private let interactor: ClassRoomInteractorProtocol
    
    //MARK: - Initialization
    init(interactor: ClassRoomInteractorProtocol) {
        self.interactor = interactor
    }
}

//MARK: - ClassRoomViewPresenterProtocl
extension ClassRoomViewPresenter: ClassRoomViewPresenterProtocol {
    
    func searchBarTextDidChange(text: String) {
        interactor.searchCourseFor(text: text)
    }
    
    func viewDidLoad() {
        interactor.loadData()
    }
    
    var coursesCount: Int {
        interactor.coursesCount
    }
    
    func courceAt(indexPath: IndexPath) -> StudyingClassModel {
        interactor.courceAt(indexPath: indexPath)
    }
}

extension ClassRoomViewPresenter: ClassRoomInteractorOutput {
    
    func showLoader() {
        view?.showLoader()
    }
    
    func hideLoader() {
        view?.hideLoader()
    }
    
    func updateData() {
        view?.reloadData()
    }
}
