//
//  ViewController.swift
//  skyweb_testovoe
//
//  Created by Petar Perich on 24.08.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var categoriesTableview: UITableView!
    var categories: Categories?
    let dataFetcher = DataFetcher()
    
    func configureTableView(){
        categoriesTableview.delegate = self
        categoriesTableview.dataSource = self
        categoriesTableview.tableFooterView = UIView(frame: .zero)
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "No connection", message: "Check your internet connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        dataFetcher.fetchCategories { (response) in
            self.categories = response
            if self.categories == nil{
                self.showAlert()
            } else{
                self.categoriesTableview.reloadData()
            }
            
        }
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoriesTableview.dequeueReusableCell(withIdentifier: "CategoriesCell", for: indexPath)
        let category = categories?.data
        cell.textLabel?.text = category?[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ProductsViewController()
        guard let category = categories?.data[indexPath.row] else { return }
        vc.categoryID = category.id
        vc.title = category.name
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

