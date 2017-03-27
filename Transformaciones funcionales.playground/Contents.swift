var userDatabase = JsonArray()

for db in UserConsumer.databases {
	userDatabase.append(contentsOf: db)
}

func getHost(user: JsonObject) -> String? {
	return (user["email"] as? String)?.components(separatedBy: "@").last
}

let hosts: [String] = userDatabase
	.map(getHost)
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

		let result = db.reduce(HostInfo(count: 0, age: 0)) { accumulator, user in
			guard let userHost = getHost(user: user),
				let userAge = user["age"] as? Int, userHost == host else {

					return accumulator
			}

			return (accumulator.count + 1, accumulator.age + userAge)
		}

		return HostInfo(count: result.count, age: result.age/result.count)
	}
}

let hostsInfo = uniqueHosts.map(hostInfo(db: userDatabase))

for i in 0..<uniqueHosts.count {
	print("Host: \(hosts[i])")
	print("    - Count: \(hostsInfo[i].count) users")
	print("    - Average age: \(hostsInfo[i].age) years old")

}
