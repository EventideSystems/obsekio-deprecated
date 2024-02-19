# README

![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)
![Verify workflow](https://github.com/EventideSystems/obsekio/actions/workflows/verify.yml/badge.svg)

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

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
