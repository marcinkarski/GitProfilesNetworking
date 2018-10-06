import UIKit

class ProfileView: UIView {
    
    var imageRequest: URLSessionDataTask?
    
    let imageView: UIImageView = {
        let placeholder = UIImage(named: "bottomViewImagePlaceholder")
        let image = UIImageView(image: placeholder)
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Loading user..."
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    fileprivate func setup() {
        backgroundColor = .white
//        layer.cornerRadius = 2
//        layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
//        layer.shadowOpacity = 0.5
//        layer.shadowRadius = 0.5
        
        addSubview(imageView)
        addSubview(nameLabel)
        
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func reset() {
        imageRequest?.cancel()
        imageRequest = nil
    }
    
    func configure(with profile: Profile) {
        nameLabel.text = profile.name
        loadImage(for: profile)
    }
    
    func loadImage(for profile: Profile) {
        guard let url = URL(string: profile.avatarURL) else { return }
        let service = APIService()
        imageRequest = service.requestImage(withURL: url) { [weak self] result in
            switch result {
            case .success(let image):
                self?.imageView.image = image
            case .failure(let error):
                print(error)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
