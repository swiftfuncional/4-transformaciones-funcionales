var userDatabase = JsonArray()

for db in UserConsumer.databases {
	userDatabase.append(contentsOf: db)
}

let hosts: [String?] = userDatabase
	.map { ($0["email"] as? String)?.components(separatedBy: "@").last }
	.filter { (optionalHost) -> Bool in
		optionalHost != nil }

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

var hostsInfo = [HostInfo]()

for host in hosts {
	hostsInfo.append(hostInfo(db: userDatabase, host: host))
}

for i in 0..<hosts.count {
	print("Host: \(hosts[i])")
	print("    - Count: \(hostsInfo[i].count) users")
	print("    - Average age: \(hostsInfo[i].age) years old")

}