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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let dataSource = Homework2DataSource()
        leagueView.configure(with: dataSource.laLigaLeague())
    }

    private func setupUI() {
        view.addSubview(leagueView)
        
        leagueView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
    
}
