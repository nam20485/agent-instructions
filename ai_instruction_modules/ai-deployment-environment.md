# Google Cloud Deployment Template

Example deployment configuration for ASP.NET Core + Blazor WASM applications.

## Prerequisites
- Google Cloud CLI: `gcloud auth login && gcloud config set project <PROJECT_ID>`
- Firebase CLI: `npm install -g firebase-tools && firebase login`  
- Docker (for local testing)

## Setup Process
1. **Service Accounts**: Create service accounts with appropriate IAM roles
2. **Environment Variables**: Configure OAuth, app IDs, secrets in Cloud Build triggers
3. **Backend Deployment**: Deploy API services to Cloud Run
4. **Frontend Deployment**: Deploy Blazor WASM to Firebase Hosting
5. **Testing**: Verify endpoints, authentication, logging

## Key Configuration Files
- `appsettings.Production.json` - Backend configuration
- `firebase.json` - Frontend hosting config
- `cloudbuild.yaml` - CI/CD pipeline
- Service account setup scripts

## Monitoring
- Cloud Run logs via Google Cloud Console
- Firebase Hosting via Firebase Console  
- Application metrics and error tracking

*Use as template - customize project IDs, service names, and authentication providers for your application.*