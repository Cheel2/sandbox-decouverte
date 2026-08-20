import { describe, it, expect } from 'vitest';
import { toUpper } from '../src/majuscule.js';

describe('majuscule', () => {
  it('met une chaîne en majuscules', () => {
    expect(toUpper('bonjour')).toBe('BONJOUR');
  });

  it('rejette une entrée non chaîne', () => {
    expect(() => toUpper(123)).toThrow('Entrée non valide');
  });
});
