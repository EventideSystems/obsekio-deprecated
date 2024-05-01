# Obsekio

[![License: AGPL v3](https://img.shields.io/badge/License-AGPL_v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)
![check](https://github.com/EventideSystems/obsekio/actions/workflows/check.yml/badge.svg)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-community-brightgreen.svg)](https://rubystyle.guide)

Obsekio allows users to define and manage compliance with configurable standards. It is based on ideas from Atul Gawande's book ["The Checklist Manifesto"](https://atulgawande.com/book/the-checklist-manifesto/) and is designed to help users create and manage checklists for complex tasks.

The application is built using Ruby on Rails / PostgreSQL and is designed to be self-hosted. It is licensed under the [AGPL v3](https://www.gnu.org/licenses/agpl-3.0).

## Core Concepts

### Checklists

A checklist is a list of items that need to be completed in order to achieve a specific goal. Checklists can be used to ensure that complex tasks are completed correctly and consistently.

### Workflows

Each checklist is associated with a particular workflow, defining the general behavior of the checklist.

#### Single-use checklists

Single-use checklists are checklists that can only be completed once. Once all items on the checklist have been completed, the checklist is marked as complete and cannot be used again.

#### Recurring checklists

Recurring checklists are checklists that can be completed multiple times. Once all items on the checklist have been completed, the checklist is marked as complete and can be used again in a new context (e.g. as a daily, weekly or monthly checklist).

#### Concurrent checklists

Concurrent checklists are checklists that require multiple checklists to be completed in parallel. For example, a complex task that requires multiple checklists to be completed in order to achieve a specific goal.

#### Custom workflows

Custom workflows allow users to define their own workflows for checklists. This can be used to define complex workflows that are not covered by the standard workflows.

Custom workflows may be defined using a simple DSL or by extending the base workflow classes in code.

### Libraries

A library is a collection of checklists. Libraries can be used to group related checklists together and make it easier to manage them. Libraries can be shared with other users, or kept private.

## Features

- Create and manage libraries of checklists
- Define standards and requirements
- Assign checklists to users
- Track progress and completion
- Generate reports

## Roadmap

- [ ] Add support for single-use checklists
- [ ] Add support for recurring checklists
- [ ] Add support for concurrent checklists (complex tasks that require multiple checklists to be completed in parallel)
- [ ] Add support for teams

## System Requirements

- Ruby 3.3+. The application _should_ work on older Ruby versions, but we are targeting modern Ruby and may introduce backwardly-incompatible code by taking advantage of Ruby 3.3+ specific features in the future.

- PostgreSQL 12.9+.

- Any Linux-based OS. Tested using Ubuntu 20.04 LTS

## Installation

To install the application, clone the repository and run the following commands in the root folder of the project:

```bash
bundle install
rails db:create
rails db:migrate
```

This is a Rails 7+ application, so you can use the `./bin/dev` command to run the application:

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

The plan is to start using Rails credentials in the future. For now, we are using environment variables.

## Component Library

The Obsekio component library aims to be a collection of reusable components that can be used to build the Obsekio application. The component library will be based on Github's [View Components](https://github.com/ViewComponent) and make heavy use of [Tailwind CSS](https://tailwindcss.com/).

We are using [Lookbook](https://github.com/ViewComponent/lookbook) to document and develop the component library as we build it out. To access the component library, start the application in `development` mode and navigate to the following URL:

http://localhost:3000/lookbook

## Contributing

We welcome contributions from the community. Please see the [CONTRIBUTING.md](CONTRIBUTING.md) file for more information.

## Support

If you have any questions or need help, please open an issue on the [Github repository](https://github.com/EventideSystems/obsekio) or contact the maintainers directly.



