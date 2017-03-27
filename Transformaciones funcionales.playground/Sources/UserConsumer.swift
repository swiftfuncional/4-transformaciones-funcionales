import Foundation

public typealias JsonObject = [String: AnyObject]
public typealias JsonArray = [JsonObject]

public class UserConsumer {
	static func json(path: String) -> JsonArray {
		guard
			let path = Bundle.main.path(forResource: path, ofType: "json"),
			let jsonData = NSData(contentsOfFile: path),
			let jsonResult = try! JSONSerialization.jsonObject(with: jsonData as Data) as? NSArray
			else {
				return JsonArray()
		}

		return jsonResult.flatMap { $0 as? JsonObject }
	}

	public static var databases: [JsonArray] {
		return [json(path: "Database1"), json(path: "Database2"), json(path: "Database3")]
	}
}
