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
**Endpoint:** `POST /caretaker`
**Use Case:** Register as Caretaker
**Description:** Create a new caretaker account.

```http
POST /caretaker
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
**Endpoint:** `GET /caretakers`
**Use Case:** Browse providers
**Description:** Retrieve all caretaker accounts.

```http
GET /caretaker
```

**Status Code:** `200 OK`

---

#### Get Caretaker by ID
**Endpoint:** `GET /caretakers/{id}`
**Use Case:** caretaker profile view
**Description:** Retrieve specific caretaker by ID.

```http
GET /caretakers/2
```

**Status Code:** `200 OK` or `404 Not Found`

---

#### Get Caretaker by Email
**Endpoint:** `GET /caretakers/email/{email}`
**Use Case:** Caretaker lookup
**Description:** Retrieve caretaker by email address.

```http
GET /caretakers/email/{email}
```

**Status Code:** `200 OK` or `404 Not Found`

---

#### Get Caretaker by Services Provided
**Endpoint:** `GET /caretakers/search?service={service}`
**Use Case:** Caretaker lookup
**Description:** Retrieve caretaker by services provided.

```http
GET /caretakers/search?service={service}
```

**Status Code:** `200 OK` or `404 Not Found`

---

#### Update Caretaker
**Endpoint:** `PUT /caretaker/{id}`
**Use Case:** US-PROV-005 (Update Profile)
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

#### Delete Farmer
**Endpoint:** `DELETE /caretaker/{id}`
**Use Case:** Account deletion
**Description:** Delete caretaker account.

```http
DELETE /caretaker/2
```

**Status Code:** `204 No Content` or `404 Not Found`

---

### Booking

#### Create Booking
**Endpoint:** `POST /caretaker`
**Use Case:** US-CUST-003 (Customer creates a booking)
**Description:** Create a new booking

```http
POST /booking
Content-Type: application/json

{
  "serviceType": "Dog Walking",
  "date": "2026-03-28T14:30:00",
  "customer_id": 5,
  "petIds": [1, 3]
}

```

**Response:**
```json
{
  "bookingId": 12,
  "serviceType": "Dog Walking",
  "date": "2026-03-28T14:30:00",
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
  "pets": [],
  "caretaker": null,
  "incidentReport": null
}
```

**Status Code:** `201 Created`

---