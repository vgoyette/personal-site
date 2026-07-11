# personal-site

Rails app for [vincent-goyette.com](https://github.com/vgoyette/personal-site). The "why" behind the app (stack, ops, capture flow) lives in the sibling brain vault: `../personal-site-brain`.

## Dev

```bash
bin/setup       # install gems, prepare dev + test DBs
bin/dev         # web + tailwind:watch on :3000
bundle exec rspec
```

Requires Ruby (see `.ruby-version`) and PostgreSQL 16+.

## CI

GitHub Actions runs on every PR and push to `main` ([`.github/workflows/ci.yml`](.github/workflows/ci.yml)):

| Job | Runs |
|---|---|
| `scan_ruby` | Brakeman |
| `scan_js` | `importmap audit` |
| `lint` | RuboCop (omakase) |
| `test` | `bin/rails db:prepare` + `bundle exec rspec` against a Postgres 16 service |

The test job sets `DATABASE_URL=postgres://postgres:postgres@localhost:5432/personal_site_test`; Rails merges it over [`config/database.yml`](config/database.yml).

## Deploy

Not wired yet. Fly.io is the target — see [`AGENTS.md`](AGENTS.md) and the brain's deploy ADR.
