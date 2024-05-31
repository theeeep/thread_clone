# Threads Clone App

## Overview

This project is a clone of the popular Threads app, built using Flutter for the frontend, Supabase for the backend, and GetX for state management. The app aims to replicate the core functionalities of the original Threads app, providing a seamless user experience.

## Features

- **User Authentication**: Sign up, log in, and log out functionalities.
- **Post Creation**: Users can create and publish new posts.
- **Post Interaction**: Like, comment, and share posts.
- **Profile Management**: Users can view and edit their profiles.

## Technologies Used

- **Flutter**: For building the cross-platform mobile application.
- **Supabase**: For the backend services, including authentication, database, and real-time subscriptions.
- **GetX**: For state management, ensuring a smooth and reactive user experience.

## Getting Started

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Supabase Account: [Sign up for Supabase](https://supabase.io/)
- A code editor like VS Code or Android Studio.

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/theeeep/thread_clone.git
   cd thread_clone

   ```

2. **Install dependencies:**

   ```bash
   flutter pub get

   ```

3. **Configure Supabase:**

   - Create a new project in Supabase.
   - Copy your Supabase URL and Anon Key.
   - Create a .env file in the root of your project and add the following:

     ```bash
     SUPABASE_URL=your-supabase-url
     SUPABASE_ANON_KEY=your-supabase-anon-key

     ```

4. **Run the app:**

   ```bash
       flutter run


   ```

### Preview

```
.
├── README.md
├── analysis_options.yaml
├── android
├── assets
│   ├── icons
│   └── images
├── build
├── lib
│   ├── core
│   ├── features
│   ├── routes
│   └── main.dart
├── pubspec.lock
├── pubspec.yaml
├── test
│   └── widget_test.dart
└── thread_clone.iml
```

## Project Structure

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
