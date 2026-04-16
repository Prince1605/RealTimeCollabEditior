# ================================
# STEP 1: Frontend build karna
# ================================

# Node base image use kar rahe (lightweight alpine version)
FROM node:20-alpine as frontend-builder

# Local Frontend folder ko container ke /app folder me copy karo
COPY ./Frontend /app

# Ab saare commands /app directory me run honge
WORKDIR /app  

# Frontend dependencies install karo
RUN npm install

# Frontend ko build karo (React/Vite → dist folder banega)
RUN npm run build


# ================================
# STEP 2: Backend build karna
# ================================

# Naya clean container start kar rahe backend ke liye
FROM node:20-alpine

# Backend code ko container ke /app me copy karo
COPY ./Backend /app

# Working directory set karo
WORKDIR /app

# Backend dependencies install karo
RUN npm install


# ================================
# STEP 3: Frontend ko backend me inject karna
# ================================

# Frontend builder stage se dist folder uthake
# backend ke public folder me daal rahe
# taaki backend frontend files serve kar sake
COPY --from=frontend-builder /app/dist /app/public


# ================================
# STEP 4: Server start karna
# ================================

# Container start hote hi backend server run hoga
CMD ["node","server.js"]