# Trauma register frontend

## Project Overview
This repository contains the source code for the frontend component of a data management application designed for the emergency care context. This application serves as the user interface, allowing for a seamless interaction with the backend system to manage and visualize patient data. <br>
This project is part of a graduation thesis to obtain a degree in Systems Engineering from Universidad del Valle.

## Key Features
The frontend is structured to provide a rich user experience and is organized into three main functionalities:

1. **Patient Management**: Enables users to perform CRUD (Create, Read, Update, Delete) operations on individual patient records through an intuitive graphical interface. 🧑‍⚕️

2. **Statistical Visualization**: Fetches and displays statistical data from the backend in the form of interactive charts and graphs, offering clear and concise insights. 📊

3. **Bulk Data Upload**: Provides a user-friendly interface to upload large volumes of data via Excel files, ensuring efficient and quick data integration into the system.📂

## Project Components
This frontend repository is complemented by the backend repository, which handles the server logic and data storage. You can find the backend project [here](https://github.com/Diego2038/trauma_register_backend).

**Important clarification**: If you want to run this frontend repository with the backend repository mentioned above (or any backend), you must modify the ***API*** variable in the `api.dart` file with the URL where the backend application has been uploaded to ensure proper communication.

## Technologies Used

This project is built using a modern and robust technology stack to create a high-performance and cross-platform application.

- **Flutter**: The UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase, version **3.22.3**.
- **Dart**: The core language for development, version **3.4.4**.
- **Java**: Used for Android-specific development tasks, recommended version **17**.
- **NPM**: It's optionally used to extract unit test coverage.

## How to execute this repository

First download this repo through the next command:
```
git clone https://github.com/Diego2038/trauma_register_frontend.git
```

From the project root, run the following command to install all necessary packages:

```bash
flutter pub get
```

Connect a device or launch an emulator, and run the application in development mode with the following command:

```bash
flutter run
```
You can also run it directly from your IDE, such as Visual Studio Code, and run it with the F5 button or whatever locale you have.
<br>

And if you want to generate a web build for this application, you can use this command:
```bash
flutter build web --release
```
The output will be saved in the ```build/web``` directory within your project, and you can then serve the contents of this folder using a web server.

## How to make unit tests

1. **Open the terminal in the project root:**

2. **Execute the unit tests:** <br>

Run the following command to execute all unit tests in the project:
```bash
flutter test
```
To execute a specific test file, provide its path (either folder or file), for example:
```bash
flutter test .\test\data\models\custom\time_of_day_test.dart
```

3. **Calculate the coverage:** <br>

Execute the tests with the `--coverage` flag to generate a coverage report:
```bash
flutter test --coverage
```

4. **Generate a report of the coverage:** <br>

To generate a detailed coverage report in the terminal, you can use a tool like `lcov-summary`. First, install it using npm:
```bash
npm install -g lcov-summary
```
This tool reads the `lcov.info` file generated during the coverage calculation and displays the results directly in the terminal.

To see the unit test coverage run the following command:
```bash
lcov-summary coverage/lcov.info
```
5. **Important note**: <br>

You can adjust coverage calculation, for example:
```bash
flutter test .\test\core\ --coverage
```
And then you can extract the bounded coverage result again
```bash
lcov-summary coverage/lcov.info
```

