# React Three Fiber Vite Project Setup Script

This Bash script automates the setup of a React Three Fiber (R3F) project using Vite. It provides a ready-to-use template for creating 3D visualizations and interactive experiences with ease.

## Features

- **Project Initialization**: Quickly sets up a Vite project with the React JavaScript template based on your chosen project name.
- **Dependency Management**:
  - Installs essential libraries for React Three Fiber development, including:
    - `three`
    - `@react-three/fiber`
    - `@react-three/drei`
    - `@mui/material` and more
  - Supports either the latest versions of dependencies or stable, specific versions for compatibility.
- **Development Setup**: Configures `package.json` with scripts for:
  - Development (`npm run dev`)
  - Building (`npm run build`)
  - Preview (`npm run preview`)
  - Updating dependencies (`npm run update-deps`)
- **Starter Code**:
  - Includes base components (`App.jsx` and `Experience.jsx`) that render a simple 3D scene with:
    - A spinning cube
    - Ambient and directional lighting
    - A floor plane
    - Customizable color palette
  - Provides a CSS file (`index.css`) for basic styling and fullscreen canvas setup.
- **Interactive Menu**: 
  - After setup, the script presents an interactive menu for starting the development server or exiting.

## Usage

To give permissions run: 

`run chmod +x r3f_setup.sh`

Run the script with the following command:

```bash
./r3f_setup.sh <project-name>
