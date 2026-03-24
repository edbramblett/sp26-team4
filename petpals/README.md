# PetPals Backend API - Jalen Higgins

## UML Class Diagram
Located in the root `/docs` folder as `Enity UML.png`.

## Use Case Mappings & Endpoints
The following endpoints implement the CRUD operations for the Caretaker actor:

| Actor | Use Case | Endpoint | HTTP Method |
| :--- | :--- | :--- | :--- |
| Caretaker | Create Profile | `/api/caretakers` | POST |
| Caretaker | View Profile | `/api/caretakers/{id}` | GET |
| Caretaker | Update Profile | `/api/caretakers/{id}` | PUT |
| Caretaker | Delete Profile | `/api/caretakers/{id}` | DELETE |
| Caretaker | View All Caretakers| `/api/caretakers` | GET |

## Data Persistence
- **Database:** Neon Postgres (Cloud)
- **Tables:** `users`, `caretakers` (JPA/Hibernate)
