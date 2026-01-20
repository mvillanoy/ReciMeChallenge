# ReciMe Coding Challenge

Simple application to browse and search a collection of recipes

## Setup

1. Clone the repository 
2. Open `RecimeChallenge.xcodeproj`
3. Build and run


## Architecture
The project follows MVVM + Clean Architecture principles to clearly separate responsibilities and keep the codebase scalable.

#### Data
- **Network**
  - Intended for API calls.
  - For the purpose of this challenge, data is loaded from a local JSON file.
- **Repositories**
  - Act as an abstraction over data sources.

#### Domain
- **Model**
  - Core entities representing recipes and related data.
- **Use Case**
  - Encapsulate business rules and data manipulation logic.

#### Presentation
- Organized by feature:
  - **Home**
    - Recipe listing
  - **Detail**
    - Recipe details
  - **Search**
    - Search and filtering

- Each feature contains:
  - `components/` — reusable UI components
  - `view` — SwiftUI views
  - `view model` — state and presentation logic

## Design

### Architecture Decisions
- Chose MVVM + Clean Architecture to separate UI, business logic, and data
- Used repositories to abstract data sources and allow future API integration as well as any persistent storage (CoreData or SQLite)

### UI/UX
Loose inpiration to this: https://www.behance.net/gallery/181908067/Cooking-Recipe-App-UI-Design
- Clean and minimal color palette
- Emphasis on large recipe images
- Simple and readable layouts
- Filters presented as pills with bottom sheets for selection

## Assumptions and tradeoffs

### Assumptions:
- Small dataset
- Included recipe scaling and unit conversion 
- Serving size filter is not a range
    
### Tradeoffs:
- Filtering done locally but should ideally be handled by API calls
- `flatmap` to fetch all dietary preferenes and ingredients for filtering
- Compatible but not optimized for tablets
- Dependency Injection is not implemented due to small feature set

## Limitations:
- Filtering logic not optimized for large datasets
- Limited error handling (skeleton loading and no user-facing error notifications)
- No persistent storage

## Screen Recording
<img width="603" height="1311" alt="IMG_6310" src="https://github.com/user-attachments/assets/6200fac4-c8ee-45d3-8241-fa785133c5fa" />
<img width="603" height="1311" alt="IMG_6309" src="https://github.com/user-attachments/assets/f00d7c70-a39f-4590-820b-e5f6f29a0ee4" />
<img width="603" height="1311" alt="IMG_6311" src="https://github.com/user-attachments/assets/8f1b2e5e-52fb-46b2-8dee-870b935b36e1" />


[Video Recording](https://drive.google.com/file/d/1Nkq7xHWBBdiQvN3aC5d_t69yPyM2bcJk/view?usp=sharing)
