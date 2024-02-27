# Obsekio

![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)
![check](https://github.com/EventideSystems/obsekio/actions/workflows/check.yml/badge.svg)

## System Requirements

- Ruby 3.3+. The application _should_ work on older Ruby versions, but we are targetting modern Ruby and may introduce backwardly-incompatible code by taking advantage of Ruby 3.3+ specific features in the future.

- PostgresSQL 12.9+.

- Any Linux-based OS. We test using Ubuntu 20.04 LTS


## Code Style Conventions

[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-community-brightgreen.svg)](https://rubystyle.guide)


## Configuration

### Environment Variables

The following environment variables are required to run the application:

- `ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY` : The primary key for the encryption service
- `ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY` : The deterministic key for the encryption service
- `ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT` : The salt for the key derivation function

See the [ActiveRecordEncryption](https://edgeguides.rubyonrails.org/active_record_encryption.html#setup) documentation for more information.

- `RECAPTCHA_SITE_KEY`: The site key for the reCAPTCHA service
- `RECAPTCHA_SECRET_KEY`: The secret key for the reCAPTCHA service

See the [reCAPTCHA](https://github.com/ambethia/recaptcha/?tab=readme-ov-file#obtaining-a-key) documentation for more information.

For local development, you can create a `.env` file in the root of the project and add the environment variables there. The `.env` file is ignored by git and will not be committed to the repository. See the `.env.example` file for an example of the format.

NB We use the `dotenv` gem to load the `.env` file in development. This is not used in production.

For production, you can set the environment variables in the environment where the application is running.

> Why do we use environment variables and not credentials or secrets?

This is a good question. Storing secrets in environment variables is not the most secure way to store secrets. However, it is the most convenient way to store secrets for local development.

We are trying to make the application as easy to set up as possible for developers who don't have access to the master keys. We want to avoid having to distribute keys - and to avoid forcing developers to generate their own credentials files that might clash with environment-specific files used elsewhere.

We will look at using Rails credentials in the future. For now, we are using environment variables.

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
