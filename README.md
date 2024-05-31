# Threads Clone - Flutter App

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

![Screen Recording May 31](https://github.com/theeeep/thread_clone/assets/81185000/26998cb2-d9e8-4c41-8a54-1f2146480513)




![Screenshot 2024-05-31 at 2 58 14 PM](https://github.com/theeeep/thread_clone/assets/81185000/6c48aac6-dc3a-4c2e-aa67-6cceeb1d135b) 
![Screenshot 2024-05-31 at 2 58 23 PM](https://github.com/theeeep/thread_clone/assets/81185000/1a097a2f-e576-498a-a87b-e4d4da4d596e)


![Screenshot 2024-05-31 at 3 01 36 PM](https://github.com/theeeep/thread_clone/assets/81185000/776b9f44-3b29-4bd5-b4f5-d37842b4b02a)
![Screenshot 2024-05-31 at 3 01 31 PM](https://github.com/theeeep/thread_clone/assets/81185000/71bdd482-07fe-4a57-966a-c28604bb4a3b)


![Screenshot 2024-05-31 at 3 02 40 PM](https://github.com/theeeep/thread_clone/assets/81185000/13f076cc-ef5c-4e68-a704-cc022c7a47e8)
![Screenshot 2024-05-31 at 3 02 53 PM](https://github.com/theeeep/thread_clone/assets/81185000/e69af6c1-ad73-4407-b41c-7a0e1306d891)

## Project Structure
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


 


## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.



