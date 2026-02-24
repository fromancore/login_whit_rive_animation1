# 💻 Rive Animation Login Project

This repository shows, through commits, the step-by-step development of an animated login screen built with Flutter and integrated with Rive State Machines.

---

## 🚀 Project Overview

The objective of this project is to implement an interactive login interface using Flutter and Rive animations.  

The animation reacts dynamically to user actions such as focusing on text fields, typing credentials, and validating login input.

This project demonstrates the integration of UI development and animation logic using State Machines.

---

## ⭐ Features

- 🐻 Animated character reacting to user interaction  
- 👀 Character follows the email field when typing  
- 🙈 Character covers its eyes when the password field is selected  
- 🔒 Password hidden by default with toggle visibility button  
- ❌ Error reaction when credentials are invalid  
- ✅ Happy reaction when credentials are valid  
- 🎯 Animation controlled through Rive State Machine logic  

---

## 🤖 Rive and State Machine

### 🎨 What is Rive?

Rive is a real-time interactive animation design tool that allows developers to create and integrate high-quality animations into applications across multiple platforms.

It enables animations to respond dynamically to user input through programmable logic.

### 🔄 What is a State Machine?

A State Machine in Rive is a logic-based system that controls transitions between animation states depending on input conditions.

In this project, the State Machine manages different animation states such as:

- Idle  
- Focus on Email  
- Focus on Password  
- Error  
- Success  

This allows the character to visually respond to user interaction in real time.

---

## 🌐 Technologies Used

- 💙 Flutter  
- 🎯 Dart  
- 🎨 Rive  
- 🔗 Git & GitHub  
- 🧠 State Machines  
- 👁️ FocusNode  
- 🔎 Regular Expressions (Regex)  
- 🎧 Listeners  
- 🎮 Animation Controller  

---

## 🛠️ Basic Project Structure (lib folder)

```
lib/
│
├── main.dart
└── login_screen.dart
```

### 📌 File Description

- **main.dart** → Entry point of the application. Initializes and runs the app.  
- **login_screen.dart** → Contains the UI structure, animation integration, State Machine logic, controllers, listeners, and validation logic.  

---

## 📷 Demo 👁️

Example of full application functionality:

![App Demo](demo.gif)

---

## 📚 Course Information

**Subject:** Graficación 
**Professor:** Rodrigo Fidel Gaxiola Sosa
**Student:** Luisa Fernanda Román Hernández  

---

## 🔗 Animation Credits

Animation created by: dexterc  
Original animation link: https://rive.app/marketplace/3645-7621-remix-of-login-machine/

Full credit is given to the original animation creator.

---

## 📦 Installation

1. Clone the repository:

```
git clone https://github.com/your-username/your-repository.git
```

2. Navigate to the project directory:

```
cd your-repository
```

3. Install dependencies:

```
flutter pub get
```

4. Run the application:

```
flutter run
```

---

## 💡 Final Notes

This project represents the practical application of Flutter UI development combined with interactive animation logic using Rive State Machines.  

It enhances user experience by providing real-time visual feedback based on user interaction and input validation.
