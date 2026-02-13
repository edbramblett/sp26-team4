
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
- **US‑CUST‑001 — Search for Service Providers**  
  _Story:_ As a customer, I want to search for pet walkers and sitters, so that I can find the right professional for my pet's specific needs.  
  _Acceptance:_
  ```gherkin
  Scenario: Customer searches by service type
    Given I am on the "Search" page
    When I select "Pet Sitter" from the service dropdown and enter my location
    Then the system displays a list of available providers who match those criteria
  ```

- **US‑CUST‑002 — Manage Pet Profiles**  
  _Story:_ As a customer, I want to create and update a profile for my pet, so that caretakers have all the necessary care instructions before a booking.  
  _Acceptance:_
  ```gherkin
  Scenario: Adding a new pet to the account
    Given I am logged into my customer account
    When I navigate to "My Pets" and enter my pet's name, breed, and medical notes
    Then the pet profile is saved and attached to my account for future bookings
  ```

- **US‑CUST‑003 — Book a Service**  
  _Story:_ As a customer, I want to request a booking with a specific caretaker, so that I can secure pet care for a specific date and time. 
  _Acceptance:_
  ```gherkin
  Scenario: Submitting a booking request
  Given I am viewing a caretaker's profile [cite: 14]
  When I select an available time slot and click "Request Booking" 
  Then the booking status changes to "Pending" and the caretaker is notified
  ```

  - **US‑CUST‑004 — Leave a Provider Review Story**  
  _Story:_ As a customer, I want to leave a review after a service is completed, so that I can inform other pet owners about my experience. 
  _Acceptance:_
  ```gherkin
  Scenario: Rating a completed service
  Given a booking has been marked as "Completed"
  When I submit a star rating and a text comment on the caretaker's page 
  Then the review is published to the caretaker's public profile
  ```

### 2.2 Provider Stories
- **US‑PROV‑001 — Accept/decline Booking**  
  _Story:_ As a caretaker, I want accept or decline bookings so that I can manage my own work schedule

  _Acceptance:_
  ```gherkin
  Scenario: Caretaker accepts or declines a booking
    Given: A booking is made through the app and made visible to the caretaker
    When: The caretake makes their choice to accept or decline
    Then: The booking status is updated, and the customer is notified of the decision
  ```

- **US‑PROV‑002 — Create incident reports**  
  _Story:_ As a caretaker, I want to create incident reports when necessary

  _Acceptance:_
  ```gherkin
  Scenario: Caretaker creates an incident report
    Given: An incident occurs, and the caretaker feels that it needs to be document
    When: The caretaker uses the app to create a report of what happened
    Then: The report is saves to the database and the customer is notified of the report
  ```

- **US‑PROV‑003 — Respond to reviews**  
  _Story:_ As a caretaker, I want to respond ro reviews so that public information can have both the previous custoemr and caretaker point of views

  _Acceptance:_
  ```gherkin
  Scenario: Caretake responds to review
    Given: A review is left for a caretaker
    When: The caretaker can respond to the review
    Then: The response is posted and is viewable to the public
  ```

- **US‑PROV‑004— View Booking Details**  
  _Story:_ As a caretaker, I want to be able to see the infomation of a booking I've accepted so I can prepare for it.

  _Acceptance:_
  ```gherkin
  Scenario: Caretake views accepted booking
    Given: The caretake has at least one pending accepted booking
    When: The caretaker opens the booking page
    Then: The app displays customer information, pet details, services requests, etc.
  ```

- **US‑PROV‑005— Manage Availability**  
  _Story:_ As a caretaker, I want to be able set my own availability so that I can block time out automatically from booking requests

  _Acceptance:_
  ```gherkin
  Scenario: Caretake adds/changes their availability
    Given: The caretaker is logged into their account
    When: The caretaker edits days/times they are available
    Then: The app updates this information, and presents it to customers when viewing this caretaker
  ```

---

## 3. Non‑Functional Requirements (make them measurable)
- **Performance:** The app should be able to handle several hundred requests without slowing down, and should send notifications for bookings, incidents, reviews, etc. within 5 seconds. 
- **Availability/Reliability:** The system will remain operational 99% of the time, with regular maintaince once a month for 1 hour.
- **Security/Privacy:** All data will be encrypted, passwords stored in a hashing, any access to personal information/incident reports are viewable by authenticated users. Automatic logout after 30 minutes. 
- **Usability:** New accounts will be easy to create, less than 3 minutes. Service search and booking should take less than 5 minutes, with less than 10 steps.

---

## 4. Assumptions, Constraints, and Policies
**User Authentication:** All users must create an account and be authenticated to view specific booking details or pet profiles.

**Data Privacy:** Incident reports and pet medical notes are private and only viewable by the involved Customer and Caretaker.

**Scope Constraint:** The MVP version of PetPals will not handle financial transactions; users are responsible for arranging payment outside of the app.

**Review Policy:** Customers can only leave reviews for caretakers they have successfully booked and completed a service with.

**Notification Policy:** The system assumes users have enabled in-app notifications to receive updates on booking statuses and incident reports

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
