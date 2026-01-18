1. Project Purpose

This repository implements a Month-End Control Tower Demo.

The system must demonstrate:

A web UI that displays month-end steps and their statuses

A user clicking “Complete & Approve to Go” on a step

The step status being persisted in DynamoDB with audit fields

An AWS event-driven mechanism that automatically advances the next step

The UI updating to show the next step as Ready

This repository is a working demo, not a documentation-only project.

2. Mandatory Technology Stack (Hard Constraints)

The agent MUST use the following technologies:

Infrastructure as Code

Terraform only

No CloudFormation, CDK, or manual AWS console configuration

AWS Services

DynamoDB (state and audit storage)

AWS Lambda (Node.js runtime)

API Gateway HTTP API

Amazon EventBridge (event-driven step advancement)

Amazon S3 (static UI hosting)

(Optional but allowed) CloudFront

Frontend

Initial demo: plain HTML + JavaScript

UI must poll backend APIs (default 30 seconds)

UI must refresh immediately after user actions

Angular may be introduced later but is NOT required for MVP

Repository Hosting

GitHub (public or private)

Terraform state must be designed to support remote backend later

3. System Behavior Requirements (Non-Negotiable)
Step Flow (Demo Scope)

The demo MUST implement the following fixed step sequence:

BA_VALIDATE

DEV_CHECK

FIN_APPROVE

Initial state:

BA_VALIDATE = Ready

DEV_CHECK = NotStarted

FIN_APPROVE = NotStarted

Status Transition Rules

Only these transitions are allowed in the demo:

NotStarted → Ready

Ready → ApprovedToGo

ApprovedToGo → (event-driven) next step becomes Ready

No automatic approvals.
All step completion requires a user click.

4. Event-Driven Advancement Rule

When a step transitions to ApprovedToGo:

The backend MUST persist the change to DynamoDB

The backend MUST publish an EventBridge event:

source = "monthend.controltower"

detail-type = "MonthEndStepApproved"

A separate Lambda (advancer) MUST:

Listen for the event

Identify the nextStepId

Set the next step status to Ready only if it is NotStarted

No direct API calls are allowed between steps.
All advancement must be event-driven.

5. Data Storage Rules
DynamoDB Table

Single table design for step progress

Partition key: PK = RUN#{runId}

Sort key: SK = STEP#{stepId}

Each step item MUST store:

runId

stepId

stepName

status

ownerRole

nextStepId

updatedAtUtc

actorDisplayName

comment

The database is the single source of truth.

6. API Design Rules

The backend MUST expose:

GET /runs/{runId}

Returns all steps and statuses for the run

POST /runs/{runId}/steps/{stepId}/complete

Transitions the step to ApprovedToGo

Records audit fields

Emits EventBridge event

All state transition validation MUST occur server-side.
The frontend is never trusted.

7. UI Behavior Rules

The UI MUST:

Display all steps and their current statuses

Show an action button only when a step status is Ready

Disable or hide buttons for all other statuses

Poll the backend every 30 seconds

Refresh immediately after a user action

Clearly indicate which step is currently actionable

No real-time WebSocket or SSE is required for the demo.

8. Agent Permissions and Restrictions
The Agent MAY:

Generate Terraform code

Generate Lambda source code

Generate frontend UI code

Modify existing files to meet requirements

Run terraform fmt, terraform validate, and local build commands

Update README with deployment and verification instructions

The Agent MUST NOT:

Automatically approve steps

Introduce additional AWS services without justification

Delete AWS resources without explicit instruction

Change step order or logic without updating this document

Store secrets or credentials in code or Terraform state

9. Repository Structure (Required)

The agent MUST maintain this structure:

infra/               # Terraform code
  modules/
services/
  lambdas/
    api/
    advancer/
frontend/
  web/
README.md
AGENT.md

10. Verification Criteria (Acceptance Checklist)

A change is considered complete only if:

terraform init && terraform apply succeeds

The UI loads from S3 (or CloudFront)

The UI shows all three steps

Clicking Complete & Approve on BA_VALIDATE:

Updates DynamoDB

Triggers EventBridge

Automatically sets DEV_CHECK to Ready

The UI refreshes and displays the updated status

No manual AWS console intervention is required

11. Future Extensions (Out of Scope for MVP)

These are explicitly out of scope for the demo:

Step Functions

Multi-run support

Authentication / SSO

Fine-grained role-based access control

Production hardening

The agent must NOT implement these unless explicitly instructed.

12. Change Management

Any deviation from this document MUST:

Be explicitly requested by the user

Be reflected by updating this 