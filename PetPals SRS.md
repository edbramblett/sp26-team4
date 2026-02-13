
# Requirements – Starter Template

**Project Name:** PetPals \
**Team:** Evan Bramblett (Provider), Jalen Higgins (Customer) \
**Course:** CSC 340\
**Version:** 1.0\
**Date:** 2026-02-13

---

## 1. Overview
**Vision.** The app will be a place for customers to find reliable pet care, whether thats for simply hiring a walker or looking for pet sitting.

**Glossary** Terms used in the project
- **Caretaker:** Hired professional who is hired for their services.
- **Customer:** Any person using the app to hire caretakers.
- **Booking:** The way customers hire caretakers, sets a time and date for the services to be provided.
- **Incident:** Any situation or problem that arrises during a booking, that a caretaker feels should be documented.
- **Review:** A message left after a booking, viewable to any other customer to see how other customers rate certain caretakers.

**Primary Users / Roles.**
- **Customer** — Find services needed for their pets.
- **Caretakers** — Provide professional and reliable services to customers who hire them.

**Scope (this semester).**
- Create personal and pet accounts
- Search and make bookings
- Leave reviews and respond to reviews
- Create incident reports
- Accept or decline bookings

**Out of scope (deferred).**
- Payment processing
- GPS walking route tracker
- Caretaker to customer chat room

---

## 2. Functional Requirements (User Stories)
Write each story as: **As a `<role>`, I want `<capability>`, so that `<benefit>`.** Each story includes at least one **Given/When/Then** scenario.

### 2.1 Customer Stories
- **US‑CUST‑001 — <short title>**  
  _Story:_ As a customer, I want … so that …  
  _Acceptance:_
  ```gherkin
  Scenario: <happy path>
    Given <preconditions>
    When  <action>
    Then  <observable outcome>
  ```

- **US‑CUST‑002 — <short title>**  
  _Story:_ As a customer, I want … so that …  
  _Acceptance:_
  ```gherkin
  Scenario: <happy path>
    Given <preconditions>
    When  <action>
    Then  <observable outcome>
  ```

### 2.2 Provider Stories
- **US‑PROV‑001 — <short title>**  
  _Story:_ As a caretaker, I want accpet or decline bookings so that I can manage my own work schedule

  _Acceptance:_
  ```gherkin
  Scenario: Caretaker accepts or declines a booking
    Given: A booking is made through the app and made visible to the caretaker
    When: The caretake makes their choice to accept or decline
    Then: The booking status is updated, and the customer is notified of the decision
  ```

- **US‑PROV‑002 — <short title>**  
  _Story:_ As a caretaker, I want to create incident reports so that customers are aware of incidents

  _Acceptance:_
  ```gherkin
  Scenario: Caretaker creates an incident report
    Given: An incident occurs, and the caretaker feels that it needs to be document
    When: The caretaker uses the app to create a report of what happened
    Then: The report is saves to the database and the customer is notified of the report
  ```

---

## 3. Non‑Functional Requirements (make them measurable)
- **Performance:** The app should be able to handle several hundred requests without slowing down, and should send notifications for bookings, incidents, reviews, etc. within 5 seconds. 
- **Availability/Reliability:** The system will remain operational 99% of the time, with regular maintaince once a month for 1 hour.
- **Security/Privacy:** All data will be encrypted, passwords stored in a hashing, any access to personal information/incident reports are viewable by authenticated users. Automatic logout after 30 minutes. 
- **Usability:** New accounts will be easy to create, less than 3 minutes. Service search and booking should take less than 5 minutes, with less than 10 steps.

---

## 4. Assumptions, Constraints, and Policies
- list any rules, policies, assumptions, etc.

---

## 5. Milestones (course‑aligned)
- **M2 Requirements** — this file + stories opened as issues. 
- **M3 High‑fidelity prototype** — core customer/provider flows fully interactive. 
- **M4 Design** — architecture, schema, API outline. 
- **M5 Backend API** — key endpoints + tests. 
- **M6 Increment** — ≥2 use cases end‑to‑end. 
- **M7 Final** — complete system & documentation. 

---

## 6. Change Management
- Stories are living artifacts; changes are tracked via repository issues and linked pull requests.  
- Major changes should update this SRS.
