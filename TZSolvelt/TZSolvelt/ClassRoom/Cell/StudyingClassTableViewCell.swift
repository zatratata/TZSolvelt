//
//  StudyingClassTableViewCell.swift
//  TZSolvelt
//
//  Created by Default User on 5/2/21.
//

import UIKit

final class StudyingClassTableViewCell: UITableViewCell {
    
    //MARK: - Constants
    private let completedStateViewColor = UIColor(named: "themeGreenColor")
    private let inProgressStateViewColor = UIColor(named: "themeOrangeColor")
    private let notStartedStateViewColor = UIColor(named: "themePurpleColor")
    private let englishClassImage = UIImage(named: "englishBackgroundImage")
    private let otherClassImage = UIImage(named: "otherClassBackgroundImage")
    private let englishType = "english"
    private let backgroundImageCornerRadius: CGFloat = 5
    private let stateViewCornerRadius: CGFloat = 4
    private let lastUpdateTextForToday = "Today"
    private let lastUpdateStartText = "Last update: "
    
    static let cellID = "StudyingClassTableViewCell"
    
    //MARK: - GUI
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var classStateView: UIView!
    @IBOutlet weak var classStateLabel: UILabel!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    //MARK: - Methods
    func setupCell(with model: StudyingClassModel) {
        titleLabel.text = model.name
        setupClassStateView(for: model.classStatus)
        if model.type == englishType {
            backgroundImageView.image = englishClassImage
        } else {
            backgroundImageView.image = otherClassImage
        }
        backgroundImageView.layer.cornerRadius = backgroundImageCornerRadius
        classStateView.layer.cornerRadius = stateViewCornerRadius
        setupLastUpdateLabel(with: model.lastUpdate)
    }
    
    private func setupClassStateView(for state: StudyingClassModel.State?) {
        guard let state = state else {
            classStateView.isHidden = true
            return
        }
        switch state {
        case .inProgress:
            classStateView.backgroundColor = inProgressStateViewColor
        case .completed:
            classStateView.backgroundColor = completedStateViewColor
        case .notStarted:
            classStateView.backgroundColor = notStartedStateViewColor
        }
        classStateLabel.text = NSLocalizedString(state.rawValue, comment: "")
    }
    
    private func setupLastUpdateLabel(with date: Date?) {
        guard let date = date else {
            lastUpdateLabel.text = ""
            return
        }
        if date.isToday() {
            lastUpdateLabel.text = lastUpdateStartText + lastUpdateTextForToday
        } else {
            let dateFormatter = DateFormatter()
            lastUpdateLabel.text = lastUpdateStartText + dateFormatter.preferredFormatString(from: date)
        }
    }
}
