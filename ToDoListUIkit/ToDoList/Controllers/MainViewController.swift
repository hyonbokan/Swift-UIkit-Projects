//
//  ViewController.swift
//  ToDoList
//
//  Created by Michael Kan on 2023/10/06.
//

import UIKit

class MainViewController: UIViewController {
    
    private var viewModels: [ToDoListItem] = []
    
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(ToDoListItemTableViewCell.self, forCellReuseIdentifier: ToDoListItemTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "To Do List"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .font: UIFont.boldSystemFont(ofSize: 35)
        ]
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddItem))
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchItems()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    @objc private func didTapAddItem() {
        let vc = NewItemViewController()
        vc.completion = { [weak self] in
            self?.fetchItems()
            self?.tableView.reloadData()
        }
        present(vc, animated: true)
    }
    
    private func fetchItems() {
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
            return
        }
        DatabaseManager.shared.findItem(userId: userId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case.success(let items):
                    self?.viewModels = items
//                    print(self?.viewModels)
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
                    break
                }
            }
        }
    }


}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoListItemTableViewCell.identifier) as? ToDoListItemTableViewCell else {
            fatalError()
        }
        cell.delegate = self
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
            guard let userId = UserDefaults.standard.string(forKey: "userId") else {
                return
            }
            
            let cell = self.viewModels[indexPath.row]
            DatabaseManager.shared.deleteItem(userId: userId, itemId: cell.id) { success in
                if success {
                    self.viewModels.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
                completion(success)
            }
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
}

extension MainViewController: ToDoListItemTableViewCellDelegate {
    func toDoListItemTableViewCell(_ cell: ToDoListItemTableViewCell) {
        guard var viewModel = cell.viewModel else {
            return
        }
        DatabaseManager.shared.toggleIsDone(item: viewModel) { result in
                    if result {
                        viewModel.setDone(!viewModel.isDone)
                        cell.configure(with: viewModel)
                    } else {
                        print("Error")
                    }
                }
            }
}
