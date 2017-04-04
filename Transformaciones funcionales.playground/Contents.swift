let userDatabase = UserConsumer.databases.flatMap { $0 }

func getHost(user: JsonObject) -> String? {
	return (user["email"] as? String)?.components(separatedBy: "@").last
}

let hosts: [String] = userDatabase
	.flatMap(getHost)
	.unique()

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

let hostsInfo = hosts.map(hostInfo(db: userDatabase))

zip(hosts, hostsInfo)
	.sorted { $0.1.age < $1.1.age }
	.forEach { host, info in
	print("Host: \(host)")
	print("    - Count: \(info.count) users")
	print("    - Average age: \(info.age) years old")
}
