# Controlled pilot playbook

## Objective

Test whether one coordinated platform can improve checkout, fleet control and operational visibility while keeping promotional value away from fuel.

## Scope

Use a small group of sites that includes different operating conditions. Invite a bounded customer cohort and a representative set of fleet vehicles. Enable the customer app, station console, fleet console and operations console together so the full transaction can be observed.

Keep eligibility narrow at the start. Expand categories only after product data and evidence quality are proven.

## Readiness gates

The pilot should not begin until the following are owned and verified:

- legal position for the active rule configuration
- approved provider and point-of-sale test interfaces
- product classification and station master data
- user roles and assigned resources
- refund, reversal and settlement processes
- incident escalation and fallback operation
- privacy notices and retention periods
- support coverage and training
- backup, recovery and pilot-stop procedures

## Measures

### Customer and station

- completed payments as a share of initiated requests
- median time from QR creation to final station status
- abandonment and staff-assisted completion
- repeat use
- support contacts per thousand attempts

### Commercial

- eligible non-fuel value per participating visit
- repeat visit frequency
- active customers and fleet vehicles

### Fleet

- in-policy approval rate
- controlled declines by rule and reason
- false-positive decline review
- report and export accuracy

### Operations and control

- settlement reconciliation rate
- unresolved exceptions by age and owner
- provider and station availability
- complete decision evidence for material events
- zero promotional value earned or redeemed against fuel

## Operating rhythm

- **Daily:** station readiness, provider health, payment exceptions and reconciliation.
- **Weekly:** adoption, basket behaviour, fleet results, support load and control review.
- **Midpoint:** decide whether to hold, narrow or expand the pilot.
- **Close:** produce the evidence pack, legal confirmation and rollout recommendation.

## Incident priorities

| Priority | Example | Required response |
| --- | --- | --- |
| P0 | financial loss, security compromise or promotional value applied to fuel | stop the affected flow, preserve evidence and escalate immediately |
| P1 | widespread payment failure or reconciliation break | fail safe, activate the fallback process and assign an incident owner |
| P2 | isolated site or integration degradation | isolate the issue, continue through the approved fallback and track recovery |
| P3 | cosmetic or low-impact defect | record, prioritize and schedule |

The system fails closed when a basket cannot be classified. Promotional value is not calculated until the data is resolved.

## Gate decision

The pilot closes with one of four decisions:

1. proceed to broader rollout
2. proceed with named conditions
3. repeat a narrower pilot after remediation
4. stop because the commercial, control or operational case is not proven

The recommendation should connect every conclusion to measured evidence, named ownership and unresolved risk.
