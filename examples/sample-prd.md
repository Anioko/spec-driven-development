# Task Manager

A simple B2B task tracker. Copy this file and run `demo.sh` (or `archiet-microcodegen examples/sample-prd.md --out ./myapp/`).

## Entities

- **Task**: title (string, required), description (text), status (string), due_date (date), project_id (uuid)
- **Project**: name (string, required), description (text)

## User Stories

As a user, I want to create tasks so I can track my work.
As a user, I want to assign tasks to projects so I can organise them.
As a user, I want to list all tasks in a project so I can see progress.

## Auth

- Email/password registration and login
- JWT in httpOnly cookies (no localStorage)

## Integrations

- Stripe for billing (subscription per workspace)
