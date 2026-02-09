# Frontend Deployment (Vercel)

## Prerequisites

1. A [Vercel](https://vercel.com) account
2. A GitHub repository for the frontend code

## Setup

### 1. Connect Repository to Vercel

1. Go to [Vercel Dashboard](https://vercel.com/dashboard)
2. Click **Add New → Project**
3. Import your GitHub repository
4. Configure:
   - **Framework Preset**: Vite
   - **Build Command**: `npm run build`
   - **Output Directory**: `dist`

### 2. Configure Environment Variables

In Vercel Dashboard → Project → Settings → Environment Variables:

```env
# API URL (your Railway backend)
VITE_API_BASE_URL=https://your-backend.up.railway.app

# Firebase (client-side)
VITE_FIREBASE_API_KEY=your-api-key
VITE_FIREBASE_AUTH_DOMAIN=your-project.firebaseapp.com
VITE_FIREBASE_PROJECT_ID=your-project-id
VITE_FIREBASE_STORAGE_BUCKET=your-project.appspot.com
VITE_FIREBASE_MESSAGING_SENDER_ID=123456789
VITE_FIREBASE_APP_ID=1:123456789:web:abcdef

# Optional
VITE_FIREBASE_MEASUREMENT_ID=G-XXXXXXXXXX
VITE_SENTRY_DSN=https://xxx@sentry.io/xxx
VITE_PREMIUM_FOR_ALL_USERS=true
VITE_FLAG_MAINTENANCE=false
```

### 3. GitHub Actions Secrets

In your GitHub repository → Settings → Secrets and variables → Actions:

| Secret | Description |
|--------|-------------|
| `VERCEL_TOKEN` | Vercel API token from [Account Settings](https://vercel.com/account/tokens) |
| `VERCEL_ORG_ID` | Your Vercel team/org ID (from `.vercel/project.json` after `vercel link`) |
| `VERCEL_PROJECT_ID` | Project ID (from `.vercel/project.json` after `vercel link`) |

### Get Vercel IDs

```bash
# Install Vercel CLI
npm install -g vercel

# Link project (creates .vercel/project.json)
vercel link

# View the IDs
cat .vercel/project.json
```

## Deployment

Push to `main` branch triggers automatic deployment via GitHub Actions.

### Manual Deployment

```bash
vercel --prod
```

## Preview Deployments

Every pull request automatically gets a preview deployment URL.

## Custom Domain

1. Vercel Dashboard → Project → Settings → Domains
2. Add your domain
3. Configure DNS as instructed

## CORS Configuration

Make sure your backend's `ALLOWED_ORIGINS` includes your Vercel URLs:

```env
ALLOWED_ORIGINS=https://your-app.vercel.app,https://your-custom-domain.com
```
