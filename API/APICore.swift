import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
}

enum HttpResponse {
    case success
    case error
}

// MARK: Core API class

final class APICore: APIProvider {
    
    func request<T: Decodable>(url: [PathURL], httpMethod: HttpMethod, body: Encodable?, completion: @escaping (Result<T, ErrorHandler>) -> Void) {
        
        guard let request = makeRequest(url: url, method: httpMethod, body: body) else { return }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(ErrorHandler(error: error)))
                return
            }
            
            guard !(400..<600).contains(response.statusCode) else {
                completion(.failure(ErrorHandler(defaultError: .connection)))
                return
            }
            
            guard let data = data else { return }
            
            do  {
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch let jsonError {
                completion(.failure(ErrorHandler(error: jsonError, defaultError: .json)))
            }
            
        }.resume()
    }
    
    private func makeRequest(url: [PathURL], method: HttpMethod, body: Encodable?) -> URLRequest? {
        let currentUrl = url.reduce("") { $0 + $1.rawValue }
        
        guard let url = URL(string: currentUrl) else { return nil }
        
        var request = URLRequest(
            url: url,
            cachePolicy: .reloadRevalidatingCacheData,
            timeoutInterval: 10
        )
        
        body.map { request.httpBody = $0 as? Data }
        
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method.rawValue
        
        return request
    }
}
