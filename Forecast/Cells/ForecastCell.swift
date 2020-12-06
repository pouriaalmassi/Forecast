//
//  ForecastCell.swift
//  Forecast
//
//  Created by Pouria Almassi on 5/12/20.
//

import UIKit

final class ForecastCell: UITableViewCell {
    private enum Constant {
        static let widthMultiplier: CGFloat = 0.5
        static let topLabelHeightMultiplier: CGFloat = 0.3
        static let topContainerViewCornerRadius: CGFloat = 10.0
    }

    private let topContainerView = UIView()
    private let leftContainerView = UIView()
    private let rightContainerView = UIView()
    private let locationLabel = UILabel()
    private let currentTemperatureLabel = UILabel()
    private let forecastLabel = UILabel()
    private let minMaxTemperatureLabel = UILabel()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    func commonInit() {
        selectionStyle = .none

        contentView.addSubview(topContainerView)
        topContainerView.translatesAutoresizingMaskIntoConstraints = false
        topContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CGFloat.standardInset).isActive = true
        topContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -CGFloat.standardInset).isActive = true
        topContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CGFloat.standardInset).isActive = true
        topContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -CGFloat.standardInset).isActive = true
        topContainerView.backgroundColor = UIColor.forecastCellBackgroundColor
        topContainerView.layer.cornerRadius = Constant.topContainerViewCornerRadius

        topContainerView.addSubview(leftContainerView)
        leftContainerView.translatesAutoresizingMaskIntoConstraints = false
        leftContainerView.topAnchor.constraint(equalTo: topContainerView.topAnchor).isActive = true
        leftContainerView.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor).isActive = true
        leftContainerView.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor).isActive = true
        leftContainerView.widthAnchor.constraint(equalTo: topContainerView.widthAnchor, multiplier: Constant.widthMultiplier).isActive = true
        leftContainerView.backgroundColor = .clear

        topContainerView.addSubview(rightContainerView)
        rightContainerView.translatesAutoresizingMaskIntoConstraints = false
        rightContainerView.topAnchor.constraint(equalTo: topContainerView.topAnchor).isActive = true
        rightContainerView.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor).isActive = true
        rightContainerView.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor).isActive = true
        rightContainerView.widthAnchor.constraint(equalTo: topContainerView.widthAnchor, multiplier: Constant.widthMultiplier).isActive = true
        rightContainerView.backgroundColor = .clear

        // MARK: - Left Container

        leftContainerView.addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.font = UIFont.scaledBody
        locationLabel.numberOfLines = 0
        locationLabel.lineBreakMode = .byWordWrapping
        locationLabel.textAlignment = .left
        locationLabel.textColor = UIColor.primaryForegroundColor
        locationLabel.topAnchor.constraint(equalTo: leftContainerView.topAnchor, constant: CGFloat.standardInset).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: leftContainerView.leadingAnchor, constant: CGFloat.standardInset).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: leftContainerView.trailingAnchor, constant: -CGFloat.standardInset).isActive = true
        locationLabel.heightAnchor.constraint(equalTo: leftContainerView.heightAnchor, multiplier: Constant.topLabelHeightMultiplier).isActive = true

        leftContainerView.addSubview(currentTemperatureLabel)
        currentTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTemperatureLabel.font = UIFont.scaledBody
        currentTemperatureLabel.numberOfLines = 0
        currentTemperatureLabel.lineBreakMode = .byWordWrapping
        currentTemperatureLabel.textAlignment = .left
        currentTemperatureLabel.textColor = UIColor.primaryForegroundColor
        currentTemperatureLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: CGFloat.standardInset).isActive = true
        currentTemperatureLabel.bottomAnchor.constraint(equalTo: leftContainerView.bottomAnchor, constant: -CGFloat.standardInset).isActive = true
        currentTemperatureLabel.leadingAnchor.constraint(equalTo: leftContainerView.leadingAnchor, constant: CGFloat.standardInset).isActive = true
        currentTemperatureLabel.trailingAnchor.constraint(equalTo: leftContainerView.trailingAnchor, constant: -CGFloat.standardInset).isActive = true

        // MARK: - Right Container

        rightContainerView.addSubview(forecastLabel)
        forecastLabel.translatesAutoresizingMaskIntoConstraints = false
        forecastLabel.font = UIFont.scaledBody
        forecastLabel.lineBreakMode = .byWordWrapping
        forecastLabel.textAlignment = .right
        forecastLabel.textColor = UIColor.primaryForegroundColor
        forecastLabel.topAnchor.constraint(equalTo: rightContainerView.topAnchor, constant: CGFloat.standardInset).isActive = true
        forecastLabel.leadingAnchor.constraint(equalTo: rightContainerView.leadingAnchor, constant: CGFloat.standardInset).isActive = true
        forecastLabel.trailingAnchor.constraint(equalTo: rightContainerView.trailingAnchor, constant: -CGFloat.standardInset).isActive = true
        forecastLabel.heightAnchor.constraint(equalTo: rightContainerView.heightAnchor, multiplier: Constant.topLabelHeightMultiplier).isActive = true

        rightContainerView.addSubview(minMaxTemperatureLabel)
        minMaxTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        minMaxTemperatureLabel.font = UIFont.scaledBody
        minMaxTemperatureLabel.numberOfLines = 0
        minMaxTemperatureLabel.lineBreakMode = .byWordWrapping
        minMaxTemperatureLabel.textAlignment = .right
        minMaxTemperatureLabel.textColor = UIColor.primaryForegroundColor
        minMaxTemperatureLabel.topAnchor.constraint(equalTo: forecastLabel.bottomAnchor, constant: CGFloat.standardInset).isActive = true
        minMaxTemperatureLabel.bottomAnchor.constraint(equalTo: rightContainerView.bottomAnchor, constant: -CGFloat.standardInset).isActive = true
        minMaxTemperatureLabel.leadingAnchor.constraint(equalTo: rightContainerView.leadingAnchor, constant: CGFloat.standardInset).isActive = true
        minMaxTemperatureLabel.trailingAnchor.constraint(equalTo: rightContainerView.trailingAnchor, constant: -CGFloat.standardInset).isActive = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        locationLabel.text = nil
        locationLabel.textColor = UIColor.primaryForegroundColor
        topContainerView.backgroundColor = UIColor.forecastCellBackgroundColor
    }

    func setup(with model: ForecastCellViewModel) {
        locationLabel.text = model.locationString
        currentTemperatureLabel.text = model.currentTemperatureString
        forecastLabel.text = model.forecastString
        minMaxTemperatureLabel.text = model.minMaxTemperatureString
    }
}

extension ForecastCell: Reusable {}
