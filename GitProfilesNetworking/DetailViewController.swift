import UIKit

class DetailViewController: UIViewController {
    
    let baseURL = "https://api.github.com/users/"
    var tasks = [URLSessionDataTask]()
    
    let profileView: ProfileView = {
        let view = ProfileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        triggerName()
    }
    
    func setup() {
        view.backgroundColor = .white
        view.addSubview(profileView)
        profileView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        profileView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
    
    func loadData(withUsername username: String) {
        loadProfile(withUsername: username)
        print(username)
    }
    
    func loadProfile(withUsername username: String) {
        guard let url = URL(string: baseURL + username) else { return }
        let service = APIService()
        let task = service.request(url) { [weak self] (result: Result<Profile>) in
            switch result {
            case .success(let profile):
                self?.profileView.configure(with: profile)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        tasks.append(task)
    }
    
    func triggerName() {
        let name = "marcinkarski"
        tasks.forEach { $0.cancel() }
        loadData(withUsername: name)
    }
}
