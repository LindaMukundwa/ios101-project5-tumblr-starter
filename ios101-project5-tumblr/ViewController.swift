import UIKit
import Nuke

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Array used to store the fetched posts
    private var posts: [Post] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 400 // Rough estimate
        tableView.rowHeight = UITableView.automaticDimension
        fetchPosts()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? CustomPostCell else {
            fatalError("""
                Failed to dequeue PostCell. Verify:
                1. Storyboard cell identifier = 'PostCell'
                2. CustomPostCell class set in Identity Inspector
                3. Prototype Cells = 1 in Table View attributes
                """)
        }
        
        let post = posts[indexPath.row]
        cell.summaryLabel.text = post.summary
        
        if let photo = post.photos.first {
            Nuke.loadImage(with: photo.originalSize.url, into: cell.postImageView)
        }
        
        return cell
    }
    
    func fetchPosts() {
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork/posts/photo?api_key=1zT8CiXGXFcQDyMFG7RtcfGLwTdDjFUJnZzKJaWTmgyK4lKGYk")!
        let session = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
                print("❌ Response error: \(String(describing: response))")
                return
            }
            
            guard let data = data else {
                print("❌ Data is NIL")
                return
            }
            
            do {
                let blog = try JSONDecoder().decode(Blog.self, from: data)
                
                DispatchQueue.main.async {
                    self?.posts = blog.response.posts
                    self?.tableView.reloadData()
                    
                    print("✅ We got \(blog.response.posts.count) posts!")
                }
                
            } catch {
                print("❌ Error decoding JSON: \(error.localizedDescription)")
            }
        }
        session.resume()
    }
}
