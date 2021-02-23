import { render, screen } from '@testing-library/react';
import App from './App';

test('test users list title', () => {
  render(<App />);
  const title = screen.getByText(/Users list/i);
  expect(title).toBeInTheDocument();
});

test('test add user button', () => {
  render(<App />);
  const title = screen.getByText(/Add user/i);
  expect(title).toBeInTheDocument();
});

test('test no users message', () => {
  render(<App />);
  const title = screen.getByText(/No users/i);
  expect(title).toBeInTheDocument();
});

