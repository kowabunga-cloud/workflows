#!/usr/bin/env bash
# Waits for all other workflow runs of the current commit to complete, and
# fails if any of them didn't succeed.
#
# Expects GH_TOKEN, REPO, SHA, RUN_ID, WORKFLOW_REF and TIMEOUT (minutes).
set -euo pipefail

# this workflow's file, so that its other runs (e.g. re-runs) are
# ignored
self=$(sed -E 's|^[^/]+/[^/]+/||; s|@.*$||' <<< "$WORKFLOW_REF")
deadline=$(( $(date +%s) + TIMEOUT * 60 ))

# leave time for runs triggered by the same push to be created
sleep 20

while true; do
  runs=$(gh api "repos/${REPO}/actions/runs?head_sha=${SHA}&per_page=100" \
    --jq "[.workflow_runs[]
           | select(.id != ${RUN_ID} and .path != \"${self}\")
           | select(.event == \"push\" or .event == \"workflow_dispatch\")]")
  pending=$(jq -r '[.[] | select(.status != "completed") | .name] | unique | join(", ")' <<< "$runs")
  failed=$(jq -r '[.[] | select(.status == "completed"
                               and (.conclusion | IN("success", "skipped", "neutral") | not))
                        | "\(.name) (\(.conclusion))"] | unique | join(", ")' <<< "$runs")

  if [ -n "$failed" ]; then
    echo "::error::Not releasing, failed workflow runs: ${failed}"
    exit 1
  fi
  if [ -z "$pending" ]; then
    done=$(jq -r '[.[].name] | unique | join(", ")' <<< "$runs")
    echo "All workflow runs succeeded: ${done:-none}" \
      | tee -a "$GITHUB_STEP_SUMMARY"
    exit 0
  fi
  if [ "$(date +%s)" -ge "$deadline" ]; then
    echo "::error::Timed out waiting for workflow runs: ${pending}"
    exit 1
  fi
  echo "Waiting for: ${pending}"
  sleep 30
done
