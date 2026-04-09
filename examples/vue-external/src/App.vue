<script setup lang="ts">
/**
 * EXAMPLE: External Vue project consuming btech tokens
 *
 * This project is NOT inside the monorepo workspace.
 * It installs btech-ui from GitHub and imports tokens directly.
 *
 * package.json:
 *   "btech-ui": "github:RamaMS06/btech-ui"
 *
 * main.ts:
 *   import 'btech-ui/tokens/generated/web/tokens.css'
 *
 * Then use CSS custom properties anywhere:
 *   var(--primary), var(--border), var(--radius), etc.
 *
 * Dark mode:
 *   document.documentElement.classList.toggle('dark')
 */

function toggleDark() {
  document.documentElement.classList.toggle('dark');
}
</script>

<template>
  <div class="app">
    <h1 class="title">Btech Tokens — External Vue Example</h1>
    <p class="subtitle">All styles below use CSS custom properties from <code>@btech/tokens</code></p>

    <section class="section">
      <h2 class="heading">Buttons</h2>
      <div class="button-row">
        <button class="btn btn-primary">Primary</button>
        <button class="btn btn-secondary">Secondary</button>
        <button class="btn btn-ghost">Ghost</button>
        <button class="btn btn-destructive">Destructive</button>
        <button class="btn btn-primary" disabled>Disabled</button>
      </div>
    </section>

    <section class="section">
      <h2 class="heading">Cards</h2>
      <div class="card-row">
        <div class="card">
          <h3 class="card-title">Default Card</h3>
          <p class="card-text">Uses --card, --card-foreground, --border, --shadow-md, --radius</p>
        </div>
        <div class="card card-muted">
          <h3 class="card-title">Muted Card</h3>
          <p class="card-text">Uses --muted, --muted-foreground</p>
        </div>
      </div>
    </section>

    <section class="section">
      <h2 class="heading">Form</h2>
      <div class="form-row">
        <input class="input" type="text" placeholder="Default input" />
        <input class="input input-error" type="text" placeholder="Error state" />
      </div>
    </section>

    <section class="section">
      <h2 class="heading">Feedback</h2>
      <div class="feedback-row">
        <div class="badge badge-success">Success</div>
        <div class="badge badge-warning">Warning</div>
        <div class="badge badge-destructive">Error</div>
        <div class="badge badge-info">Info</div>
      </div>
    </section>

    <section class="section">
      <h2 class="heading">Dark Mode</h2>
      <button class="btn btn-secondary" @click="toggleDark">Toggle Dark Mode</button>
      <p class="card-text">Click to toggle. All tokens switch automatically via <code>.dark</code> class.</p>
    </section>
  </div>
</template>

<style>
/* ─── Layout ──────────────────────────────────── */
.app {
  max-width: 800px;
  margin: 0 auto;
  padding: 2rem;
  font-family: var(--font-sans);
  color: var(--background-foreground);
  background: var(--background);
  min-height: 100vh;
  transition: background var(--duration-normal) var(--ease-default),
              color var(--duration-normal) var(--ease-default);
}

/* ─── Typography ──────────────────────────────── */
.title {
  font-size: 2.25rem;
  font-weight: 700;
  color: var(--primary);
  margin-bottom: 0.5rem;
}

.subtitle {
  color: var(--muted-foreground);
  margin-bottom: 2rem;
}

.heading {
  font-size: 1.25rem;
  font-weight: 600;
  margin-bottom: 1rem;
  color: var(--background-foreground);
}

/* ─── Sections ────────────────────────────────── */
.section {
  margin-bottom: 2rem;
  padding-bottom: 2rem;
  border-bottom: 1px solid var(--border);
}

/* ─── Buttons ─────────────────────────────────── */
.button-row {
  display: flex;
  gap: 0.75rem;
  flex-wrap: wrap;
}

.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 0.5rem 1rem;
  font-size: 0.875rem;
  font-weight: 500;
  font-family: var(--font-sans);
  border: 1px solid transparent;
  border-radius: var(--radius);
  cursor: pointer;
  transition: opacity var(--duration-fast) var(--ease-default);
}

.btn:hover:not(:disabled) {
  opacity: 0.9;
}

.btn:disabled {
  cursor: not-allowed;
  background: var(--muted);
  color: var(--muted-foreground);
  border-color: var(--muted);
}

.btn-primary {
  background: var(--primary);
  color: var(--primary-foreground);
}

.btn-secondary {
  background: var(--secondary);
  color: var(--secondary-foreground);
  border-color: var(--border);
}

.btn-ghost {
  background: transparent;
  color: var(--accent-foreground);
}

.btn-ghost:hover:not(:disabled) {
  background: var(--accent);
  opacity: 1;
}

.btn-destructive {
  background: var(--destructive);
  color: var(--destructive-foreground);
}

/* ─── Cards ───────────────────────────────────── */
.card-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1rem;
}

.card {
  background: var(--card);
  color: var(--card-foreground);
  border: 1px solid var(--border);
  border-radius: var(--radius);
  padding: 1.5rem;
  box-shadow: var(--shadow-md);
}

.card-muted {
  background: var(--muted);
  color: var(--muted-foreground);
  box-shadow: none;
}

.card-title {
  font-size: 1rem;
  font-weight: 600;
  margin-bottom: 0.5rem;
}

.card-text {
  font-size: 0.875rem;
  color: var(--muted-foreground);
}

/* ─── Inputs ──────────────────────────────────── */
.form-row {
  display: flex;
  gap: 1rem;
}

.input {
  padding: 0.5rem 0.75rem;
  font-size: 0.875rem;
  font-family: var(--font-sans);
  border: 1px solid var(--input);
  border-radius: var(--radius);
  background: var(--background);
  color: var(--background-foreground);
  outline: none;
  transition: border-color var(--duration-fast) var(--ease-default);
  width: 100%;
}

.input:focus {
  border-color: var(--ring);
  box-shadow: 0 0 0 2px var(--ring);
}

.input-error {
  border-color: var(--destructive);
}

.input-error:focus {
  box-shadow: 0 0 0 2px var(--destructive);
}

/* ─── Badges ──────────────────────────────────── */
.feedback-row {
  display: flex;
  gap: 0.75rem;
}

.badge {
  padding: 0.25rem 0.75rem;
  font-size: 0.75rem;
  font-weight: 500;
  border-radius: 9999px;
}

.badge-success {
  background: var(--success);
  color: var(--success-foreground);
}

.badge-warning {
  background: var(--warning);
  color: var(--warning-foreground);
}

.badge-destructive {
  background: var(--destructive);
  color: var(--destructive-foreground);
}

.badge-info {
  background: var(--info);
  color: var(--info-foreground);
}

/* ─── Code ────────────────────────────────────── */
code {
  font-family: var(--font-mono);
  font-size: 0.8em;
  background: var(--muted);
  padding: 0.15rem 0.4rem;
  border-radius: 4px;
}

/* ─── Global reset ────────────────────────────── */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  margin: 0;
}
</style>
