import UIKit

class DetailViewController: UIViewController {
    
    let base = "https://api.github.com/users/"
    var tasks = [URLSessionDataTask]()
    var selectedName: String = ""

    let profileView: ProfileView = {
        let view = ProfileView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.isHidden = true
        return view
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .gray
        indicator.startAnimating()
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchUser()
    }
}

private extension DetailViewController {
    
    func setup() {
        view.backgroundColor = .white
        view.addSubview(profileView)
        view.addSubview(activityIndicator)
        profileView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        profileView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func loadData(withUsername username: String) {
        loadProfile(withUsername: username)
    }
    
    func loadProfile(withUsername username: String) {
        guard let url = URL(string: base + username) else { return }
        let service = APIService()
        let task = service.request(url) { [weak self] (result: Result<Profile>) in
            switch result {
            case .success(let profile):
                self?.profileView.configure(with: profile)
                self?.activityIndicator.stopAnimating()
//                self?.profileView.isHidden = false
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        tasks.append(task)
    }
    
    func fetchUser() {
        tasks.forEach { $0.cancel() }
        loadData(withUsername: selectedName)
        print(selectedName)
    }
}
