---
description: Template and instructions for deploying ASP.NET Core + Blazor WASM apps to Google Cloud.
scope: deployment
prerequisites: none
context: opt-in
---
# Google Cloud Deployment Template

<xml>
<instructions role="deployment-engineer" scope="deployment">

<overview>
## Overview
Deployment configuration for ASP.NET Core + Blazor WASM applications on Google Cloud Platform (Cloud Run + Firebase Hosting).
</overview>

<prerequisites>
## Prerequisites
-   **Google Cloud CLI:** `gcloud auth login && gcloud config set project <PROJECT_ID>`
-   **Firebase CLI:** `npm install -g firebase-tools && firebase login`
-   **Docker:** For local testing.
</prerequisites>

<process>
## Setup Process
1.  **IAM:** Create service accounts with least privilege.
2.  **Config:** Set env vars (OAuth, secrets) in Cloud Build triggers.
3.  **Backend:** Deploy API services to Cloud Run.
4.  **Frontend:** Deploy Blazor WASM to Firebase Hosting.
5.  **Verify:** Test endpoints, auth flow, and logging.
</process>

<files>
## Key Configuration
-   `appsettings.Production.json`: Backend config.
-   `firebase.json`: Frontend hosting config.
-   `cloudbuild.yaml`: CI/CD pipeline.
</files>

<monitoring>
## Monitoring
-   **Logs:** Cloud Run (GCP Console).
-   **Hosting:** Firebase Console.
-   **Metrics:** Error tracking and APM.
</monitoring>

<notes>
## Notes
-   Use as a template.
-   Customize Project IDs, Service Names, and Auth Providers.
</notes>

</instructions>
</xml>
