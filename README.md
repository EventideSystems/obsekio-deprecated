# README

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



* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
