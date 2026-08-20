import { describe, it, expect } from 'vitest';
import { add, multiply, divide } from '../src/calcul.js';

describe('calcul', () => {
  it('additionne deux nombres', () => {
    expect(add(2, 3)).toBe(5);
  });

  it('multiplie deux nombres', () => {
    expect(multiply(4, 5)).toBe(20);
  });

  it('divise deux nombres et refuse la division par zéro', () => {
    expect(divide(10, 2)).toBe(5);
    expect(() => divide(10, 0)).toThrow('Division par zéro impossible');
  });
});
