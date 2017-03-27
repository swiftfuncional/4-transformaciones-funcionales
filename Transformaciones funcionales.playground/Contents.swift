var userDatabase = JsonArray()

for db in UserConsumer.databases {
	userDatabase.append(contentsOf: db)
}