//
//  SearchCurrentLocationCell.swift
//  Forecast
//
//  Created by Pouria Almassi on 6/12/20.
//

import UIKit

final class SearchCurrentLocationCell: UITableViewCell {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    func commonInit() {
        selectionStyle = .none
        textLabel?.text = NSLocalizedString("searchResultsController.searchByCurrentLocation.title", comment: "Search Results Controller 'Search by Current Location' Row Title.")
        imageView?.image = UIImage(systemName: "location.fill", withConfiguration: UIImage.SymbolConfiguration(textStyle: .caption2))
    }
}

extension SearchCurrentLocationCell: Reusable {}
