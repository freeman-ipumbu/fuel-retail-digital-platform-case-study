# Architecture

## Position

The platform coordinates experiences, rules, payment state and evidence. It does not take on regulated responsibilities that belong to an approved financial or identity provider.

That boundary keeps the product useful during discovery without pretending that a prototype is ready to hold customer funds or operate an entire retail network.

## Context

Four user groups meet at a shared transaction core:

- customers review and approve payment requests
- station teams create requests and wait for a final result
- fleet teams define spend rules and investigate declines
- operations teams monitor health, reconcile money movement and review evidence

External systems remain behind replaceable adapters. The platform does not force the customer experience to depend on one point-of-sale vendor, one acquirer or one identity provider.

## Service boundaries

### Identity and authorization

Verifies the actor, applies least privilege and restricts records and actions by role and assigned resource. High-impact changes create an operational event.

### Transaction orchestration

Owns the payment-request lifecycle. It accepts idempotent commands, enforces monotonic state changes and maps provider outcomes to station orders.

### Product classification

Maps each line to fuel, eligible non-fuel, restricted or unknown. Unknown items receive no promotional value until an authorized reviewer resolves them.

### Promotional rules

Evaluates only eligible non-fuel lines. The result stores the input split, rule version, decision and value applied.

### Fleet policy

Evaluates company, driver, vehicle, amount, frequency, category, station and time conditions before authorization.

### Ledger and reconciliation

Records money movement as append-only entries. Reconciliation connects orders, authorization, capture, refund, provider fees and settlement outcomes.

### Operational evidence

Records material actions and automated decisions with time, actor, resource and rule context. It is a support and control tool, not a substitute for the financial ledger.

### Integration adapters

Normalize point-of-sale baskets, provider outcomes, identity assertions and outbound messages. Provider-specific behaviour stops at this boundary.

## Data principles

1. Store monetary values in integer minor units.
2. Keep the fuel and non-fuel split on every relevant transaction.
3. Version rules and keep the version used for each decision.
4. Treat balance as a ledger result, not a freely editable field.
5. Make payment state transitions monotonic.
6. Keep external references and idempotency keys unique.
7. Preserve events needed to explain an approval, decline, reversal or adjustment.

## Reliability controls

- short-lived, single-use QR payment requests
- idempotency on payment and reversal commands
- replay rejection
- signed provider callbacks
- an outbox path for durable state and event delivery
- circuit breakers and provider health monitoring
- explicit exception ownership during reconciliation
- safe degradation when point-of-sale or network connectivity is unavailable

## Security posture

- least privilege by role and assigned resource
- server-side authorization on every read and write
- no private account pages or API data in the service-worker cache
- no raw card or bank details stored by the platform
- strict input limits and same-origin command checks
- immutable evidence for high-impact actions
- two-person approval for sensitive rule changes in production
- independent security and recovery testing before live rollout

## Deployment progression

The path to production should be staged:

1. local development with simulated providers
2. shared integration environment
3. provider and point-of-sale test environment
4. controlled pilot environment
5. broader production only after the gate decision

Each stage should have separate data, keys, logging and recovery procedures.
