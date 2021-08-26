//
//  ProductsViewController.swift
//  skyweb_testovoe
//
//  Created by Petar Perich on 24.08.2021.
//

import UIKit

class ProductsViewController: UIViewController {
    
    let dataFetcher = DataFetcher()
    var categoryID: Int? = nil
    var products: Products?
    
    private lazy var productsTableview: UITableView = {
        let tableview = UITableView()
        tableview.register(ProductsTableViewCell.self, forCellReuseIdentifier: ProductsTableViewCell.identifier)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView(frame: .zero)
        return tableview
    }()
    
    private func showAlert() {
        let alert = UIAlertController(title: "Something is wrong", message: "Check your internet connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        guard let id = categoryID else {return}
        
        dataFetcher.fetchProducts(id: id) { response in
            
            self.products = response
            if self.products == nil {
                self.showAlert()
            }else{
                self.productsTableview.reloadData()
            }
            
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(productsTableview)
        productsTableview.frame = view.bounds
    }
    
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productsTableview.dequeueReusableCell(withIdentifier: ProductsTableViewCell.identifier, for: indexPath)
        let product = products?.data
        cell.textLabel?.text = product?[indexPath.row].name
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let product = products?.data[indexPath.row] else {return }
        let vc = DetailProductViewController(product: product, category: title)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
