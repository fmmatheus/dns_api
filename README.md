# DNS API

The DNS API project is a simple Ruby and Rails application to store and query DNS data. The application has basically two endpoints, with one you can write your data and the second makes possible for you to access that data.


# Endpoints

## GET /dns_records
Endpoint to read DNS data.

Request parameters:
```
{
    page: 1,
	included: ["lorem.com"],
	excluded: ["ipsum.com"]
}
```

- **page** (required) :
	- type: integer
	- description: A page number
- **included**:
	- type: Array of strings
	- description: A list of all the hostnames the DNS records should have
- **excluded**:
	- type: Array of strings
	- description: A list of hostnames the DNS records should not have

Response:
```
{
  "total_records": 1,
  "records": [
    {
      "id": 1,
      "ip_address": "1.1.1.1"
    }
  ],
  "related_hostnames": [
    {
      "hostname": "lorem.com",
      "count": 5
    }
  ]
}
```

- **total_records**:
	- type: integer
	- description: The total number of matching DNS records
- **records**:
	- type: Array of objects
	- description: A list of all DNS records
- **related_hostnames**:
	- type: Array of objects
	- description: A list of hostnames the DNS records


## POST /dns_records
Endpoint to write DNS data.

Request parameters:
```json
{
  "dns_records": {
    "ip": "1.1.1.1",
    "hostnames_attributes": [
      {
        "hostname": "lorem.com"
      }
    ]
  }
}
```

Request parameters:
```json
{
  "id": 1
}
```

# About the application
* System dependencies:  
```ruby
	ruby '2.7.1'
	
	gem 'pg'
	gem 'pagy', '~> 3.5'
	gem 'rails', '~> 6.1.1'
```

# Running

* Requirements: before running the application locally, be sure to have Docker installed and running ([How to install docker](https://docs.docker.com/get-started/))

* Run the following commands in a terminal to spin up the application locally:
```bash
$ docker-compose build # Build docker images
$ docker-compose up -d # Spin up docker containers
$ docker-compose run web rake db:create # Create application databases
$ docker-compose run web rake db:migrate # Run migrations for the database
$ docker-compose run web rake db:seed # Seed the database with mock data
```

After spinning up the application, you can call the endpoints directly in the browser or using some HTTP client like [Postman](https://www.postman.com).

# Testing

* Requirements: application running as demonstrated in the section **#Running**

* Run the following commands in a terminal to run the application test suite:
```bash
$ docker-compose run web rake test
```