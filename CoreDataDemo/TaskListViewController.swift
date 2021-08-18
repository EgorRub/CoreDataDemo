//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Егор on 16.08.2021.
//

import UIKit
import CoreData

class TaskListViewController: UITableViewController {
    

    private let context = (StorageManager.shared.persistentContainer.viewContext)
    private let funcs = StorageManager.shared
    private var taskList: [Task] = []
    private let cellID = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Регистрируем tableView через метод тк у нас нет кастомного никакого класса
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        setUpNavigationBar()
        taskList = funcs.fetchData()
    }

    private func setUpNavigationBar() {
        title = "Task List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Создаем жкземпляр класса отвечающего за Navigation Bar
        let navBarAppearence = UINavigationBarAppearance()
        // параметр отвечает за прозрачноть NAvBar,свойство для красоты
        navBarAppearence.configureWithOpaqueBackground()
        // Задаем цвет для маленького заголовка, отвечает за цвет текста titileTextAttributes
        navBarAppearence.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearence.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navBarAppearence.backgroundColor = UIColor(
            red: 21/255,
            green: 101/255,
            blue: 192/255,
            alpha: 194/255
        )
        
        navigationController?.navigationBar.standardAppearance = navBarAppearence
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearence
        
        // Добавляем кнопку
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewTask)
        )
        
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    // ТК у нас нет сториборда - то мы можем просто создать экземпляр класса следующего сторборда который мы хотим открыть и без prepare for segue
    @objc private func addNewTask() {
        showAlert(with: "New Task", message: "What do you want to do?")
    }
    
    private func showAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let task = alert.textFields?.first?.text else { return }
            self.save(task)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        alert.addTextField { textFiled in
            textFiled.placeholder = "New Task"
        }
        present(alert, animated: true)
        
    }
    
    
    private func save(_ taskName: String) {
        guard let entityDiscribtion = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        guard let task = NSManagedObject(entity: entityDiscribtion, insertInto: context) as? Task else { return }
        task.name = taskName
        taskList.append(task)

        let cellIndexPath = IndexPath(row: taskList.count - 1, section: 0)
        tableView.insertRows(at: [cellIndexPath], with: .automatic)

        if context.hasChanges {
            do{
                try context.save()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
}
// Поработаем над методами tableView Table Source

extension TaskListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let task = taskList[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = task.name
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteRowAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completion) in

            let task = self.taskList[indexPath.row]
            self.context.delete(task)
            self.dismiss(animated: true)
            do{
                try self.context.save()
            } catch let error {
                print(error.localizedDescription)
            }
            self.tableView.reloadData()
        }
        let swipeAction = UISwipeActionsConfiguration(actions: [deleteRowAction])
        return swipeAction
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Edit", message: "Please Edit Text", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let textField = alert.textFields?.first?.text else { return }
            let task = self.taskList[indexPath.row]
            task.name = textField
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        alert.addTextField { textFiled in
            textFiled.placeholder = "New Task"
        }
        present(alert, animated: true)
    }
}






