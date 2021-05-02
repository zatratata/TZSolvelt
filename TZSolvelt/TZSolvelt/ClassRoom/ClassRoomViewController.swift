//
//  ClassRoomViewController.swift
//  TZSolvelt
//
//  Created by Default User on 5/2/21.
//

import UIKit

final class ClassRoomViewController: UIViewController {
    
    //MARK: - GUI
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var customSearchBarContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    //MARK: - Methods
    private func setup() {
        guard let searchBar = CustomSearchBarView.view() else { return }
        customSearchBarContainerView.addSubview(searchBar)
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: customSearchBarContainerView.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: customSearchBarContainerView.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: customSearchBarContainerView.trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: customSearchBarContainerView.bottomAnchor)
        ])
    }
}


//MARK: - Extensions
extension ClassRoomViewController: CustomSearchBarViewDelegate {
    func searchBar(searchView: CustomSearchBarView, textDidChange searchText: String) {
        
    }
    
    
    func searchButtonTapped(searchView: CustomSearchBarView)  {
        searchView.resignFirstResponder()
    }
}
