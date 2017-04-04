public enum HostOrder {
	
	case Age, Count, Name

	public typealias Host = (host: String, info: HostInfo)
	public typealias Order = (Host, Host) -> Bool

	public var sort: Order {
		switch self {
		case .Age:
			return { $0.info.age < $1.info.age }
		case .Count:
			return { $0.info.count < $1.info.count }
		case .Name:
			return { $0.host < $1.host }
		}
	}
}
