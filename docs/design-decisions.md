# Design decisions

## 1. Classify the basket before applying value

**Decision:** split every basket at line level before evaluating promotional value.

**Reason:** a total-only transaction cannot prove that fuel received no benefit. Line classification makes the decision measurable and reviewable.

**Consequence:** unknown items fail closed for promotional purposes. Product master data becomes an operational responsibility, not an afterthought.

## 2. Treat QR as a request, not as money

**Decision:** the QR code points to a short-lived server-side payment request.

**Reason:** the code should not carry a reusable balance, an authorization outcome or sensitive payment details.

**Consequence:** the station can expire or cancel a request, the customer can review the current basket, and replay attempts can be rejected.

## 3. Give the station a final state

**Decision:** the station releases goods only after a clear approved outcome.

**Reason:** a customer screen alone is not proof that the station order settled correctly.

**Consequence:** transaction orchestration maps provider outcomes to one monotonic station state and records ambiguous cases as owned exceptions.

## 4. Evaluate fleet rules before authorization

**Decision:** vehicle, driver, value, category, location and time conditions run before the payment request reaches the provider.

**Reason:** a report after the fact cannot prevent out-of-policy spend.

**Consequence:** every decline needs a stable reason code, a visible explanation and an evidence event.

## 5. Keep providers replaceable

**Decision:** point-of-sale, payment, identity and messaging integrations sit behind adapters.

**Reason:** discovery should not lock the core product to an interface that has not yet been selected or verified.

**Consequence:** the prototype can use deterministic simulators while preserving the same application flow intended for approved providers.

## 6. Separate the ledger from operational evidence

**Decision:** use an append-only financial ledger for money movement and a separate event stream for actions and decisions.

**Reason:** finance needs balanced entries. Support and risk need richer context. One record should not be forced to serve both jobs badly.

**Consequence:** reconciliation can rely on stable financial entries while support can inspect actor, scope, rule and workflow context.

## 7. Cache only the safe shell

**Decision:** the installable app may cache static assets, never private pages or API responses.

**Reason:** an offline shell helps launch speed, but stale account or transaction data creates avoidable risk.

**Consequence:** authenticated screens require a live, authorized response. Degraded states must be honest and actionable.

## 8. Make the pilot an evidence system

**Decision:** define success, failure and operational ownership before the pilot starts.

**Reason:** a lively demo can hide poor reconciliation, support burden or control failures.

**Consequence:** adoption, completion, exception, reconciliation and policy metrics sit beside customer feedback in the gate decision.
