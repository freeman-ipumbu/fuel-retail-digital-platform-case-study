#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
failure=0

# Private source identifiers are assembled from byte values so the check can scan
# itself without placing those identifiers in the public repository.
client_mark="$(printf '\160\165\155\141')"
source_org="$(printf '\164\160\164\163')"
private_host="$(printf '\160\165\155\141\055\156\141\155\151\142\151\141\055\144\151\147\151\164\141\154\056\160\141\147\145\163\056\144\145\166')"
restricted_noun_one="$(printf '\164\157\153\145\156')"
restricted_noun_two="$(printf '\143\162\145\144\145\156\164\151\141\154')"
relationship_term_one="$(printf '\143\157\155\155\151\163\163\151\157\156')"
relationship_term_two="$(printf '\145\156\144\157\162\163\145\155\145\156\164')"
relationship_term_three="$(printf '\143\157\156\164\162\141\143\164')"

scan_pattern() {
  local label="$1"
  local pattern="$2"
  local matches

  matches="$(find "$repo_root" -type f -not -path '*/.git/*' -print0 \
    | xargs -0 grep -IinE -- "$pattern" 2>/dev/null || true)"

  if [[ -n "$matches" ]]; then
    printf 'FAIL: %s\n%s\n' "$label" "$matches"
    failure=1
  fi
}

scan_pattern "private client identifier found" "$client_mark"
scan_pattern "private organization identifier found" "$source_org"
scan_pattern "private deployment address found" "$private_host"
scan_pattern "email address found" '[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}'
scan_pattern "UUID-like infrastructure value found" '[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}'
scan_pattern "restricted source wording found" "${restricted_noun_one}s?|${restricted_noun_two}s?"
scan_pattern "relationship claim wording found" "${relationship_term_one}|${relationship_term_two}|${relationship_term_three}"
scan_pattern "private-key block found" 'BEGIN[[:space:]].*PRIVATE[[:space:]]KEY'
scan_pattern "provider secret-like value found" '(gh[pousr]_[A-Za-z0-9]{20,}|sk-[A-Za-z0-9]{20,}|AKIA[0-9A-Z]{16})'
scan_pattern "authorization header found" 'Authorization:[[:space:]]*Bearer[[:space:]]+'

if [[ "$failure" -ne 0 ]]; then
  printf '\nPublic-safety verification failed. Remove or neutralize the flagged material.\n'
  exit 1
fi

printf 'Public-safety verification passed.\n'
