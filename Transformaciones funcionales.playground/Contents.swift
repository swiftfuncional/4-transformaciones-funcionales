var userDatabase = JsonArray()

for db in UserConsumer.databases {
	userDatabase.append(contentsOf: db)
}

var hosts = [String]()

for user in userDatabase {
	if let email = user["email"] as? String,
		let host = email.components(separatedBy: "@").last,
		!hosts.contains(host) {

		hosts.append(host)
	}
}

typealias  HostInfo = (count: Int, age: Int)

func hostInfo(db: JsonArray, host: String) -> HostInfo {
	var count = 0
	var age = 0

	for user in db {
		if let email = user["email"] as? String,
			let userHost = email.components(separatedBy: "@").last,
			let userAge = user["age"] as? Int,
			userHost == host {

			count += 1
			age += userAge
		}

	}

	return HostInfo(count: count, age: age/count) 
}