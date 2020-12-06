//
//  SearchResultsController.swift
//  Forecast
//
//  Created by Pouria Almassi on 5/12/20.
//

import UIKit

final class SearchResultsController: UITableViewController {
    enum Row: Int, CaseIterable {
        case searchByCurrentLocation
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClassForCell(SearchCurrentLocationCell.self)
        tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Row.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: SearchCurrentLocationCell.reuseIdentifier, for: indexPath)
    }
}
