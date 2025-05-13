# Mobile Sales Mini App

## Important Notes

### Technologies Used

- Flutter (using Riverpod for state management)
- GoRouter (for routing)
- Hive (for local storage)
- Custom UI widgets

### Key Features

- Local Login using Hive users (`usersBox`)
- Role and permission-based route guarding (`authProvider.hasPermission`)
- Dynamic greeting on `HomeScreen` based on time of day
- Notification system with badge and Notification Center
- Inventory management, Sales Orders, and Customers modules
- Session auto-logout after inactivity (`AuthNotifier` session timer)
- State management using Riverpod best practices (`StateNotifierProvider`)

### Default Credentials (Development Mode)

| Username | Password |
| -------- | -------- |
| admin    | admin123 |

> Note: Ensure you run the seeding logic during app startup if users are not present in the `usersBox`.

### Permissions (used in the app)
