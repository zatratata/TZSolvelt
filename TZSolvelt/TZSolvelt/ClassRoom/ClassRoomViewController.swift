//
//  ClassRoomViewController.swift
//  TZSolvelt
//
//  Created by Default User on 5/2/21.
//

import UIKit

protocol ClassRoomViewProtocol: AnyObject {
    func reloadData()
    
    func showLoader()
    func hideLoader()
}

final class ClassRoomViewController: UIViewController {
    
    private let presenter: ClassRoomViewPresenterProtocol
    
    //MARK: - GUI
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var customSearchBarContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Varibles
    private lazy var spiner = UIActivityIndicatorView(style: .large)

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.viewDidLoad()
    }
    
    init(presenter: ClassRoomViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        view.addSubview(spiner)
        spiner.center = view.center
        setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.register(UINib(nibName: StudyingClassTableViewCell.cellID, bundle: nil),
                                forCellReuseIdentifier: StudyingClassTableViewCell.cellID)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
    }
}

extension ClassRoomViewController: ClassRoomViewProtocol {
    
    func showLoader() {
        spiner.startAnimating()
        customSearchBarContainerView.isHidden = true
        tableView.isHidden = true
    }
    
    func hideLoader() {
        spiner.stopAnimating()
        customSearchBarContainerView.isHidden = false
        tableView.isHidden = false
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

//MARK: - Extensions
extension ClassRoomViewController: UITableViewDelegate {
    
}

extension ClassRoomViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.coursesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StudyingClassTableViewCell.cellID,for: indexPath) as? StudyingClassTableViewCell else {
                return UITableViewCell() }
        let course = presenter.courceAt(indexPath: indexPath)
        cell.setupCell(with: course)
        return cell
    }
}

extension ClassRoomViewController: CustomSearchBarViewDelegate {
    
    func searchBar(searchView: CustomSearchBarView, textDidChange searchText: String) {
        presenter.searchBarTextDidChange(text: searchText)
    }
    
    
    func searchButtonTapped(searchView: CustomSearchBarView)  {
        searchView.resignFirstResponder()
    }
}
