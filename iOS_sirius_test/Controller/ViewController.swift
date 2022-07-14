//
//  ViewController.swift
//  iOS_sirius_test
//
//  Created by The GORDEEVS on 12.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var services = [Service]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Сервисы VK"
        
        NetworkingManager.shared.fetchServices { [weak self] services in
            guard let services = services else {
                return
            }
            self?.services = services
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self?.tableView.reloadData()
            }
        }
        setupTableView()
    }
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(ServiceCell.self, forCellReuseIdentifier: ServiceCell.reusableId)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        view.addSubview(tableView)
        // tableView constraints
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ServiceCell else {
            print("Something went wrong with cell")
            return
        }
        
        guard let string = cell.serviceItem?.link, let url = URL(string: string) else {
            print("Not a url")
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("Error with link")
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ServiceCell.reusableId) as? ServiceCell else {
            fatalError("unexpected cell")
        }
        var cellModel: Service?
        
        cellModel = services[indexPath.row]
        if let cellModel = cellModel {
            cell.configure(model: cellModel)
        }
        return cell
    }
    
}
