//
//  CreateTaskViewController.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 6.02.2024.
//

import UIKit

class CreateTaskViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var categoryTextField: DesignableUITextField!
    @IBOutlet weak var sessionStepper: UIStepper!
    @IBOutlet weak var sessionLabel: UILabel!
    @IBOutlet weak var longBreakStepper: UIStepper!
    @IBOutlet weak var longBreakLabel: UILabel!
    @IBOutlet weak var shortBreakStepper: UIStepper!
    @IBOutlet weak var shortBreakLabel: UILabel!
    
    var categories = ["Working", "Reading", "Coding", "Researching", "Training", "Meeting"]
    
    let pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        categoryTextField.inputView = pickerView
        setDateComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDateComponents()
    }
    
    private func setDateComponents() {
        let calendar = Calendar(identifier: .gregorian)
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
        let minDate = calendar.date(byAdding: components, to: currentDate)!
        datePicker.minimumDate = minDate
    }
    
    @IBAction func sessionValueChanged(_ sender: UIStepper) {
        let stepperValue = sessionStepper.value
        sessionLabel.text = "\(Int(stepperValue))"
    }
    
    @IBAction func longBreakValueChanged(_ sender: UIStepper) {
        let stepperValue = longBreakStepper.value
        longBreakLabel.text = "\(Int(stepperValue))"
    }
    
    @IBAction func shortBreakValueChanged(_ sender: UIStepper) {
        let stepperValue = shortBreakStepper.value
        shortBreakLabel.text = "\(Int(stepperValue))"
    }
}

extension CreateTaskViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextField.text = categories[row]
    }
}
