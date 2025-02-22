.PHONY: test test-sqlite test-postgres test-mysql cleanup

test: test-sqlite test-postgres test-mysql cleanup

test-local:
	@echo "Running SQLite tests - Started"
	@go test -race -timeout 30s -v ./...
	@echo "Running SQLite tests - Completed"

test-sqlite:
	@echo "Running SQLite tests - Started"
	@docker-compose down
	@docker-compose run go116 go test -race -v ./...
	@echo "Running SQLite tests - Completed"

test-postgres:
	@echo "Running PostgreSQL tests - Started"
	@docker-compose up -d postgres
	@docker-compose run -e JOBSD_DB=postgres go116 docker/test-postgres.sh
	@docker-compose down
	@echo "Running PostgreSQL tests - Completed"

test-mysql:
	@echo "Running MySQL tests - Started"
	@docker-compose up -d mysql
	@docker-compose run -e JOBSD_DB=mysql go116 docker/test-mysql.sh
	@docker-compose down
	@echo "Running MySQL tests - Completed"

cleanup:
	@docker-compose down

