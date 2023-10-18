//
//  ViewController.swift
//  Airbnb
//
//  Created by dnlab on 2023/10/17.
//

import UIKit

class MainViewController: UIViewController {
    
    private let service = APIService()
    
    private var viewModel: [AirbnbListing] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(AirbnbListingTableViewCell.self, forCellReuseIdentifier: AirbnbListingTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        title = "Airbnb"
        print("main vc")
        fetchListring()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    public func fetchListring() {
        service.getListings { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let models):
                    self?.viewModel = models
//                    print(self?.viewModel.count)
//                    print(models)
                    self?.tableView.reloadData()
                case .failure:
                    break
                }
            }
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AirbnbListingTableViewCell.identifier) as? AirbnbListingTableViewCell else {
            fatalError()
        }
        cell.accessoryType = .disclosureIndicator
        cell.configure(with: viewModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewModel = self.viewModel[indexPath.row]
        DispatchQueue.main.async {
            let vc = AirbnbDetailScrollViewViewController(model: viewModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

