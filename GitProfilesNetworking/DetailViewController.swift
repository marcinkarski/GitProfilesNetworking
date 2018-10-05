import UIKit

class DetailViewController: UIViewController {
    
    let baseURL = "https://api.github.com/users/"
    let repositoryCellIdentifier = "RepositoryCell"
    
    var repositories = [Repository]()
    var tasks = [URLSessionDataTask]()
    
    let profileView: UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
    }
}
