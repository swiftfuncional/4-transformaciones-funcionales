var userDatabase = JsonArray()

for db in UserConsumer.databases {
	userDatabase.append(contentsOf: db)
}

let hosts: [String] = userDatabase
	.map { ($0["email"] as? String)?.components(separatedBy: "@").last }
	.filter { $0 != nil }
	.map { $0! }

var uniqueHosts = [String]()

for host in hosts {
	if !uniqueHosts.contains(host) {
		uniqueHosts.append(host)
	}
}

typealias  HostInfo = (count: Int, age: Int)

func hostInfo(db: JsonArray) -> (String) -> HostInfo {
	return { host in
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
}

let hostsInfo = uniqueHosts.map(hostInfo(db: userDatabase))

for i in 0..<uniqueHosts.count {
	print("Host: \(hosts[i])")
	print("    - Count: \(hostsInfo[i].count) users")
	print("    - Average age: \(hostsInfo[i].age) years old")

}
