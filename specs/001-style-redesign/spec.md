# Feature Specification: Style Redesign — Playground Amsterdam

**Date**: 2026-10-13 | **Status**: Draft

## Problem Statement

De huidige site gebruikt een zakelijke stijl (Gotham/Operator Mono, harde kleuren, corporate layout) die niet past bij de identiteit van Playground Amsterdam — een organische, speelse community voor creatieven, kunstenaars en ondernemers. De gedownloade `playground-welcome(1).html` definieert het gewenste visuele systeem: warm, hand-drawn, uitnodigend.

## Goals

1. Het visuele systeem uit de welcome-pagina wordt het design system voor de hele site
2. De homepage wordt opnieuw opgebouwd met de nieuwe stijl, inclusief alle bestaande content
3. Alle overige pagina's erven het nieuwe design via gedeelde layouts, tokens en componenten

## Non-Goals

- Functionaliteit wijzigen (auth, routing, subdomain-logica)
- Database-model aanpassen
- Nieuwe pagina's toevoegen

## Design System — Bron: `playground-welcome(1).html`

### Kleurpalet

| Token    | Hex       | Gebruik                          |
|----------|-----------|----------------------------------|
| `cream`  | `#f7f5e9` | Achtergrondkleur (body)          |
| `green`  | `#064e3b` | Primaire tekst, buttons          |
| `lime`   | `#d9e94b` | Accenten, highlights, underlines |
| `leaf`   | `#80d455` | Doodle-elementen, decoratie      |
| `muted`  | `#42695b` | Secundaire tekst                 |
| `border` | `#c9d1bd` | Card borders, dividers           |

### Typografie

| Rol       | Font   | Gewichten  | Gebruik                              |
|-----------|--------|------------|--------------------------------------|
| Body      | DM Sans| 400–700    | Alle tekst, navigatie, paragrafen    |
| Handschrift| Kalam | 400, 700   | Headings, logo, decoratieve tekst   |

### Componenten

- **Intent cards**: Afgeronde border, half-transparant wit, hover-rotatie + translateY
- **Buttons**: Pill-shaped (rounded-full), donkergroen, uppercase tracking, pijl-animatie
- **Doodles**: Decoratieve cirkels (leaf/lime) en handgeschreven tekst, absolute positioned
- **Values grid**: Icoon (hand-font) + label (uppercase) + korte beschrijving
- **Sectie-dividers**: Dunne lijn met handgeschreven tekst ertussen

## Content Mapping — Homepage

### Behouden uit nieuwe stijl (welcome HTML)

| Sectie              | Content                                                    |
|---------------------|------------------------------------------------------------|
| Header              | "PLAYGROUND / Amsterdam" logo + tagline                    |
| Hero                | "What brings you to the Playground?" + intent-cards        |
| Values              | Freedom, Curiosity, Welcome, Meeting, Meaning              |
| Footer              | Minimalistisch met tagline                                 |

### Integreren vanuit huidige homepage

| Sectie              | Content                                           | Aanpassing nodig               |
|---------------------|----------------------------------------------------|--------------------------------|
| About               | "What is the Playground?" + beschrijving           | Restylen in cream card         |
| Current Projects    | NFT Museum, Cosmolocal, Local Entrepreneur         | Nieuwe card-stijl (intent-card)|
| Get Involved        | CTA uitnodiging                                    | Deels vervangen door intent-form, korte CTA behouden |
| Stories & Podcasts  | Artist Spotlight, Future of DAOs, Cosmolocalism    | Grid in nieuwe card-stijl      |
| Community Voices    | 3 quotes (nu hidden)                               | Activeren, nieuwe quote-stijl  |

### Teksten die ontbreken / nieuw geschreven moeten worden

Geen — alle content bestaat al. De intent-cards en values uit de welcome HTML voegen nieuw materiaal toe; bestaande tekst wordt hergebruikt.

## User Stories

**US1**: Als bezoeker wil ik dat de hele site een warm, speels en samenhangend visueel systeem heeft, zodat de sfeer van de Playground direct voelbaar is.

**US2**: Als bezoeker wil ik op de homepage direct begrijpen wat de Playground is, wat er te doen is, en hoe ik betrokken kan raken — in een uitnodigende flow.

**US3**: Als bezoeker wil ik dat alle subpagina's dezelfde visuele taal spreken als de homepage.
