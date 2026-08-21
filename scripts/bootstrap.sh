#!/bin/bash
# Stratégie "salle de débordement éphémère"
# Objectif : garder $HOME sous les 4,8 GB en déportant node_modules et Playwright
# dans le disque éphémère (/tmp). A relancer apres chaque recyclage de machine.

set -e

if [ ! -f "package.json" ]; then
  echo "ERREUR : lance ce script depuis la racine du projet"
  exit 1
fi

PROJECT_NAME=$(basename "$(pwd)")
EPHEMERAL_BASE="/tmp/workdir/${PROJECT_NAME}"
NODE_MODULES_EPHEMERAL="${EPHEMERAL_BASE}/node_modules"
PLAYWRIGHT_BROWSERS_PATH="/tmp/ms-playwright"

echo "=== BOOTSTRAP ==="
echo "Projet    : ${PROJECT_NAME}"
echo "Ephemere  : ${EPHEMERAL_BASE}"

mkdir -p "${NODE_MODULES_EPHEMERAL}"
mkdir -p "${PLAYWRIGHT_BROWSERS_PATH}"

if [ -d "node_modules" ] && [ ! -L "node_modules" ]; then
  echo "Suppression de l'ancien node_modules local..."
  rm -rf node_modules
fi

if [ ! -L "node_modules" ]; then
  ln -s "${NODE_MODULES_EPHEMERAL}" node_modules
  echo "Lien symbolique cree : node_modules -> ${NODE_MODULES_EPHEMERAL}"
else
  echo "Lien symbolique node_modules deja present."
fi

echo "1/3 — npm install (dans l'ephemere)..."
npm install

echo "2/3 — Playwright Chromium (dans l'ephemere)..."
export PLAYWRIGHT_BROWSERS_PATH="${PLAYWRIGHT_BROWSERS_PATH}"
npx playwright install chromium

echo "3/3 — Verification df -h ~ :"
df -h ~

echo "=== BOOTSTRAP TERMINE ==="
echo "Espace $HOME :"
du -sh . 2>/dev/null || true
echo "Espace node_modules ephemere :"
du -sh "${NODE_MODULES_EPHEMERAL}" 2>/dev/null || true
echo "Espace Playwright :"
du -sh "${PLAYWRIGHT_BROWSERS_PATH}" 2>/dev/null || true
