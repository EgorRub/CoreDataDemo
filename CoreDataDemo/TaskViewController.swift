//
//  TaskViewController.swift
//  CoreDataDemo
//
//  Created by Егор on 16.08.2021.
//

import UIKit
import CoreData

class TaskViewController: UIViewController {
    
    // Создаем экземпляр класса AppDelegate чтобы добраться до хранилища
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
   
    // создаем текстовое поле, lazy - поле будет инициализировать только тогда когда мы к нему обратимся
    private lazy var taskTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "New Task"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = UIColor(
            red: 21/255,
            green: 101/255,
            blue: 192/255,
            alpha: 194/255
        )
        button.setTitle("Save Task", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        
        button.addTarget(self, action: #selector(save), for: .touchUpInside)
        return button
    }()
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUp(subviews: taskTextField, saveButton, cancelButton)
        setConstrains()
    }
    
    // Создаем функцию чтобы вызвать на экране метод taskFieldText, чтобы не разрасталась ViewDidLoad, это массив котторый мы перебираем
    private func setUp(subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    private func setConstrains() {
        // Выключаем это свйоство чтобы поработать с консттрейнатми, выключаем тем самым авто растановку элементов
        taskTextField.translatesAutoresizingMaskIntoConstraints = false
        // Активируем массиив констрейнтов
        NSLayoutConstraint.activate([
            taskTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            taskTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            taskTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        // Активируем массиив констрейнтов
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        // Активируем массиив констрейнтов
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    @objc private func save() {
        guard let entityDiscribtion = NSEntityDescription.entity(forEntityName: "Task", in: context) else {
            return
        }
        guard let task = NSManagedObject(entity: entityDiscribtion, insertInto: context) as? Task else { return }
        task.name = taskTextField.text
        // Необходимо сохранить внесенные изменения
        
        
        dismiss(animated: true)
    }
    
    @objc private func cancel() {
        dismiss(animated: true)
    }
    
}
