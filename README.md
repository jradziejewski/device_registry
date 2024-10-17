# Device Registry - Solution

## Project Overview

This Ruby on Rails application is my implementation of a system to track devices assigned to users within an organization. It was developed as part of a job application task.

## Features Implemented

- User can assign a device to themselves
- User can return a device they have assigned
- Business logic enforcing assignment and return rules

## Technical Specifications

- Ruby version: 3.2.3
- Rails version: `~> 7.1.3`, `>= 7.1.3.4`
- Database: SQLite

## Setup Instructions

1. Clone this repository:
   ```
   git clone https://github.com/jradziejewski/device_registry.git
   cd device_registry
   ```

2. Install dependencies:
   ```
   bundle install
   ```

3. Set up the database:
   ```
   rails db:create db:migrate
   ```

## Running Tests

To run the full test suite:

```
bundle exec rspec spec
```

## Implementation Details

### Models
- `User`: Represents a user who can be assigned devices
- `Device`: Represents a device that can be assigned to a user
- `DeviceHistory`: Used to track if an user was already assigned to the device in the past

### Key Services
- `AssignDeviceToUser`: Handles the logic for assigning a device to a user
- `ReturnDeviceFromUser`: Handles the logic for returning a device from a user

### Business Rules Implemented
1. Users can only assign devices to themselves.
2. Users cannot assign devices already assigned to another user.
3. Only the user who assigned a device can return it.
4. Users cannot re-assign a device they have previously returned.

## Development Approach

- Test-Driven Development (TDD) was used throughout the implementation.
- Commits were made granularly with meaningful messages to document the development process.

## Feedback and Contact

If you have any questions or need further clarification about my implementation, please feel free to contact me at jradziejewski01@gmail.com

Thank you for reviewing my solution!
