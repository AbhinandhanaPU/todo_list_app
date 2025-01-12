# **To-Do List App with Firebase Authentication and State Management using Provider**

## 📜 **Overview**
 This is a Flutter-based To-Do List app that leverages **Firebase Authentication** for secure user login and **Firebase Realtime Database** to store tasks. The app uses **Provider** for efficient state management and follows the **MVVM (Model-View-ViewModel)** architecture for maintainability and separation of concerns.

---

## 🛠 **Featues**

1. **User Authentication**
    - Secure login and signup using Firebase Authentication (Email/Password).

2. **Task Management**
    - **View tasks**: Display all tasks assigned to the current user.
    - **Add tasks**: Add new tasks with titles and completion status.
    - **Edit tasks**: Modify task titles and statuses.
    - **Mark tasks as completed**: Toggle task completion status.
    - **Delete tasks**: Remove tasks from the list.

3.  **State Management**
    - Uses **Provider** for managing both authentication state and task state.

4.  **Database Integration**
    - Tasks are stored and fetched from **Firebase Realtime Database** using **REST API** calls.

5.  **Responsiveness**
    - The app adapts to different screen sizes and orientations, providing an optimal user experience.

## **Tech Stack**
- Frontend : The app is built using **Flutter** for a cross-platform mobile experience  
- Backend Implementation: **Firebase** is used for Authentication and Real-time database

---

### 🖥 **Architecture**
- **MVVM Architecture**
    - **Model**: Represents the data (tasks and user).
    - **Model**: UI components that display data.
    - **ViewModel**: Manages the state of the application, interacts with the Model (data layer), and updates the View.

---


## **Installation Guide**

1. Clone the repository:
```bash
git clone https://github.com/AbhinandhanaPU/todo_list_app.git
```

2. Navigate to the project directory:
```bash
cd todo_list_app

```
3. Install dependencies:
```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2
  firebase_auth: ^5.2.0
  http: ^1.2.2
  firebase_core: ^3.4.0
  fluttertoast: ^8.2.8
```
```bash
flutter pub get
```
4. Configure Firebase:
    - Follow Firebase setup instructions to create a project and configure it with Flutter.
     
4. Run the app:
```bash
flutter run
```

---

### Contributors
- **Abhinandhana PU** - Flutter Developer
- If you have any questions or feedback, feel free to reach out to me at abhinandhanapu@gmail.com.

---
