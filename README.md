# Blog App

A simple and elegant Blog App built with the Flutter framework using Dart. This app allows users to log in with Google or Apple sign-in and provides a seamless experience for reading and managing blog posts. It uses Supabase (PostgreSQL) as a backend to store user and blog data securely. The app includes a smooth UI design with features such as user authentication, blog listing, and the ability to mark blogs as favorites. Future enhancements will include additional features found in popular blog or article-related applications.

## Table of Contents
- [Features](#features)
- [Screenshots](#screenshots)
- [Installation](#installation)
- [Technologies Used](#technologies-used)
- [Future Enhancements](#future-enhancements)
- [Contributing](#contributing)
- [License](#license)

---

## Features
- **User Authentication**: Users can sign in using Google or Apple sign-in, making it easy and secure.
- **Blog Listing**: Displays a list of blog posts with a smooth, user-friendly UI.
- **Supabase Integration**: Utilizes Supabase with PostgreSQL to store user and blog data, offering reliable and scalable storage.
- **Favorites**: Users can mark their favorite blogs and view them in a dedicated section.
- **Responsive Design**: Optimized for both Android and iOS with native feel and design elements.

## Screenshots
*Add screenshots here once available*

## Installation

### Prerequisites
- Flutter SDK (version 3.0.0 or higher recommended)
- Supabase account
- Firebase Console for Google Sign-In setup
- Apple Developer Account for Apple Sign-In setup (for iOS)

### Steps
1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/blog-app.git
   cd blog-app
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Set up Supabase**:
   - Create a project in [Supabase](https://supabase.io).
   - Create a `users` table with columns such as `id`, `name`, `email`, `profile_image`, and `created_at`.
   - Create a `blogs` table with columns like `id`, `title`, `content`, `author_id`, `created_at`, and other relevant fields.
   - Add Row Level Security (RLS) policies if needed, and enable public access for testing purposes (not recommended for production).

4. **Configure Firebase for Google Sign-In**:
   - Go to the [Firebase Console](https://console.firebase.google.com/), create a new project, and enable Google Sign-In under Authentication.
   - Download the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) files and add them to your project.

5. **Configure Apple Sign-In (for iOS)**:
   - Set up Sign In with Apple in the [Apple Developer Portal](https://developer.apple.com).
   - Configure your app in Xcode to support Apple Sign-In.

6. **Run the app**:
   ```bash
   flutter run
   ```

## Technologies Used
- **Flutter**: Cross-platform mobile development framework by Google.
- **Dart**: The programming language used with Flutter.
- **Supabase**: Open-source Firebase alternative for backend, with PostgreSQL database.
- **Google Sign-In**: Secure and easy authentication using Google.
- **Apple Sign-In**: Seamless login option for iOS users.

## Future Enhancements
- **Enhanced Search**: Allow users to search for blogs by keywords or tags.
- **Categories and Tags**: Organize blogs into categories or tags for easier navigation.
- **Comments Section**: Enable users to leave comments on blogs.
- **Share Blogs**: Allow users to share blogs with others through social media or messaging apps.
- **Notifications**: Send notifications to users for new blog posts or updates.
- **User Profiles**: Enable users to view and edit their profile details.

## Contributing
Contributions are welcome! If you'd like to contribute to this project, please follow these steps:
1. Fork the repository.
2. Create a branch with a descriptive name (e.g., `feature-add-comments`).
3. Make your changes and commit them.
4. Push your changes to your forked repository.
5. Submit a pull request, and describe the changes in detail.

## License
This project is open-source and available under the MIT License. See the [LICENSE](LICENSE) file for more information.

---

Happy coding! Enjoy using and building upon this Blog App. If you have any questions or run into issues, feel free to open an issue in the repository.
