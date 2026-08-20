import { test, expect } from '@playwright/test';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

test('la page affiche le titre attendu', async ({ page }) => {
  const htmlPath = join(__dirname, '..', 'index.html');
  await page.goto('file://' + htmlPath);
  await expect(page.locator('h1')).toHaveText('Bienvenue sur le bac à sable');
});
