//
//  ForecastViewController.swift
//  Forecast
//
//  Created by Pouria Almassi on 5/12/20.
//

import UIKit

final class ForecastViewController: UIViewController {
    private var searchController: UISearchController?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerClassForCell(ForecastCell.self)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private var viewModel: ForecastViewModel?
    
    convenience init(viewModel: ForecastViewModel?) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel?.delegate = self
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupView()
    }
    
    private func loadData() {
        viewModel?.searchLastForecast()
    }
    
    private func setupView() {
        let searchResultsController = SearchResultsController()
        searchResultsController.tableView.delegate = self
        searchController = UISearchController(searchResultsController: searchResultsController)
        searchController?.searchResultsUpdater = viewModel
        searchController?.delegate = self
        definesPresentationContext = true
        
        navigationItem.title = NSLocalizedString("navigationItem.title", comment: "Navigation Item Title.")
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension ForecastViewController: ForecastViewModelDelegate {
    func forecastViewModelDidFail(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.searchController?.dismiss(animated: true)
        }
    }
    
    func forecastViewModelDidSucceed() {
        DispatchQueue.main.async { [weak self] in
            self?.searchController?.dismiss(animated: true)
            self?.tableView.reloadData()
        }
    }

    func forecastViewModelDidUpdateWithLocationString(_ locationString: String) {
        DispatchQueue.main.async { [weak self] in
            self?.searchController?.searchBar.text = locationString
        }
    }
}

extension ForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.tableView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        return viewModel.tableView(tableView, cellForRowAt: indexPath)
    }
}

extension ForecastViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == SearchResultsController.Row.searchByCurrentLocation.rawValue {
            // Request location by coordinates when corresponding row is tapped.
            viewModel?.requestLocationAuthorization()
        }
    }
}

extension ForecastViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async { [weak self] in
            self?.searchController?.searchResultsController?.view.isHidden = false
        }
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async { [weak self] in
            self?.searchController?.searchResultsController?.view.isHidden = false
        }
    }
}
