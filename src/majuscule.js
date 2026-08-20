export function toUpper(str) {
  if (typeof str !== 'string') {
    throw new Error('Entrée non valide : chaîne attendue');
  }
  return str.toUpperCase();
}
