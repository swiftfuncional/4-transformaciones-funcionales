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