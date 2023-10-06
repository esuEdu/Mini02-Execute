//
//  ListAllTasks.swift
//  DailyTask
//
//  Created by Victor Hugo Pacheco Araujo on 04/10/23.
//

import Foundation
import UIKit

class ListAllTasks: UIViewController {
  
  let stackViewForHeader: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    return stackView
  }()
  
  let createTask: UIButton = {
    let button = UIButton()
    button.setTitle("+ \(String(localized: "NewTaskKey"))", for: .normal)
    
    button.translatesAutoresizingMaskIntoConstraints = false
    
    var config = UIButton.Configuration.filled()
    
    config.baseBackgroundColor = .systemBlue
    config.background.cornerRadius = 10
    
    let spacing: CGFloat = 5
    config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)
    
    button.configuration = config
    
    return button
  }()
  
  let dateNow: LabelComponent = {
    
    let nowDate = Date.now
    let dateFormatter = DateFormatter()
    
    dateFormatter.locale = .current
    
    var language = ""
    
    if let preferredLanguage = Locale.preferredLanguages.first {
        let locale = Locale(identifier: preferredLanguage)
      let languageCode = locale.language.languageCode?.identifier // Código do idioma, por exemplo, "en" para inglês
      let regionCode = locale.region?.identifier // Código da região, por exemplo, "US" para Estados Unidos
      
      language = languageCode ?? ""
    }
    
    if language == "en" {
      dateFormatter.dateFormat = "dd, MMMM"
    } else if language == "pt" {
      dateFormatter.dateFormat = "dd 'de' MMMM"
    } else {
      dateFormatter.dateStyle = .medium
      dateFormatter.timeStyle = .none
    }
    
    let data = dateFormatter.string(from: nowDate)
    
    let label = LabelComponent(text: data, accessibilityLabel: data, font: .title1)
    label.translatesAutoresizingMaskIntoConstraints =  false
    label.textLabel.font = .boldTitle1
    return label
  }()
  
  let searchBar: UISearchBar = {
    let search = UISearchBar()
    search.placeholder = String(localized: "SearchTaskProjectKey")
    search.translatesAutoresizingMaskIntoConstraints = false
    search.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    return search
  }()
  
  let projectName: LabelComponent = {
    let project = LabelComponent(text: "Titulo do projeto", accessibilityLabel: "")
    project.translatesAutoresizingMaskIntoConstraints = false
    return project
  }()
  
  let projectNameStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fill
    stackView.backgroundColor = .systemGreen
    stackView.layer.cornerRadius = 10
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  let tasksComponent: AllTaskListComponts = {
    let tasks = AllTaskListComponts(titleTask: "teste", timeLabel: "hoje")
    tasks.translatesAutoresizingMaskIntoConstraints = false
    return tasks
  }()
  
  
  

  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
    setupConstraints()
  }
  
  func setUI(){
    
    view.backgroundColor = .systemBackground
    
    navigationController?.setNavigationBarHidden(true, animated: true)
    
    view.addSubview(stackViewForHeader)
    view.addSubview(searchBar)
    
    searchBar.delegate = self
    
    stackViewForHeader.addArrangedSubview(dateNow)
    stackViewForHeader.addArrangedSubview(createTask)
    
    view.addSubview(projectNameStackView)
    
    projectNameStackView.addArrangedSubview(projectName)
    
    view.addSubview(tasksComponent)
    
    
//    createTask.addTarget(self, action: #selector(createNewTask), for: .touchUpInside)
    
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      stackViewForHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
      stackViewForHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      stackViewForHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      stackViewForHeader.bottomAnchor.constraint(equalTo: searchBar.topAnchor, constant: -10),

        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
      searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -7),
   
      projectNameStackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
      projectNameStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      projectNameStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      projectNameStackView.heightAnchor.constraint(equalToConstant: 45),
  
      tasksComponent.topAnchor.constraint(equalTo: projectName.bottomAnchor, constant: 19),
      tasksComponent.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tasksComponent.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
  }
  
}

//extension ListAllTasks {
//  @objc func createNewTask(){
//    
//  }
//}

extension ListAllTasks: UISearchBarDelegate {
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
      searchBar.setShowsCancelButton(true, animated: true)
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
      searchBar.setShowsCancelButton(false, animated: true)
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
      searchBar.endEditing(true)
  }
  
}

#Preview{
  ListAllTasks()
}
