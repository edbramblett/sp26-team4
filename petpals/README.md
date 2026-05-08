# PetPals Backend API - Jalen Higgins

## UML Class Diagram
Located in the root `/docs` folder as `Enity UML.png`.

## 2. User Roles
The API supports three primary user roles:

| Role | Description | Primary Responsibilities |
|------|-------------|-------------------------|
| **CUSTOMER** | | |
| **CARETAKER** | Provider of pet related services | Accept/decline bookings, Create/delete incident reports, reply to reviews |

### Caretaker/Provider Management

#### Create Caretaker
**Endpoint:** `POST /caretakers`\
**Use Case:** Register as Caretaker\
**Description:** Create a new caretaker account.

```http
POST /caretakers
Content-Type: application/json

{
  "email": "test@example.com",
  "firstName": "John",
  "lastName": "Doe",
  "passwordHash": "password",
  "phoneNumber": "(123)-456-7890",
  "role": "CARETAKER",
  "servicesProvided": "Pet sitting, dog walking"
}

```

**Response:**
```json
{
	"servicesProvided": "Pet sitting, dog walking",
	"createdAt": "2026-03-24T02:41:18.1484874",
	"email": "test@example.com",
	"firstName": "John",
	"lastName": "Doe",
	"passwordHash": "password",
	"phoneNumber": "(123)-456-7890",
	"role": "CARETAKER",
	"updatedAt": "2026-03-23T16:41:18.1484874",
	"userId": 3
}
```

**Status Code:** `201 Created`

---

#### Get All Caretakers
**Endpoint:** `GET /caretakers`\
**Use Case:** Browse providers\
**Description:** Retrieve all caretaker accounts.

```http
GET /caretakers
```

**Status Code:** `200 OK`

---

#### Get Caretaker by ID
**Endpoint:** `GET /caretakers/{id}`\
**Use Case:** caretaker profile view\
**Description:** Retrieve specific caretaker by ID.

```http
GET /caretakers/2
```

**Status Code:** `200 OK` or `404 Not Found`

---

#### Get Caretaker by Email
**Endpoint:** `GET /caretakers/email/{email}`\
**Use Case:** Caretaker lookup\
**Description:** Retrieve caretaker by email address.

```http
GET /caretakers/email/test@example.com
```

**Status Code:** `200 OK` or `404 Not Found`

---

#### Get Caretaker by Services Provided
**Endpoint:** `GET /caretakers/search?service={service}`\
**Use Case:** Caretaker lookup\
**Description:** Retrieve caretaker by services provided.

```http
GET /caretakers/search?service=Dog Walking
```

**Status Code:** `200 OK` or `404 Not Found`

---

#### Update Caretaker
**Endpoint:** `PUT /caretaker/{id}`\
**Use Case:** US-PROV-005 (Update Profile)\
**Description:** Update caretaker profile information.

```http
PUT /caretaker/2
Content-Type: application/json

{
  "email": "test@example.com",
  "firstName": "John",
  "lastName": "Doe",
  "passwordHash": "password",
  "phoneNumber": "(123)-456-7890",
  "role": "CARETAKER",
  "servicesProvided": "Pet sitting, dog walking"
}

```

**Response:** Updated caretaker object

**Status Code:** `200 OK` or `404 Not Found`

---

#### Delete Caretaker
**Endpoint:** `DELETE /caretaker/{id}`\
**Use Case:** Account deletion\
**Description:** Delete caretaker account.

```http
DELETE /caretaker/2
```

**Status Code:** `204 No Content` or `404 Not Found`

---

### Bookings

#### Create Booking
**Endpoint:** `POST /bookings`\
**Use Case:** US-CUST-003 (Customer creates a booking)\
**Description:** Create a new booking

```http
POST /bookings
Content-Type: application/json

{
  "serviceType": "Dog Walking",
  "date": "2026-03-28T14:30:00",
  "customer_id": 5,
  "caretaker_id": 2
}

```

**Response:**
```json
{
  "bookingId": 10,
  "serviceType": "Dog Walking",
  "date": "2026-03-28T14:30:00",
  "caretaker": {
    "userId": 2,
    "firstName": "Jane",
    "lastName": "Smith",
    "email": "jane@example.com"
  },
  "customer": {
    "userId": 5,
    "firstName": "John",
    "lastName": "Doe",
    "email": "john@example.com"
  },
  "status": "PENDING"
}
```

**Status Code:** `201 Created`

---

#### Get All Bookings
**Endpoint:** `GET /bookings`\
**Use Case:** Browse bookings\
**Description:** Retrieve all bookings.

```http
GET /bookings
```

**Status Code:** `200 OK`

---

#### Get Booking by ID
**Endpoint:** `GET /bookings/{id}`\
**Use Case:** View specific booking\
**Description:** Retrieve specific booking by ID.

```http
GET /bookings/2
```

**Status Code:** `200 OK` or `404 Not Found`

---

#### Update Booking
**Endpoint:** `PUT "/bookings/{bookingId}/{caretaker_id}"\
**Use Case:** US-PROV-001 (Accept/Decline Booking)\
**Description:** Update a booking to include a caretaker if accepted

```http
PUT /bookings/12/1
Content-Type: application/json

