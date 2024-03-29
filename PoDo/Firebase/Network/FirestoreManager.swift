//
//  FirestoreManager.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 1.03.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FirestoreManager {
    
    let db = Firestore.firestore()
    
    func addUser(user: User) {
        db.collection("Users").document(getCurrentUserID()!).setData([
            "country": user.country,
            "countryCode": user.countryCode,
            "email": user.email,
            "name": user.name,
            "phoneNumber": user.phoneNumber,
            "userId": getCurrentUserID()!
        ])
    }
    
    func addTask(task: Task) {
        db.collection("Users").document(getCurrentUserID()!).collection("Tasks").document().setData([
            "title": task.title,
            "description": task.description,
            "date": task.date,
            "time": task.time,
            "category": task.category,
            "status": task.status,
            "sessionCount": task.sessionCount,
            "completedSessionCount": task.completedSessionCount,
            "sessionDuration": task.sessionDuration,
            "shortBreakDuration": task.shortBreakDuration,
            "longBreakDuration": task.longBreakDuration
        ])
    }
    
    func readTaskFromDatabase(completion: @escaping () -> Void) {
        let tasksCollection = db.collection("Users").document(getCurrentUserID()!).collection("Tasks")

        tasksCollection.order(by: "date").getDocuments { (querySnapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                var tasks: [Task] = []
                
                for document in querySnapshot!.documents {
                    let data = document.data()
                    var task = Task(data: data)
                    task.id = document.documentID
                    tasks.append(task)
                }
                
                TaskManager.shared.tasks = tasks
                completion()
            }
        }
    }
    
    func deleteTask(taskID: String, completion: @escaping (Error?) -> Void) {
        let taskDocumentRef = db.collection("Users").document(getCurrentUserID()!).collection("Tasks").document(taskID)

        taskDocumentRef.delete { error in
            if let error = error {
                print("Error deleting task: \(error.localizedDescription)")
            } else {
                print("Task deleted successfully.")
            }

            completion(error)
        }
    }
    
    func updateTask(taskID: String, updatedData: [String: Any], completion: @escaping (Error?) -> Void) {
        let taskDocumentRef = db.collection("Users").document(getCurrentUserID()!).collection("Tasks").document(taskID)

        taskDocumentRef.updateData(updatedData) { error in
            if let error = error {
                print("Error updating task: \(error.localizedDescription)")
            } else {
                print("Task updated successfully.")
            }

            completion(error)
        }
    }
    
    func getCurrentUserID() -> String? {
        if let user = Auth.auth().currentUser {
            return user.uid
        } else {
            return nil
        }
    }
}
