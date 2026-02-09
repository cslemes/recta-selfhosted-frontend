# ============================================================
# Frontend – multi-stage production image
# ============================================================

# ── Base ─────────────────────────────────────────────────────
FROM node:20-alpine AS base
WORKDIR /app

# ── Dependencies (cached layer) ─────────────────────────────
FROM base AS deps
COPY package.json package-lock.json* ./
RUN npm ci

# ── Build ────────────────────────────────────────────────────
FROM base AS build

# Vite reads VITE_* from process.env at build time.
# Pass each variable via docker-compose build.args → ARG → ENV.
ARG VITE_API_BASE_URL
ARG VITE_FIREBASE_API_KEY
ARG VITE_FIREBASE_AUTH_DOMAIN
ARG VITE_FIREBASE_PROJECT_ID
ARG VITE_FIREBASE_STORAGE_BUCKET
ARG VITE_FIREBASE_MESSAGING_SENDER_ID
ARG VITE_FIREBASE_APP_ID
ARG VITE_FIREBASE_MEASUREMENT_ID
ARG VITE_SENTRY_DSN
ARG VITE_PREMIUM_FOR_ALL_USERS
ARG VITE_FLAG_MAINTENANCE

COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

# ── Production (minimal unprivileged nginx) ──────────────────
FROM nginxinc/nginx-unprivileged:stable-alpine AS production

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
