Drift detected in **${{ env.ENVIRONMENT }}**.

- Commit: ${{ github.sha }}
- Workflow: Drift Watch
- Date: $(date -u)

Please review the drift-plan.json evidence in the S3 evidence bucket and decide whether to:
- apply the plan, or
- update the baseline to match reality.
