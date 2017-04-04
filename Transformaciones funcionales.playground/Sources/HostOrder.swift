public enum HostOrder {
	
	case Age, Count, Name

	public var sort: ((String, HostInfo), (String, HostInfo)) -> Bool {
	}
}
