import UIKit

final class ViewController: UIViewController {
    
    private let users: [String] = ["Marcin Karski", "John Sundell", "Todd Kramer", "James Rochabrun", "Jesse Squires"]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.register(cellType: UITableViewCell.self)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.beginRefreshing()
        refresh.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        return refresh
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setupNavigationBar()
        tableView.addSubview(refreshControl)
        
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(indexPath: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.textLabel?.text = users[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        guard let cellName = cell?.textLabel?.text else { return }
        let trimmedName = cellName.filter({ " ".contains($0) == false })
        detailViewController.selectedName = trimmedName.lowercased()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

private extension ViewController {
    
    private func setupNavigationBar() {
        self.title = "GitHub Profiles"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .orange
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    @objc private func refresh(_ sender: Any) {
        self.refreshControl.endRefreshing()
    }
}
