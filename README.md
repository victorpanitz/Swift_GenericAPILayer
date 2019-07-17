# Swift_GenericAPILayer
A simple generic API layer implemented in Swift. Good solution to avoid external dependencies in small/midsize projects.

## Usage:

- Instantiate APICore

```Swift
let api: APIProvider = APICore()
```

- Easiy access the generic request method passing your parameters

```Swift 
let urlPath: [PathURL] = [.base, .myPath, .variable("dynamicValue")]
        
api.request(url: urlPath, httpMethod: .get, body: nil) { (result: Result<Object, ErrorHandler>) in
    switch result {
    case .success(let value):
    // handle value (as your custom Object or [Object])
    case .failure(let error):
    // handle error.message (as String)
    }
}
```
## Feel free to customize it adding your own

### URL Paths (APIPaths.swift): 

```Swift
enum PathURL {
    case base
    case myPath
    case variable(String)
}

extension PathURL: RawRepresentable {
    public typealias RawValue = String
    public init?(rawValue: RawValue) { switch rawValue { default: return nil } }
    
    public var rawValue: RawValue {
        switch self {
        case .base: return "http://myUrlBasePath.com/"
        case .myPath: return "myPath/"
        case .variable(let value): return value
        }
    }    
}
```

### Custom errors (APIError.swift):

```Swift
enum NetworkErrors: String {
    case `default` = "Default message error"
    case connection = "Connection message error"
    case json = "Json message error"
}
```

### Http methods (APICore.swift): 

```Swift
enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
}
```

## TODO

- [ ] Add API Stub with Unit test sample
