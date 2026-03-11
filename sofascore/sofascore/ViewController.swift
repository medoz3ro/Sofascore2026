//
//  ViewController.swift
//  Sofascore
//
//  Created by Benjamin on 05.03.2026..
//

import UIKit
import SnapKit
import SofaAcademic

class ViewController: UIViewController {
    
    private let leagueView = LeagueView()
    //private let matchView = MatchView()
    
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        let dataSource = Homework2DataSource()
        leagueView.configure(with: dataSource.laLigaLeague())
        
        dataSource.laLigaEvents()
            .sorted { $0.startTimestamp < $1.startTimestamp }
            .forEach { event in
                let eventView = MatchView()
                let viewModel = MatchViewModel(event: event)
                eventView.configure(with: viewModel)
                stackView.addArrangedSubview(eventView)
            }
    }
    
    private func setupUI() {
        view.addSubview(leagueView)
        //        leagueView.backgroundColor = .red
        leagueView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(56)
        }
        
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        stackView.spacing = 8
        stackView.snp.makeConstraints { make in
            make.top.equalTo(leagueView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        //        view.addSubview(matchView)
        //        matchView.snp.makeConstraints { make in
        //            make.top.equalTo(leagueView.snp.bottom).offset(32)
        //            make.leading.trailing.equalToSuperview()
        //        }
        
    }
    
}
