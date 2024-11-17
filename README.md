# Spotify Clone with Flutter

This is a simple Spotify clone application built using Flutter. The app mimics the basic features of the Spotify platform, allowing users to explore music, play tracks, and browse through playlists. The music files are stored and managed using Firebase.

## Features

- **User Interface**: A clean and responsive design similar to the Spotify app.
- **Search**: Search for songs, albums, and playlists.
- **Music Player**: Play, pause, and skip tracks.
- **Navigation**: Navigate between different sections like Home, Search, Library, and Now Playing.
- **Audio Streaming**: Integrates with Firebase Storage to stream music files.
- **User Authentication**: Users can sign in via Firebase Authentication (optional).
- **Firestore Database**: Store and retrieve music data (e.g., track details, album information) from Firestore.

## Tech Stack

- **Flutter**: Framework for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **Dart**: Programming language used with Flutter.
- **Firebase**: Cloud platform for storing music files (Firebase Storage), managing user authentication (Firebase Auth), and storing metadata (Firestore).
- **Provider**: State management solution for Flutter.

## Setup

To get started with the project, follow these steps:

### Prerequisites

- Install Flutter SDK: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
- Set up an editor: [Editor Setup Guide](https://flutter.dev/docs/get-started/editor)
- Install Firebase CLI: [Firebase CLI Setup](https://firebase.google.com/docs/cli)
- Install dependencies: `flutter pub get`

### Firebase Configuration

1. Set up a Firebase project:
   - Go to [Firebase Console](https://console.firebase.google.com/).
   - Create a new project and configure Firebase services such as Firebase Authentication, Firebase Firestore, and Firebase Storage.
   - Add your Android and/or iOS apps to Firebase (follow the instructions on Firebase Console).

2. Add Firebase to your Flutter app:
   - Follow the steps in the [FlutterFire documentation](https://firebase.flutter.dev/docs/overview) to configure Firebase with Flutter.

...
### Screenshots

![Screenshot_profile](https://github.com/user-attachments/assets/2e275827-b3fc-44cb-97cb-87b397d92f9f)
![Screenshot_getstated](https://github.com/user-attachments/assets/a264139b-d349-4217-a876-1e99414fa568)
