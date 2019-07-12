import Foundation

enum NetworkErrors: String {
    case `default` = "Default message error"
    case connection = "Connection message error"
    case json = "Json message error"
}

struct ErrorHandler: Error {
    var message: String
    
    init(error: Error? = nil, defaultError: NetworkErrors = .default) {
        message = defaultError.rawValue
        
        handle(error: error)
    }
    
    private mutating func handle(error: Error?) {
        guard let error = error, !error.localizedDescription.isEmpty else { return }
        message = error.localizedDescription
    }
}
