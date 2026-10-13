# Implementation Plan: Style Redesign

**Branch**: `main` | **Date**: 2026-10-13 | **Spec**: `specs/001-style-redesign/spec.md`

## Summary

Het visuele systeem uit `playground-welcome(1).html` wordt de basis voor de hele site. Dit raakt de Tailwind config, stylesheets, layouts (header, footer, button partial), en alle view templates. De aanpak is inside-out: eerst design tokens, dan layouts, dan homepage, dan overige pagina's.

## Technical Context

**Language/Version**: Ruby 3.3.4, Rails 8.0.2
**Primary Dependencies**: Tailwind CSS 4.0 (via tailwindcss-ruby gem), Hotwire (Turbo + Stimulus), importmap
**Fonts**: Google Fonts (DM Sans, Kalam) — vervangt cloud.typography (Gotham/Operator Mono)
**Testing**: Visuele verificatie (geen geautomatiseerde UI-tests aanwezig)

## Scope per laag

### Laag 1 — Design Tokens (Tailwind config + CSS)

Bestanden:
- `config/tailwind.config.js` — kleuren en font-families toevoegen
- `app/assets/stylesheets/application.tailwind.css` — base styles herschrijven

Wijzigingen:
- Kleurtokens: `cream`, `green`, `lime`, `leaf`, `muted`, `border`
- Font-families: `sans` → DM Sans, `hand` → Kalam
- Base styles: body bg-cream, heading-stijlen met hand-font, paragraph-stijlen met DM Sans
- Custom utility classes: `.hand`, `.intent-card`, `.doodle`
- Verwijder oude custom kleuren (`.bg-light-green`, `.bg-dark-green`, `.bg-yellow`, `.text-yellow`)

### Laag 2 — Layouts

Bestanden:
- `app/views/layouts/application.html.erb` — Google Fonts laden, body class aanpassen, Manifold script verwijderen
- `app/views/layouts/_header.html.erb` — Nieuw: handgeschreven PLAYGROUND logo, tagline, schoner menu
- `app/views/layouts/_footer.html.erb` — Minimalistisch in nieuwe stijl
- `app/views/layouts/_button.html.erb` — Pill-shaped, donkergroen, pijl-animatie

### Laag 3 — Homepage

Bestand: `app/views/pages/home.html.erb`

Secties (van boven naar beneden):
1. **Hero** — "What brings you to the Playground?" + intent-cards (uit welcome HTML)
2. **About** — Bestaande "What is the Playground?" tekst, restyled
3. **Projects** — Bestaande 3 projecten in nieuwe card-stijl
4. **Get Involved** — Bestaande CTA, restyled
5. **Stories** — Bestaande 3 stories in nieuwe card-stijl
6. **Community Voices** — Quotes geactiveerd, nieuwe stijl
7. **Values** — Freedom/Curiosity/Welcome/Meeting/Meaning grid (uit welcome HTML)

### Laag 4 — Overige pagina's

Minimale aanpassingen nodig — erven via layout en Tailwind tokens. Controleren op:
- Hardcoded kleuren die niet meer bestaan (green-700, green-800, gray-50, etc.)
- Tailwind classes die conflicteren met de nieuwe base styles

## Risico's

| Risico | Impact | Mitigatie |
|--------|--------|-----------|
| Tailwind v4 syntax verschilt van v3 | Config werkt niet | Controleer of tailwindcss-ruby 4.0 JS-config of CSS-config verwacht |
| Subpagina's breken door base style wijzigingen | Visuele regressie | Laag 4 checkt alle views |
| Manifold embed script verwijderen breekt NFT-functionaliteit | Feature verlies | Behouden tenzij user bevestigt |

## Vragen aan user (gates)

1. **Manifold script** — `application.html.erb` laadt een Manifold (NFT claim) script + CSS. Moet dit behouden blijven, of kan het weg?
2. **cloud.typography** — De betaalde Gotham/Operator Mono fonts worden volledig vervangen door DM Sans/Kalam. Akkoord?
3. **Email signup form** — De welcome HTML heeft een email signup flow. Moet dit op de homepage komen (vereist backend-werk), of alleen de intent-cards zonder form?
4. **Landing layout** — `circles` en `explorer` gebruiken het `landing` layout zonder header/footer. Moet dit layout ook de nieuwe stijl krijgen?
