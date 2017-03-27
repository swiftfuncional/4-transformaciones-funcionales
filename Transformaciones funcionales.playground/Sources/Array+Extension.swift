import Foundation

public extension Array where Element: Hashable {

	func unique() -> [Element] {
		return self.reduce([]) { accumulator, element in
			accumulator + (accumulator.contains(element) ? [] : [element])
		}
	}
}