{
  "serviceType": "Dog Walking",
  "date": "2026-03-28T14:30:00",
  "customer_id": 5,
  "petIds": [1, 3]
  "
}
```

**Response:** Updated booking object

```json
{
	"bookingId": 1,
	"serviceType": "Dog Walking",
	"date": "2026-03-25T14:30:00",
	"caretaker": {
		"servicesProvided": "Pet sitting, dog walking",
		"createdAt": "2026-03-24T02:41:18.148487",
		"email": "test2@example.com",
		"firstName": "Jane",
		"lastName": "Doe",
		"passwordHash": "password",
		"phoneNumber": "(123)-456-7890",
		"role": "CARETAKER",
		"updatedAt": "2026-03-24T02:41:18.148487",
		"userId": 3
	},
    "customer": {
        "createdAt": "2026-03-24T02:41:18.1484874",
        "email": "test@example.com",
        "firstName": "John",
        "lastName": "Doe",
        "passwordHash": "password",
        "phoneNumber": "(123)-456-7890",
        "role": "CUSTOMER",
        "updatedAt": "2026-03-23T16:41:18.1484874",
        "userId": 5
    },
	"caretaker_id": 3,
	"customer_id": 5
    "incidentReportId": null
}
```

**Status Code:** `200 OK` or `404 Not Found`

---


#### Delete Booking
**Endpoint:** `DELETE /booking/{id}`\
**Use Case:** US-PROV-001 (Booking deletion)\
**Description:** Delete/decline booking.

```http
DELETE /booking/12
```

**Status Code:** `204 No Content` or `404 Not Found`

---

### Incident Reports

#### Create Incident Report
**Endpoint:** `POST /incident-reports/{caretake_id}/{bookingId}`\
**Use Case:** US-PROV-002 (Caretaker creates an indicent report)\
**Description:** Create a new incident report

```http
POST /incident-reports/3/2
Content-Type: application/json

{
  "description": "Dog became aggressive during the walk. No injuries, but behavior was concerning."
}


```

**Response:**
```json
{
	"reportId": 1,
	"description": "Dog became aggressive during the walk. No injuries, but behavior was concerning."
}
```

**Status Code:** `201 Created`

---

#### Get All Incident Reports
**Endpoint:** `GET /incident-reports`\
**Use Case:** Browse all incident reports\
**Description:** Retrieve all incident reports.

```http
GET /incident-reports
```


**Status Code:** `200 OK`


---

#### Get Incident Report ID
**Endpoint:** `GET /incident-reports/{id}`\
**Use Case:** Browse a specific incident report\
**Description:** Retrieve specific incident report ID.

```http
GET /incident-reports/2
```

**Status Code:** `200 OK` or `404 Not Found`

---

#### Get Incident Report by Caretaker ID
**Endpoint:** `GET /incident-reports/caretakers/{caretaker_id}`\
**Use Case:** Browse all incident reports from a specific caretaker\
**Description:** Retrieve specific incident reports by a caretaker ID.

```http
GET /incident-reports/caretakers/2
```

**Status Code:** `200 OK` or `404 Not Found`

---

#### Get Incident Report by Booking ID
**Endpoint:** `GET /incident-reports/bookings/{bookingId}`\
**Use Case:** Browse all incident reports from a specific booking\
**Description:** Retrieve specific incident reports by a booking ID.

```http
GET /incident-reports/bookings/3
```

**Status Code:** `200 OK` or `404 Not Found`

---

#### Delete Incident Report
**Endpoint:** `DELETE /incident-reports/{id}`\
**Use Case:** Incident report deletion\
**Description:** Delete incident report.

```http
DELETE /incident-reports/12
```

**Status Code:** `204 No Content` or `404 Not Found`

---

#### Respond to reviews
**Endpoint:** `Post /reviews/reply/{id}`\
**Use Case:** Reply to reviews from customers\
**Description:** Create review.


```http
POST /reviews/reply/1
Content-Type: application/json

{
  "reply": "Thank you for you're review"
}

```
**Response:**
```json
{
	"reviewId": 1,
	"comment": "Good gut"
	"caretaker-reply": "Thank you for you're review"
}
```
**Status Code:** `200 OK` or `404 Not Found`
```

### Customer Use Cases

| Use Case | Description | Related Endpoints |
|----------|-------------|-------------------|
| **US-CUST-001** | Search for Service Providers | `GET /caretakers/{id}`, `GET /caretakers/search?service={service}`, `GET /caretakers/email/{email}` |
| **US-CUST-002** | Create and manage Pet Profiles | |
| **US-CUST-003** | Book a Service | `POST /bookings`, `DEL /bookings/{id}` |
| **US-CUST-004** | Leave a Provider Review |  |
| **US-CUST-005** | Create and manage account | |

### Provider (Farmer) Use Cases

| Use Case | Description | Related Endpoints |
|----------|-------------|-------------------|
| **US-PROV-001** | Accept/Decline/Complete Booking | `PUT /bookings/{caretaker_id}/{bookingId}`, `DEL /bookings/{id}`|
| **US-PROV-002** | Create incident reports | `POST /incident-reports`, `PUT /incient-reports` |
| **US-PROV-003** | Respond to reviews | `POST /reviews/reply`|
| **US-PROV-004** | View Booking Details | `GET /bookings/{id}`, `Get /bookings`, `Get /bookings/{bookingId}/(caretaker_id}` |
| **US-PROV-005** | Create and manage account | `POST /caretakers`, `PUT /caretakers/{id}`, `DEL /caretakers{id}` |
