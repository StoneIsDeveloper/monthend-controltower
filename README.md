# Month-End Control Tower (Demo)

This repository contains a **Terraform-based AWS demo** for an
**event-driven Month-End Control Tower**.

The goal is to demonstrate a minimal but working system where:

- A web UI shows month-end steps and their statuses
- A user clicks **“Complete & Approve to Go”** on a step
- The step status is persisted in DynamoDB with audit fields
- An AWS EventBridge event automatically advances the **next step**
- The UI refreshes and shows the next step as **Ready**

This is a **working demo**, not a documentation-only project.

---

## 🧭 Demo Scope (MVP)

### Step Flow
The demo implements a fixed 3-step flow:

1. `BA_VALIDATE`
2. `DEV_CHECK`
3. `FIN_APPROVE`

Initial state:
- `BA_VALIDATE` → `Ready`
- `DEV_CHECK` → `NotStarted`
- `FIN_APPROVE` → `NotStarted`

Only when a user clicks **Complete & Approve to Go** will the system
advance to the next step.

---

## 🧱 Architecture Overview

**Infrastructure (Terraform-managed):**
- DynamoDB – step progress & audit storage
- API Gateway (HTTP API)
- Lambda:
  - API Lambda (step actions + queries)
  - Advancer Lambda (event-driven next-step activation)
- EventBridge – step-approved events
- S3 – static web UI hosting
- (Optional) CloudFront

**Frontend:**
- Static HTML + JavaScript (demo)
- Polls backend APIs every 30 seconds
- Refreshes immediately after user actions

---

## 📂 Repository Structure

.
├── AGENT.md # Engineering rules for Codex
├── README.md
├── infra/ # Terraform infrastructure
│ ├── main.tf
│ ├── variables.tf
│ ├── providers.tf
│ └── modules/
│ ├── dynamodb/
│ ├── api/
│ ├── events/
│ └── frontend/
├── services/
│ └── lambdas/
│ ├── api/
│ └── advancer/
└── frontend/
└── web/
├── index.html
├── app.js
└── styles.css

---

## 🚀 How the Demo Works

1. The UI loads from S3 and displays all steps
2. Only the step with status `Ready` shows an action button
3. User clicks **Complete & Approve**
4. API Lambda:
   - Updates DynamoDB (`ApprovedToGo`)
   - Records actor & timestamp
   - Emits EventBridge event
5. Advancer Lambda:
   - Receives event
   - Sets the next step to `Ready`
6. UI refreshes and displays the updated step

---

## ⚙️ Prerequisites

- AWS account with permission to create:
  - DynamoDB
  - Lambda
  - API Gateway
  - EventBridge
  - S3
- Terraform >= 1.6
- Node.js (for Lambda functions)
- AWS CLI configured (`aws configure` or SSO)

---

## GitHub Actions (Terraform apply)

This repo includes workflows that run Terraform plan/apply from `infra/`.
To enable them:

- Create an IAM role that trusts GitHub OIDC and grants Terraform permissions.
- Add `AWS_ROLE_ARN` in GitHub repo secrets.
- Ensure the Terraform remote state bucket and lock table exist.
- Make sure the Lambda zip artifacts are produced in CI (the workflow builds placeholders).

---

## 🛠 Deployment (Local)

```bash
cd infra
terraform init
terraform apply
Terraform will output:

UI URL (S3 website or CloudFront)

API base URL

DynamoDB table name

✅ Demo Verification Checklist
After deployment:

Open the UI URL

Confirm 3 steps are visible

Confirm only BA_VALIDATE is Ready

Click Complete & Approve

Verify:

BA_VALIDATE becomes ApprovedToGo

DEV_CHECK becomes Ready

Repeat for DEV_CHECK → FIN_APPROVE

No AWS Console manual actions required

🔒 Important Notes
This demo intentionally avoids:

Authentication / SSO

Step Functions

Production hardening

All state transitions are validated server-side

DynamoDB is the single source of truth

🧠 Future Extensions (Out of Scope)
Step Functions with task tokens

Multi-run support

Angular UI

Email / Teams notifications

Role-based access control

These can be added incrementally once the demo is stable.

📄 License

Internal demo / prototype use only.

## 🥇 Task 0：让 Codex 理解规则（只做一次）
Read AGENT.md carefully. Do not implement anything yet. Summarize the constraints and confirm understanding.


## 🥈 Task 1：生成 Terraform 骨架（只做 infra）

Create Terraform infrastructure skeleton according to AGENT.md.
Only generate infra/ and its modules.
Include DynamoDB, API Gateway HTTP API, Lambda placeholders,
EventBridge rule, and S3 static website.
Do not implement Lambda logic yet.
Run terraform fmt and validate.

**用户验收：**
- `terraform init`
- `terraform validate` 成功

---

## 🥉 Task 2：实现 DynamoDB + 初始化 3 个 Step

Implement DynamoDB table and add an initialization mechanism
that creates 3 steps for runId ME-202601-001:
BA_VALIDATE = Ready
DEV_CHECK = NotStarted
FIN_APPROVE = NotStarted
Initialization must be repeat-safe.

**验收：**
- apply 后 DynamoDB 中有 3 条记录
- 重复 apply 不会报错

## 🏅 Task 3：实现 API Lambda（不管 UI）

Implement API Lambda with:
GET /runs/{runId}
POST /runs/{runId}/steps/{stepId}/complete

Validate step transitions server-side.
Update DynamoDB with audit fields.
Emit EventBridge event MonthEndStepApproved.
Add minimal README notes.

**验收：**
- 用 curl/Postman 能看到步骤状态
- POST 后 DynamoDB 状态更新

---

## 🏆 Task 4：实现 Advancer Lambda（事件驱动）

Implement Advancer Lambda triggered by EventBridge.
On MonthEndStepApproved event:
If next step status is NotStarted, update it to Ready.
No direct API calls allowed.

**验收：**
- POST 完成一个 step
- 下一 step 自动变 Ready

---

## 🎖 Task 5：实现最小 UI（HTML + JS）

Create minimal static UI:

Display steps and statuses

Show button only for Ready step

Poll API every 30 seconds

Refresh immediately after action
Deploy UI to S3 via Terraform.


**验收（最重要）**
- 浏览器点按钮
- 下一步自动出现按钮

---

## 🧪 Task 6：端到端验证 & README 更新

Verify full demo flow end-to-end.
Update README with verification steps and screenshots description.
Do not add new features.
