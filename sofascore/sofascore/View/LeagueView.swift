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
        logoImage.snp.makeConstraints { (make) in
            make.size.equalTo(32)
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        addSubview(country)
        country.font = AppFont.bold(size: 16)
        country.snp.makeConstraints { (make) in
            make.leading.equalTo(logoImage.snp.trailing).offset(32)
            make.centerY.equalToSuperview()
        }
        
        
        addSubview(pointerImage)
        pointerImage.image = UIImage(named: "pointer_right")?.withRenderingMode(.alwaysTemplate)
        pointerImage.tintColor = .white
        pointerImage.snp.makeConstraints { (make) in
            make.leading.equalTo(country.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
        
        addSubview(name)
        name.font = AppFont.regular(size: 16)
        name.snp.makeConstraints { (make) in
            make.leading.equalTo(pointerImage.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
    }
}




