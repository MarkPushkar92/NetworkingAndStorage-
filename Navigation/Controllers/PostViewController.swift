//
//  PostViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    //MARK: Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.toAutoLayout()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: cellID)
        return tableView
    }()
    
    private let stack: CoreDataStack
    
    private var postsDB: [SavedPost] = []
    
    private let cellID = "cellID"
        
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        title = "Faves"
        reloadPosts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        reloadPosts()
    }
    
    //MARK: Initializer
    
    init(stack: CoreDataStack) {
        self.stack = stack
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    //MARK: Methods
    
    private func reloadPosts() {
        postsDB = stack.fetchPosts()
        tableView.reloadData()
    }
    
    private func postConverter(post: SavedPost) -> MyPost {
        return MyPost(author: post.author ?? "",
                      description: post.text ?? "",
                      image: UIImage(data: post.image!) ?? UIImage(imageLiteralResourceName: "roger"),
                      likes: Int(post.likes),
                      views: Int(post.views))
    }
    

}



//MARK: extensions

private extension PostViewController {
    
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

extension PostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return postsDB.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PostTableViewCell
        let cellData = postConverter(post: postsDB[indexPath.row])
        cell.post = cellData
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}


extension PostViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 220
        default:
            return .zero
        }
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}





