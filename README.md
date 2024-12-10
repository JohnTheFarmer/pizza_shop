

# Application Overview

This application allows pizza store owners and chefs to manage pizza toppings and create custom pizzas with various toppings.

Built with Ruby on Rails (a first-time experience) , and the user interface is styled using Tailwind CSS (also a first-time experience).
### Technical Choices:
- **Ruby on Rails**: Fast development, convention-over-configuration, and rich built-in tools.
- **PostgreSQL**: A powerful, open-source relational database.
- **RSpec**: A flexible testing framework for unit and integration tests.
- **Tailwind CSS**: A utility-first CSS framework for rapid and maintainable UI development.
- **Devise**: Flexible authentication solution for Rails, handling user registration, login, and account management.

---


# Local Setup Guide for Windows Users with VSCode IDE

## Prerequisites

1. **Windows 11/10**.
2. **Visual Studio Code** installed. [Download here](https://code.visualstudio.com/).

---

## Steps to Install Ruby on Rails on Windows 11

### 1. Install Ruby on Rails on WSL (Ubuntu)
Follow the official guide to set up Ruby on Rails on Ubuntu within WSL:
[GoRails Windows Setup Guide](https://gorails.com/setup/windows/11)

### 2. Download the Repository

- Clone or download the project to your local machine.
- Move the project folder to your WSL Ubuntu system


### 3. Open VSCode in WSL
- Open **Visual Studio Code**.
- Press `Ctrl+Shift+P` to open the Command Palette.
- Type `WSL: Connect to WSL using Distro` and select the **Ubuntu** distribution.
- In the VSCode welcome tab, select **Open Folder** and choose the project folder.

### 4. Set Up the Ruby on Rails Project
- Open the **terminal** in VSCode (Terminal > New Terminal).
- Make sure you're in the project folder in the terminal.

### 5. Verify Ruby Installation
Check if Ruby is installed by running:
    ```
    ruby -v
    ```

### 6. Install Dependencies
Install the required gems and dependencies by running:

```
bundle install
```

### 7. Setup test data
Run the following command to create test data and users:

```
bin/rails db:seed
```
### 8. Precompile Assets
Precompile Rails assets, including Tailwind CSS:

```
rails assets:precompile
```

### 9. Start the Rails Server
Start the Rails development server:

```
rails s
```

You can now visit `http://localhost:3000` in your browser to view the app.

Start live rebuilds, generating output on file changes.
```
bin/rails tailwindcss:watch
```
### 10. Login
Ensure you’ve completed step 7 to set up test data.

 Sign in as **Owner** using the following credentials:

```
Email: owner@test.com
Password: password
```

 Sign in as **Chef** using the following credentials:

```
Email: chef@test.com
Password: password
```
---

# Running Tests Locally


## Run the Tests
you can run all the tests by executing the following command in the terminal:
    ```
    rspec
    ```

This will run all the tests in your project.