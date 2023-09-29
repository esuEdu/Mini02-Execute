//
//  CreateTaskView.swift
//  DailyTask
//
//  Created by Victor Hugo Pacheco Araujo on 24/09/23.
//

import Foundation
import UIKit

class CreateTaskView: UIViewController {
  var viewModel: CreateTaskViewModel?
  
  var dateStart: Date?
  var dateEnd: Date?
  
  let segmentedControl = SegmentedControl()

  let nameTextField: TextFieldToName = {
      let textField = TextFieldToName()
    textField.textFieldToGetTheName.placeholder = String(localized: "PlaceholderNameTask", comment: "Placeholder text name task")
      textField.translatesAutoresizingMaskIntoConstraints = false
      return textField
  }()
  
  let desc: UITextView = {
      let description = UITextView()
    description.layer.cornerRadius = 10
    description.translatesAutoresizingMaskIntoConstraints = false
      return description
  }()
  
  let startDate: DatePickerView<Date> = {
    let date = DatePickerView<Date>()
    date.datePickerMode = .dateAndTime
    date.translatesAutoresizingMaskIntoConstraints = false
    return date
  }()
  
  let endDate: DatePickerView<Date> = {
    let date = DatePickerView<Date>()
    date.datePickerMode = .dateAndTime
    date.translatesAutoresizingMaskIntoConstraints = false
    return date
  }()
  
  let buttonDone: UIBarButtonItem = {
    let button = UIBarButtonItem()
    button.title = String(localized: "CreateTaskButton", comment: "Button in the navigation bar that create the task")
    return button
  }()
  
  let buttonCancel: UIBarButtonItem = {
    let button = UIBarButtonItem()
    button.title = String(localized: "CancelTaskButton", comment: "Button in the navigation bar that cancel the task creation")
    button.tintColor = .red
    return button
  }()
  
