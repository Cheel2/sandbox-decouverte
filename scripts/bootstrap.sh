#!/bin/bash
# Script de réinstallation des dépendances éphémères
# À exécuter si la machine Cloud Shell a été recyclée
# (les outils système installés hors $HOME disparaissent,
#  mais le repo cloné dans $HOME et node_modules survivent)

set -e
echo "=== BOOTSTRAP ==="
echo "Répertoire courant : $(pwd)"
echo "1/2 — npm install (node_modules dans $HOME est persistant)"
npm install
echo "2/2 — Réinstallation des navigateurs Playwright"
npx playwright install chromium
echo "=== BOOTSTRAP TERMINÉ ==="
