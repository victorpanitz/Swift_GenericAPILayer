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
    // handle value (as your custom Object)
    case .failure(let error):
    // handle error.message (as String)
    }
}
```
## Feel free to customize it adding your own

### Custom errors:

```Swift
enum NetworkErrors: String {
    case `default` = "Default message error"
    case connection = "Connection message error"
    case json = "Json message error"
}
```

### Http methods: 

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
