//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Марк Пушкарь on 11.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import Foundation

class ProfileViewController: UIViewController {
    
    var header = ProfileHeaderView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.toAutoLayout()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        return tableView
    }()
    
    private let cellID = "cellID"
    
    var profileViewModel: ProfilelViewModel
    
    init(profileViewModel: ProfilelViewModel) {
        self.profileViewModel = profileViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        title = profileViewModel.moduleTitle
        var time = 0
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            time += 1
            self.header.timerLabel.text = "Time spent on page \(time)"
            if time == 10 {
                let alertWindow = UIAlertController(title: "Attention", message: "Stop Doing nothing, go for a walk", preferredStyle: .alert)
                alertWindow.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alertWindow, animated: true)
            }
        }
        RunLoop.current.add(timer, forMode: .common)
        timer.fire()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

    }
    
}

//MARK: extensions

extension UIView {
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

private extension ProfileViewController {
    
    func setupViews() {
    
        view.addSubview(tableView)
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return posts.count
        default:
            break
        }
        return section
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: PhotosTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotosTableViewCell.self)) as! PhotosTableViewCell
                   cell.photo = StoragePhotoProfile.tableModel
            return cell
        } else {
            let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PostTableViewCell
                cell.post = posts[indexPath.row]
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}


extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let headerview = header
            return headerview
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 220
        default:
            return .zero
        }
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            profileViewModel.onTapShowNextModule()
        }
    }
}


/*
 
 
 Задачи теоретически решаемые с помощью таймера:
 1) в контексте текущего проекта - время затраченное на подборку пароля с помощью brutForce
 2) в будущем - время отображения прогрузки фотографий из сети/ примение фильтров и т.д
 
  Вообще с таймерами все оказалось довольно понятно , однако примение модульной навигации усложняет их примение в более удобном формате, c возможностью отключения и перезапуска таймеров , во всяком случае у меня при попытках построить более осмысленную логику использования случались конфликты инициализации переменных ( при обращении к тем или иным переменным, например к хедеру , оказывалось , что он еще не проинициализирован и т.д).
 
 Прошу помочь разобрвться с одной историей - после обновления mac и xcode перестали работать фильтры из iosIntPackage
 
 
 */
