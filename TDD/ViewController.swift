//
//  ViewController.swift
//  TDD
//
//  Created by Hanis on 01/07/2023.
//

import UIKit
import Detail

class ViewController: UIViewController {
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Click", for: [])
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var routeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Go to Next Screen", for: [])
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .systemPink
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var buttonAction: UIAction? = nil {
        didSet {
            guard let action = buttonAction else { return }
            
            button.addAction(action, for: .touchUpInside)
        }
    }
    
    private var routeButtonAction: UIAction? = nil {
        didSet {
            guard let action = routeButtonAction else { return }
            
            routeButton.addAction(action, for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupView()
        setupListeners()
    }
    
    private func setupView() {
        view.addSubview(label)
        view.addSubview(button)
        view.addSubview(routeButton)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            
            button.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 25),
            button.centerXAnchor.constraint(equalTo: label.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 44),
            
            routeButton.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            routeButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 25),
            routeButton.centerXAnchor.constraint(equalTo: label.centerXAnchor),
            routeButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupListeners() {
        buttonAction = UIAction { [weak self] action in
            guard let self else { return }
            
            self.handleButtonAction()
        }
        
        routeButtonAction = UIAction { [weak self] action in
            guard let self else { return }
            
            self.handleRouteToNextScreen()
        }
    }
    
    private func handleButtonAction() {
        label.text = "Clicked"
    }
    
    private func handleRouteToNextScreen() {
        let vc = DetailViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
