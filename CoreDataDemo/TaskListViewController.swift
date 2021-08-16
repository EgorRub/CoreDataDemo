//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Егор on 16.08.2021.
//

import UIKit

class TaskListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpNavigationBar()
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
    @objc private func addNewTask() {
        
    }
    
}

