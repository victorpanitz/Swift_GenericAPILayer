import Foundation

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
        case .base: return "http://mybaseUrl.com/"
        case .myPath: return "myPath/"
        case .variable(let value): return value
        }
    }
}
