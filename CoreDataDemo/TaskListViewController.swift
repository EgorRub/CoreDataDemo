//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Егор on 16.08.2021.
//

import UIKit
import CoreData

protocol TaskViewControllerDelegate {
    func reloadData()
}

class TaskListViewController: UITableViewController {
    
    // Создаем экземпляр класса AppDelegate чтобы добраться до хранилища
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let cellID = "cell"
    private var taskList: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Регисттрируем tableView через метод тк у нас нет кастомного никакого класса
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        setUpNavigationBar()
        fetchData()
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
        let newTaskVC = TaskViewController()
        newTaskVC.delegate = self
        present(newTaskVC, animated: true)
    }
    
 // Создаем метод который будеьт возвращать данные из базы
    private func fetchData() {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        do{
            taskList = try context.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
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
}

extension TaskListViewController: TaskViewControllerDelegate {
    func reloadData() {
        fetchData()
        tableView.reloadData()
    }
}


