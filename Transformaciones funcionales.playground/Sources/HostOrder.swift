public enum HostOrder {
	
	case Age, Count, Name

	public typealias Host = (host: String, info: HostInfo)
	public typealias Order = (Host, Host) -> Bool

	public var sort: Order {
	}
}
