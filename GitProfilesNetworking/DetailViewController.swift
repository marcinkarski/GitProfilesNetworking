import UIKit

class DetailViewController: UIViewController {
    
    let base = "https://api.github.com/users/"
    var tasks = [URLSessionDataTask]()
    var selectedName: String = ""

    let profileView: ProfileView = {
        let view = ProfileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchUser()
    }
    
    func setup() {
        view.backgroundColor = .white
        profileView.frame = view.frame
        view.addSubview(profileView)
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
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        tasks.append(task)
    }
    
    func fetchUser() {
        let name = selectedName
        print(selectedName)
        tasks.forEach { $0.cancel() }
        loadData(withUsername: name)
    }
}
