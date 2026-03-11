//
//  LeagueView.swift
//  Sofascore
//
//  Created by Benjamin on 10.03.2026..
//

import UIKit
import SnapKit
import SofaAcademic


class LeagueView: UIView {
    private let name: UILabel = UILabel()
    private let country: UILabel = UILabel()
    private let logoImage: UIImageView = UIImageView()
    
    private let pointerImage: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func configure(with league: League) {
        name.text = league.name
        country.text = league.country?.name
        
        
        guard let urlString = league.logoUrl, let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.logoImage.image = image
            }
        }.resume()
    }
    
    private func setupUI() {
        addSubview(logoImage)
        addSubview(country)
        addSubview(pointerImage)
        addSubview(name)
        
        logoImage.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        country.numberOfLines = 1
        country.font = AppFont.bold(size: 16)
        country.snp.makeConstraints { make in
            make.leading.equalTo(logoImage.snp.trailing).offset(32)
            make.centerY.equalToSuperview()
        }
        
        pointerImage.image = UIImage(named: AppStrings.League.pointerIcon)?.withRenderingMode(.alwaysTemplate)
        pointerImage.tintColor = AppColors.grayText
        pointerImage.snp.makeConstraints { make in
            make.leading.equalTo(country.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
        
        name.numberOfLines = 1
        name.tintColor = AppColors.grayText
        name.font = AppFont.regular(size: 16)
        name.snp.makeConstraints { make in
            make.leading.equalTo(pointerImage.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
        
    }
}




