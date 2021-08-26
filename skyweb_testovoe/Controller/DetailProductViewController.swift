//
//  DetailProductViewController.swift
//  skyweb_testovoe
//
//  Created by Petar Perich on 25.08.2021.
//

import UIKit
import SnapKit

class DetailProductViewController: UIViewController {
    var product: Product?
    
    let nameLabel: UILabel = {
        let label  = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        
        return label
    }()
    
    let ccalLabel: UILabel = {
        let label  = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label  = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label  = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        
        return label
    }()
    
    let verticallStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(verticallStackView)
        verticallStackView.addArrangedSubview(nameLabel)
        verticallStackView.addArrangedSubview(ccalLabel)
        verticallStackView.addArrangedSubview(categoryLabel)
        verticallStackView.addArrangedSubview(dateLabel)
        
        nameLabel.text = product?.name
        ccalLabel.text = String("\(product!.ccal!)") + " " + "calories"
        dateLabel.text = product?.date
        
    }
    
    init(product: Product, category: String?) {
        self.product = product
        self.categoryLabel.text = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        
        verticallStackView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            
        }
    }
}
