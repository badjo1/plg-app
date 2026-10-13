# Tasks: Style Redesign

**Input**: `specs/001-style-redesign/plan.md`

## Phase 0 — Design Tokens

- [x] `T01` `[US1]` Tailwind config: kleur- en font-tokens via `@theme` in `application.tailwind.css`
- [x] `T02` `[US1]` Google Fonts: DM Sans + Kalam laden in `application.html.erb`, cloud.typography verwijderd
- [x] `T03` `[US1]` Base styles herschreven: body, headings, paragraphs, links, sections
- [x] `T04` `[US1]` Component classes: `.hand`, `.intent-card`, `.doodle`, `.btn-primary`, `.btn-secondary`, `.section-label`
- [x] `T05` `[US1]` Oude custom kleuren verwijderd

## Phase 1 — Layouts

- [x] `T06` `[US1]` `_header.html.erb` — PLAYGROUND logo (hand-font), responsive menu
- [x] `T07` `[US1]` `_footer.html.erb` — Minimalistisch met footer-links + tagline
- [x] `T08` `[US1]` `_button.html.erb` — Pill-shaped, donkergroen, pijl-animatie
- [x] `T09` `[US1]` `application.html.erb` — body class, Google Fonts, Manifold verwijderd

## Phase 2 — Homepage

- [x] `T10` `[US2]` Hero: "What brings you to the Playground?" + intent-cards
- [x] `T11` `[US2]` About-sectie in nieuwe stijl
- [x] `T12` `[US2]` Projects in intent-card stijl
- [x] `T13` `[US2]` Get Involved CTA
- [x] `T14` `[US2]` Stories in card-stijl
- [x] `T15` `[US2]` Community Voices quotes geactiveerd
- [x] `T16` `[US2]` Values grid: Freedom/Curiosity/Welcome/Meeting/Meaning
- [x] `T17` `[US2]` Email signup form geïntegreerd

## Phase 3 — Overige pagina's

- [x] `T18` `[US3]` Alle views gescand op hardcoded kleur-classes
- [x] `T19` `[US3]` Conflicten gefixed (pages, walls, sessions, registrations, flash)
- [x] `T20` `[US3]` Gebroken HTML/JSX opgeruimd (get_involved.html.erb)
- [ ] `T21` Landing layout — uitgesteld (gate-vraag: later)

## Phase 4 — Convergence

- [ ] `T22` Visuele check: homepage in browser
- [ ] `T23` Visuele check: subpagina's
- [ ] `T24` Responsive check: mobile viewport
