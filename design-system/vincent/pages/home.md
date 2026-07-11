# Home page overrides for design-system/vincent/MASTER.md

## Intent
Thin, hero-only first viewport. Brand is the dominant signal.

## Typography override
Use **Space Grotesk** (display) + **Archivo** (body) + JetBrains Mono (labels) instead of Playfair/Source Serif — avoids broadsheet density while staying distinctive (not Inter).

## Composition
- Full-bleed atmospheric gradient plane (orbs + wash)
- Brand name, one headline, one lede, CTA pair
- Theme toggle fixed top-right
- Minimal footer contact only — no project grid / cards in hero

## Motion
1. Orb drift (`animate-drift-*`, reduced-motion safe)
2. Staggered hero rise (`animate-rise`)
3. Theme cross-fade via CSS color tokens + `color-scheme`
