# Lumaris RSP

**Lumaris RSP** is a Ruby on Rails application designed to support the Resource Sharing Protocol (RSP), providing a platform for \[briefly describe main purpose].

---

## Table of Contents

* [Ruby Version](#ruby-version)
* [System Dependencies](#system-dependencies)
* [Configuration](#configuration)
* [Database Setup](#database-setup)
* [Running the Test Suite](#running-the-test-suite)
* [Services](#services)
* [Deployment](#deployment)
* [Contributing](#contributing)
* [License](#license)

---

## Ruby Version

* Ruby version: `3.4.4`
* Rails version: `7.0.x` 

---

## System Dependencies

Make sure you have the following installed on your system:

* Ruby 
* Rails 
* PostgreSQL 
* Node.js and Bun
* Redis 


---

## Configuration

1. Clone the repository:

   ```bash
   git clone https://github.com/bdr-pro/lumaris_rsp.git
   cd lumaris_rsp
   ```

2. Install gems:

   ```bash
   bundle install
   ```

3. Install JavaScript dependencies:

   ```bash
   bun install
   ```

4. Edit Rails credentials (if needed):

   ```bash
   EDITOR="code --wait" bin/rails credentials:edit
   ```

---

## Database Setup

1. Create and migrate the database:

   ```bash
   rails db:create
   rails db:migrate
   ```

2. (Optional) Seed the database with sample data:

   ```bash
   rails db:seed
   ```

---

## Running the Test Suite

Run the tests using RSpec or Minitest depending on your setup:

```bash
bundle exec rspec
# or
rails test
```

---

## Services

* **Job Queue:** If using Sidekiq or other background job processors, make sure Redis is running.
  Example:

  ```bash
  redis-server
  bundle exec sidekiq
  ```

* **Caching:** Configure Redis or Memcached if caching is enabled.

* **Search Engine:** If applicable, setup Elasticsearch or similar services.

---

## Deployment

You can deploy **Lumaris RSP** using any Rails-compatible platform. A typical deployment process might involve:

1. Push to your Git remote repository.
2. Run migrations on the production server:

   ```bash
   rails db:migrate RAILS_ENV=production
   ```
3. Precompile assets:

   ```bash
   rails assets:precompile RAILS_ENV=production
   ```
4. Restart your app server (Puma/Passenger/Unicorn).

---

## Contributing

Feel free to fork the repository and submit pull requests. Please follow the established code style and write tests for new features or bug fixes.

---

## License

MIT License.
