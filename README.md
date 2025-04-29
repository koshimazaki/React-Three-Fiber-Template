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
- **MDC file with Cursor rules**:
  - MDC file and example files are copied to the project from the root. 

## Dependencies as of now:

- React and React DOM: 19.1.0
- Three.js: 0.176.0
- @react-three/fiber: 9.1.2
- @react-three/drei: 10.0.7
- @react-three/postprocessing: 3.0.4
- Material UI: 7.0.2
- Emotion: 11.14.0
- Framer Motion: 12.9.2
- Zustand: 5.0.3
- Postprocessing: 6.37.3
- Three-mesh-bvh: 0.9.0
- Vite: 6.3.3
- @vitejs/plugin-react: 4.4.1


## Usage

To give permissions run: 

`run chmod +x r3f_setup.sh`

Run the script with the following command:

```bash
./r3f_setup.sh <project-name>
