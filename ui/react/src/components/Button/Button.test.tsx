import React from 'react';
import { describe, it, expect } from 'vitest';
import { render, screen, fireEvent } from '@testing-library/react';
import { Button } from './Button';

describe('Button', () => {
  it('renders children', () => {
    render(<Button>Click me</Button>);
    expect(screen.getByText('Click me')).toBeInTheDocument();
  });

  it('applies primary variant by default', () => {
    render(<Button>Test</Button>);
    expect(screen.getByRole('button')).toHaveClass('btech-button--primary');
  });

  it('applies the specified variant class', () => {
    render(<Button variant="secondary">Test</Button>);
    expect(screen.getByRole('button')).toHaveClass('btech-button--secondary');
  });

  it('applies the specified size class', () => {
    render(<Button size="lg">Test</Button>);
    expect(screen.getByRole('button')).toHaveClass('btech-button--lg');
  });

  it('applies md size by default', () => {
    render(<Button>Test</Button>);
    expect(screen.getByRole('button')).toHaveClass('btech-button--md');
  });

  it('sets disabled attribute when disabled', () => {
    render(<Button disabled>Test</Button>);
    expect(screen.getByRole('button')).toBeDisabled();
  });

  it('calls onClick when clicked', () => {
    let clicked = false;
    render(<Button onClick={() => (clicked = true)}>Test</Button>);
    fireEvent.click(screen.getByRole('button'));
    expect(clicked).toBe(true);
  });

  it('forwards ref to button element', () => {
    const ref = React.createRef<HTMLButtonElement>();
    render(<Button ref={ref}>Test</Button>);
    expect(ref.current).toBeInstanceOf(HTMLButtonElement);
  });

  it('merges custom className', () => {
    render(<Button className="custom-class">Test</Button>);
    const button = screen.getByRole('button');
    expect(button).toHaveClass('btech-button');
    expect(button).toHaveClass('custom-class');
  });

  it('passes through HTML button attributes', () => {
    render(<Button type="submit">Test</Button>);
    expect(screen.getByRole('button')).toHaveAttribute('type', 'submit');
  });
});
