# Ops

Thin operator reference for `vgoyette` on Fly.io. **Why** this stack was
chosen lives in `personal-site-brain` (ADR-004 fly-github-actions, plan
2026-07-11-fly-deploy) — do not grow rationale here.

## Environment

| What              | Value                                        |
| ----------------- | -------------------------------------------- |
| Fly app           | `vgoyette`                                   |
| Public URL        | https://vgoyette.fly.dev                     |
| Region            | `yyz` (Toronto)                              |
| Postgres cluster  | `vgoyette-db` (Fly UPG / postgres-flex, `yyz`) |
| App machine       | `shared-cpu-1x`, 512 MB RAM, port 8080       |
| DB machine        | `shared-cpu-1x`, 256 MB RAM, 1 GB volume     |
| Health check      | `GET /up`                                    |
| Master key secret | `RAILS_MASTER_KEY` (Fly secret)              |
| DB secret         | `DATABASE_URL` (set by `fly postgres attach`)|
| CI deploy token   | GitHub repo secret `FLY_API_TOKEN`           |

Machines are configured with `auto_stop_machines = "stop"` and
`min_machines_running = 0`, so the app sleeps when idle. First request
after a sleep incurs a ~5–15s cold start.

## One-time bootstrap (done 2026-07-11, kept for reference)

```bash
brew install flyctl
fly auth login

cd ~/Projects/personal-site
fly launch --copy-config --no-deploy --name vgoyette --region yul \
  --org personal --yes
# `--yes` accepts defaults; with UPG (the older Postgres product) as
# the non-interactive default. If starting fresh and you want Managed
# Postgres (MPG) instead of UPG, add `--db=mpg`.
#
# Fly may remap the region (we asked for yul, got yyz). Fly also
# regenerates fly.toml — accept it, then re-add HTTP_PORT = '8080' in
# [env] so Thruster binds to the port Fly expects.

# UPG was auto-provisioned by `fly launch --yes`. If you skipped that or
# want to add MPG separately, use `fly mpg create` (paid tier).

fly secrets set RAILS_MASTER_KEY="$(cat config/master.key)" --app vgoyette --stage

fly deploy --remote-only   # first manual deploy

fly tokens create deploy -x 999999h
# The `fly launch` above already added FLY_API_TOKEN to the GitHub repo
# secrets via the `gh` CLI. To move it to the production environment
# instead, delete the repo secret and re-add under Settings → Environments
# → production. The workflow finds it either way (env→repo fallback).
```

## Day-to-day

```bash
fly deploy                          # manual deploy (bypasses CI)
fly logs -a vgoyette                # tail logs
fly status -a vgoyette              # machine health
fly releases list -a vgoyette       # deploy history
fly ssh console -a vgoyette         # shell into a running machine
fly ssh console -a vgoyette -C "bin/rails console"  # rails console
fly secrets list -a vgoyette        # names only, values never shown
fly secrets set FOO=bar -a vgoyette # add/update a secret (triggers redeploy)
fly pg connect -a vgoyette-db       # psql into the Postgres cluster
```

## Rollback

```bash
fly releases list -a vgoyette                     # find the last-good release
fly deploy --app vgoyette --image <registry.fly.io/vgoyette:deployment-XXXX>
# image tags shown in `fly releases list` under the IMAGE column
```

## CI/CD

Every push to `main` runs the CI jobs in
[.github/workflows/ci.yml](../.github/workflows/ci.yml); when all pass, the
`deploy` job runs `flyctl deploy --remote-only` against the same SHA. PRs
never deploy. Concurrency group `deploy-production` prevents overlap.

If a deploy job fails but CI was green, most-common causes:

1. `FLY_API_TOKEN` secret missing or expired → regenerate with
   `fly tokens create deploy` and update the GitHub Environment secret.
2. Migration in `release_command` failed → check `fly logs` and roll back.
3. Health check failing on `/up` → boot error; check `fly logs` for the trace.
