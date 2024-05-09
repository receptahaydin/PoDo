//
//  NewListViewController.swift
//  Podo
//
//  Created by Recep Taha Aydın on 25.04.2024.
//

import UIKit

protocol NewListDelegate: AnyObject {
    func didCreateList(list: List)
}

class NewListViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    weak var delegate: NewListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = "Please enter a list name"
        textView.textColor = UIColor.lightGray
    }
    
    @IBAction func doneClicked(_ sender: Any) {
        guard let listName = textView.text, !listName.isEmpty, listName != "Please enter a list name" else {
            return
        }
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
        let dateString = dateFormatter.string(from: currentDate)
        
        let listData: [String: Any] = [
            "createdDate": dateString,
            "title": listName
        ]
        
        let list = List(data: listData)
        FirestoreManager().addList(list: list)
        delegate?.didCreateList(list: list)
        dismiss(animated: true, completion: nil)
    }
}

extension NewListViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Please enter a list name"
            textView.textColor = UIColor.lightGray
        }
    }
}
