# PetPals Final Project Test Plan

## 1. Project Information
**Team:** Team 4  
**Project:** PetPals   
**Presentation Date:** May 7, 2026  

---

## 2. Actor & Use Case Mapping

### **Actor: Customer**
* **UC1: Account Registration** - Initialize a User and Customer profile.
* **UC2: Pet Profile Management** - Link specific pets to a Customer ID.
* **UC3: Booking Creation** - Initiate a service request with a Caretaker.

### **Actor: Caretaker**
* **UC4: Service Profile Setup** - Define specialized care attributes and availability.
* **UC5: Request Management** - View and manage incoming booking requests.

---

## 3. Demonstration Scenario (8-Minute Script)

### **Step 1: System Initialization**
* **Goal:** Prove database connectivity.
* **Action:** Launch the Spring Boot application and show the console log confirming connection to the **PostgreSQL (Neon)** instance.
* **Verification:** Open the database tool (or Bruno/Postman) to show empty or existing tables.

### **Step 2: User Inheritance Demo (Customer)**
* **Goal:** Demonstrate the `@PrimaryJoinColumn` logic between `User` and `Customer`.
* **Action:** Execute a POST request to create a new Customer.
* **Verification:** Show that a record was created in the `users` table AND the `customers` table with matching IDs.

### **Step 3: Object Relational Mapping (Pets)**
* **Goal:** Demonstrate the One-to-Many relationship between Customer and Pet.
* **Action:** Use the Customer ID from Step 2 to add a Pet named "Ace".
* **Verification:** Perform a GET request to verify the Pet is correctly nested within the Customer object.

### **Step 4: Caretaker Logic**
* **Goal:** Show Caretaker-specific data retrieval.
* **Action:** Retrieve a list of all Caretakers.
* **Verification:** Demonstrate that the system correctly pulls unique Caretaker fields (e.g., specific skills) that are not present in the standard Customer profile.

### **Step 5: End-to-End Booking**
* **Goal:** Demonstrate data persistence across all entities.
* **Action:** Create a `Booking` object linking the Customer, the Pet, and the Caretaker.
* **Verification:** Show the final state of the `bookings` table.

---

## 4. Technical Validation Checklist
- [x] **Joined Inheritance:** Managed via `@Inheritance(strategy = InheritanceType.JOINED)`.
- [x] **Data Persistence:** Verified via Neon Cloud PostgreSQL.
- [x] **Boilerplate Efficiency:** Implemented via Project Lombok (`@Data`, `@NoArgsConstructor`).
- [x] **API Standards:** RESTful endpoints returning appropriate JSON responses.