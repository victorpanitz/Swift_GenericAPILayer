import Foundation

protocol APIProvider: AnyObject {
    func request<T: Decodable>(url: [PathURL], httpMethod: HttpMethod, body: Encodable?, completion: @escaping (Result<T, ErrorHandler>) -> Void)
}
