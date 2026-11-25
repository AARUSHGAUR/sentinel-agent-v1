# Sentinel v1

Private local-first bug bounty assistant for explicitly authorized programs. Source package: `sentinel-v1-secure-local.zip`.

Safety: the sample program is disabled; the dashboard uses HTTP Basic and is read-only; no approval/report-submission endpoint exists; rate/scope checks apply; no model keys are configured; no scans have been run; reports are never submitted.

This v1 dashboard cannot start scans; the runner is CLI-only. Render free services use ephemeral filesystems, so local SQLite data is lost on restart or spin-down. Keep credentials in host environment variables, never in this repository.