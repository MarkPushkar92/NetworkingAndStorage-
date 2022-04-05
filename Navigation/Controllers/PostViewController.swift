//
//  PostViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import CoreData

class PostViewController: UIViewController {
    
    //MARK: FRC
    
    private var isInitiallyLoaded: Bool = false
    
    private lazy var fetchResultsController: NSFetchedResultsController<SavedPost> = {

        let request: NSFetchRequest<SavedPost> = SavedPost.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "author", ascending: false)]
        let controller = NSFetchedResultsController(
        fetchRequest: request,
        managedObjectContext: stack.viewContext,
        sectionNameKeyPath: nil,
        cacheName: nil
        )
        controller.delegate = self
        return controller
     }()
    
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
        view.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        setupViews()
        title = "Faves"
        reloadPosts()
        addfilterButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        reloadPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !isInitiallyLoaded {
            isInitiallyLoaded = true
            stack.viewContext.perform {
                do {
                    try self.fetchResultsController.performFetch()
                    self.tableView.reloadData()
                } catch {
                    print(error)
                }
            }
        }
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
        stack.viewContext.perform {
            self.fetchResultsController.fetchRequest.predicate = nil
            do {
                try self.fetchResultsController.performFetch()
                self.tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    private func filterByAuthor(author : String) {
        stack.viewContext.perform {
            let predicate = NSPredicate(format: "author == %@", author)
            self.fetchResultsController.fetchRequest.predicate = predicate
            do {
                try self.fetchResultsController.performFetch()
                self.tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    private func postConverter(post: SavedPost) -> MyPost {
        return MyPost(author: post.author ?? "",
                      description: post.text ?? "",
                      image: UIImage(data: post.image!) ?? UIImage(imageLiteralResourceName: "roger"),
                      likes: Int(post.likes),
                      views: Int(post.views))
    }
    
    //MARK: filtering objects in UI
    
    private func addfilterButtons() {
        let addFilter = UIBarButtonItem(title: "Filter",
                                        style: .plain,
                                        target: self,
                                        action: #selector(addFilter))
        
        let removeFilter = UIBarButtonItem(title: "Remove Filter",
                                           style: .plain,
                                           target: self,
                                           action: #selector(removeFilter))

        navigationItem.setLeftBarButton(addFilter, animated: false)
        navigationItem.setRightBarButton(removeFilter, animated: false)
    }
    
    @objc private func removeFilter() {
        self.reloadPosts()
    }
    
    @objc private func addFilter() {
        var inputTextField: UITextField?;
        let alert = UIAlertController(title: "Filter Favorite Posts",
                                            message: "Enter author's name",
                                            preferredStyle: UIAlertController.Style.alert);
       
        alert.addAction(UIAlertAction(title: "Apply",
                                            style: UIAlertAction.Style.default, handler: { [weak self] (action) -> Void in
            guard let this = self else {return}
            let filterBy = (inputTextField?.text) ?? "";
            this.filterByAuthor(author: filterBy)
        }));
           
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "author's name"
            textField.isSecureTextEntry = false
            inputTextField = textField
        });
       
        self.present(alert, animated: true, completion: nil);
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
        return fetchResultsController.fetchedObjects?.count ?? 0
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PostTableViewCell
        let postItem = fetchResultsController.object(at: indexPath)
        let cellData = postConverter(post: postItem)
        cell.post = cellData
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}


extension PostViewController: UITableViewDelegate {
     
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, success) in
                guard let this = self else { return }
                let postToDelete = this.fetchResultsController.object(at: indexPath)
                this.stack.remove(post: postToDelete)
                success(true)
            }
            return UISwipeActionsConfiguration(actions: [action])
    }
}

extension PostViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            case .delete:
                guard let indexPath = indexPath else { return }
                tableView.deleteRows(at: [indexPath], with: .automatic)
            case .insert:
                guard let newIndexPath = newIndexPath else { return }
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            case .move:
                guard
                    let indexPath = indexPath,
                    let newIndexPath = newIndexPath
                else { return }
                tableView.moveRow(at: indexPath, to: newIndexPath)
            case .update:
                guard let indexPath = indexPath else { return }
                tableView.reloadRows(at: [indexPath], with: .automatic)
            @unknown default:
                fatalError()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
