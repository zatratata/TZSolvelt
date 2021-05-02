//
//  CustomSearchBarView.swift
//  TZSolvelt
//
//  Created by Default User on 5/2/21.
//

import UIKit

protocol CustomSearchBarViewDelegate: AnyObject {
    func searchButtonTapped(searchView: CustomSearchBarView)
    func searchBar(searchView: CustomSearchBarView, textDidChange searchText: String)
}

final class CustomSearchBarView: UIView {
    
    //MARK: - Constants
    private let buttonCornerRadius: CGFloat = 20
    private let bottomLineHeight: CGFloat = 1
    private let textFieldFont = UIFont(name: "Helvetica", size: 16)
    private let placeholderColor = UIColor(named: "searchBarTextColor") ?? .lightGray
    private let placeholderText = "Search"
    private let bottomLineColor = UIColor(named: "searchBarBottomLineColor") ?? .gray
    private let imageViewBackgroundColor = UIColor(named: "searchImageViewBackgroundColor") ?? .cyan
    private let imageViewTintColor = UIColor(named: "themeGreenColor") ?? .green
    
    //MARK: - Variables
    weak var delegate: CustomSearchBarViewDelegate?
    private var searchBarVeiw: UIView {
        searchBar.subviews[0]
    }
    
    //MARK: - GUI
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTextField()
        addLine()
        setupButton()
    }
    
    class func view() -> CustomSearchBarView? {
        let nib = Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)
        return nib?.first as? CustomSearchBarView
    }
    
    //MARK: - Mehtods
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        return searchBar.resignFirstResponder()
    }
    
    private func setupTextField() {
        searchBar.barTintColor = .white
        backgroundColor = .white
        searchBar.delegate = self
        searchBar.isTranslucent = false
        searchBarVeiw.layer.borderWidth = 1
        searchBarVeiw.layer.borderColor = UIColor.white.cgColor
        searchBar.searchTextField.leftView = nil
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextPositionAdjustment = UIOffset(horizontal: -5, vertical: 0)
        searchBar.searchTextField.font = textFieldFont
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes:[NSAttributedString.Key.foregroundColor: placeholderColor])
    }
    
    private func addLine() {
        let lineView = UIView()
        lineView.backgroundColor = bottomLineColor
        searchBarVeiw.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: searchBar.searchTextField.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: searchBar.searchTextField.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: searchBar.searchTextField.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: bottomLineHeight)
        ])
    }
    
    private func setupButton() {
        searchButton.layer.cornerRadius = buttonCornerRadius
        searchButton.backgroundColor = imageViewBackgroundColor
        searchBar.tintColor = imageViewTintColor
    }
    
    func setToSearchBar(delegate: UISearchBarDelegate) {
        searchBar.delegate = delegate
    }
    
    //MARK: - Actions
    @IBAction func searchButtonTap(_ sender: UIButton) {
        searchBar.becomeFirstResponder()
        delegate?.searchButtonTapped(searchView: self)
    }
}

//MARK: - Extension
extension CustomSearchBarView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.searchBar(searchView: self, textDidChange: searchText)
    }
}