  let labelDateStart: UILabel = {
    let label = UILabel()
    label.text = String(localized: "StartDateLabel", comment: "text of start date of the task creation")
    label.numberOfLines = 1
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let labelDateEnd: UILabel = {
    let label = UILabel()
    label.text = String(localized: "EndDateLabel", comment: "text of end date")
    label.numberOfLines = 1
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let icon: ChooseIconComponent = {
    let icon = ChooseIconComponent()
    icon.iconName = "pencil.tip"
    icon.translatesAutoresizingMaskIntoConstraints = false
    return icon
  }()
  
  let colorPicker: ColorChooseComponent = {
    let colorPicker = ColorChooseComponent()
    colorPicker.translatesAutoresizingMaskIntoConstraints = false
    return colorPicker
  }()

  var priorityContainer: ContainerComponent?
  var testeContainer: ContainerComponent?
  
  let stackViewContainerHorizontal: UIStackView = {
      let stackView = UIStackView()
      stackView.axis = .horizontal
      stackView.alignment = .fill
      stackView.spacing = 25
      stackView.translatesAutoresizingMaskIntoConstraints = false
      return stackView
  }()
  
  let stackViewContainerVertical: UIStackView = {
      let stackView = UIStackView()
      stackView.axis = .vertical
      stackView.alignment = .fill
      stackView.spacing = 25
      stackView.translatesAutoresizingMaskIntoConstraints = false
      return stackView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = String(localized: "CreateTaskTitleKey")
    view.backgroundColor = .systemBackground
    
    nameTextField.textFieldToGetTheName.returnKeyType = .done
    nameTextField.textFieldToGetTheName.autocapitalizationType = .none
    nameTextField.textFieldToGetTheName.autocorrectionType = .no
    nameTextField.textFieldToGetTheName.keyboardAppearance = .default
    nameTextField.textFieldToGetTheName.becomeFirstResponder()
    nameTextField.delegate = self
    
    desc.isEditable = true
    desc.backgroundColor = .systemGray3
    desc.textContainerInset = .init(top: 10, left: 10, bottom: 10, right: 10)
    desc.delegate = self
    
    navigationItem.rightBarButtonItem = buttonDone
    navigationItem.leftBarButtonItem = buttonCancel
    
    buttonDone.target = self
    buttonDone.action = #selector(createTask)
    
    buttonCancel.target = self
    buttonCancel.action = #selector(cancelTask)
    
    startDate.valueChangedHandler = { selectedDate in
      self.dateStart = selectedDate
    }
    
    endDate.valueChangedHandler = { selectedDate in
      self.dateEnd = selectedDate
    }
  
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    
    priorityContainer = ContainerComponent(text: String(localized: "PriorityName"), textColor: .black, components: [segmentedControl])
    priorityContainer?.translatesAutoresizingMaskIntoConstraints = false
    
    testeContainer = ContainerComponent(text: "teste", components: [startDate])
    testeContainer?.translatesAutoresizingMaskIntoConstraints = false
    
    
    
    view.addSubview(nameTextField)
//    view.addSubview(desc)
//    view.addSubview(startDate)
//    view.addSubview(endDate)
//    view.addSubview(labelDateStart)
//    view.addSubview(labelDateEnd)
//    view.addSubview(segmentedControl)
    view.addSubview(icon)
    view.addSubview(colorPicker)
    
    view.addSubview(stackViewContainerHorizontal)
    view.addSubview(stackViewContainerVertical)
    
    stackViewContainerHorizontal.addArrangedSubview(icon)
    stackViewContainerHorizontal.addArrangedSubview(nameTextField)
    stackViewContainerHorizontal.addArrangedSubview(colorPicker)
    
    stackViewContainerVertical.addArrangedSubview(priorityContainer!)
    stackViewContainerVertical.addArrangedSubview(testeContainer!)

    setConstraints()
  }
  
  func setConstraints() {
  
    NSLayoutConstraint.activate([
      
//      icon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//      icon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
//      icon.trailingAnchor.constraint(equalTo: nameTextField.leadingAnchor, constant: -20),
//      icon.bottomAnchor.constraint(equalTo: colorPicker.bottomAnchor),
//      icon.heightAnchor.constraint(equalToConstant: 93),
//      icon.widthAnchor.constraint(equalToConstant: 93),
//
//      nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//      nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
//      nameTextField.leadingAnchor.constraint(equalTo: icon.trailingAnchor),
//      nameTextField.bottomAnchor.constraint(equalTo: colorPicker.topAnchor, constant: -14),
//      
//      colorPicker.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 14),
//      colorPicker.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
//      colorPicker.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
//      colorPicker.bottomAnchor.constraint(equalTo: icon.bottomAnchor),
      
      stackViewContainerHorizontal.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
      stackViewContainerHorizontal.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
      stackViewContainerHorizontal.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
      
      stackViewContainerVertical.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 25),
      stackViewContainerVertical.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
      stackViewContainerVertical.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
//      timeTaskContainer!.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 200),
      
    
        
//     desc.topAnchor.constraint(equalTo: colorPicker.bottomAnchor, constant: 30),
//     desc.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
//     desc.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
//      desc.heightAnchor.constraint(equalTo: nameTextField.heightAnchor, multiplier: 10),
//      
//      startDate.topAnchor.constraint(equalTo: desc.bottomAnchor, constant: 30),
//      startDate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
//      
//      endDate.topAnchor.constraint(equalTo: startDate.bottomAnchor, constant: 20),
//      endDate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
//      
//      labelDateStart.topAnchor.constraint(equalTo: startDate.topAnchor),
//      labelDateStart.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
//      labelDateStart.bottomAnchor.constraint(equalTo: startDate.bottomAnchor),
//      
//      labelDateEnd.topAnchor.constraint(equalTo: endDate.topAnchor),
//      labelDateEnd.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
//      labelDateEnd.bottomAnchor.constraint(equalTo: endDate.bottomAnchor),
//      
//      segmentedControl.topAnchor.constraint(equalTo: endDate.bottomAnchor, constant: 20),
//      segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//      segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      
    ])
  }
  
}

extension CreateTaskView: TextFieldToNameDelegate, UITextViewDelegate {
  func textFieldDidEndEditing() {
    
  }
  
  func textFieldDidBeginEditing() {
    
  }

//  @objc func tappedAwayFunction(){
//    desc.resignFirstResponder()
//  }
  
  @objc func createTask() {
    
    self.viewModel?.createTask(name: self.nameTextField.textFieldToGetTheName.text != "" ? self.nameTextField.textFieldToGetTheName.text! : "Sem nome", startDate: self.dateStart ?? Date.now, endDate: self.dateEnd ?? Date.now, priority: self.segmentedControl.priority ?? Priority.noPriority.rawValue, descript: self.desc.text != "" ? self.desc.text! : "Sem descrição")
  
    viewModel?.removeLastView()
  }
  
  @objc func cancelTask(){
    viewModel?.removeLastView()
  }
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    print("inside of textViewDidBeginEditing")
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    print("inside of textViewDidEndEditing")
  }

}


#Preview {
  CreateTaskView()
}
