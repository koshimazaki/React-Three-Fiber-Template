#!/bin/bash


# run chmod +x r3f_setup.sh

# Usage: ./r3f_setup.sh <project-name> [--latest]
# Example: ./r3f_setup.sh my-r3f-project --latest

# Check if project name is supplied
if [ -z "$1" ]; then
  echo "Error: No project name provided."
  echo "Usage: ./r3f_setup.sh <project-name> [--latest]"
  exit 1
fi

PROJECT_NAME=$1
USE_LATEST=false

# Check for --latest flag
if [ "$2" = "--latest" ]; then
  USE_LATEST=true
fi

# Get the absolute path of the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "Script directory: $SCRIPT_DIR"

# Check if required files exist
for file in r3f.mdc model-component.jsx ui-component.jsx zustand-store.js vertex-shader.glsl fragment-shader.glsl; do
  if [ ! -f "$SCRIPT_DIR/$file" ]; then
    echo "Error: Required file $file not found in $SCRIPT_DIR"
    echo "Please make sure all required files are in the same directory as the script."
    exit 1
  fi
done

# Create the Vite project with React JavaScript template
echo "Creating Vite project..."
npm create vite@latest $PROJECT_NAME -- --template react

# Navigate into the project directory
cd $PROJECT_NAME || exit

# Function to install latest version of a package
install_latest() {
  npm install $1@latest
}

# Function to install specific version of a package
install_specific() {
  npm install $1@$2
}

# Install dependencies
echo "Installing dependencies..."
if [ "$USE_LATEST" = true ]; then
  install_latest "react"
  install_latest "react-dom"
  install_latest "three"
  install_latest "@react-three/fiber"
  install_latest "@react-three/drei"
  install_latest "@react-three/postprocessing"
  install_latest "@mui/material"
  install_latest "@mui/icons-material"
  install_latest "@emotion/react"
  install_latest "@emotion/styled"
  install_latest "framer-motion"
  install_latest "zustand"
  install_latest "maath"
  install_latest "postprocessing"
  install_latest "react-device-detect"
  install_latest "three-mesh-bvh"
else
  install_specific "react" "19.1.0"
  install_specific "react-dom" "19.1.0"
  install_specific "three" "0.176.0"
  install_specific "@react-three/fiber" "9.1.2"
  install_specific "@react-three/drei" "10.0.7"
  install_specific "@react-three/postprocessing" "3.0.4"
  install_specific "@mui/material" "7.0.2"
  install_specific "@mui/icons-material" "7.0.2" 
  install_specific "@emotion/react" "11.14.0"
  install_specific "@emotion/styled" "11.14.0"
  install_specific "framer-motion" "12.9.2"
  install_specific "zustand" "5.0.3"
  install_specific "maath" "0.10.8"
  install_specific "postprocessing" "6.37.3"
  install_specific "react-device-detect" "2.2.3"
  install_specific "three-mesh-bvh" "0.9.0"
fi

# Install dev dependencies
npm install -D @vitejs/plugin-react@4.4.1 vite@6.3.3

# Update package.json
echo "Updating package.json..."
npm pkg set type="module"
npm pkg set scripts.dev="vite --host --port 3000"
npm pkg set scripts.dev3="e2e-dev \$npm_package_name"
npm pkg set scripts.build="vite build"
npm pkg set scripts.build2="e2e-build \$npm_package_name"
npm pkg set scripts.preview="vite preview --host"
npm pkg set resolutions.three-mesh-bvh="^0.9.0"

# Add a post-install script to package.json for future updates
npm pkg set scripts.update-deps="npm update --latest"

# Create base files
echo "Creating base files..."

# Create App.jsx
cat > src/App.jsx <<EOL
import { Canvas } from '@react-three/fiber'
import Experience from './Experience'

export default function App() {
  return (
    <Canvas camera={{ position: [5, 5, 5], fov: 75 }}>
      <Experience />
    </Canvas>
  )
}
EOL

# Create Experience.jsx
cat > src/Experience.jsx <<EOL
import { useRef } from 'react'
import { useFrame } from '@react-three/fiber'
import { OrbitControls } from '@react-three/drei'


// Colors palette 
// https://coolors.co/fc0398-e25259-e66255-ea7250-f19146-ffcf33-42d5ca-03d7fc-0f4757-15171a

export default function Experience() {
  const cubeRef = useRef()

  useFrame((state, delta) => {
    cubeRef.current.rotation.x += delta
    cubeRef.current.rotation.y += delta * 0.5
  })

  return (
    <>
      {/* dark grey background */}
      <color attach="background" args={["#15171A"]} />
      <OrbitControls />
      <ambientLight intensity={0.5} />
      <directionalLight position={[10, 10, 5]} intensity={1} />
      
      {/* Spinning cube */}
      <mesh ref={cubeRef}>
        <boxGeometry args={[1, 1, 1]} />
        {/* pink */}
        <meshStandardMaterial color="#fc0398" />
      </mesh>
      
      {/* Floor */}
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, -1, 0]}>
        <planeGeometry args={[10, 10]} />
        {/* blue */}
        <meshStandardMaterial color="#03d7fc" />
      </mesh>
    </>
  )
}
EOL

# Update index.css
cat > src/index.css <<EOL
html,
body,
#root {
  width: 100%;
  height: 100%;
  margin: 0;
  padding: 0;
  overflow: hidden;
}
EOL

# Create recommended directory structure
mkdir -p src/components/ui
mkdir -p src/components/three/objects
mkdir -p src/components/three/effects
mkdir -p src/components/three/scenes
mkdir -p src/hooks
mkdir -p src/store
mkdir -p src/shaders/vertex
mkdir -p src/shaders/fragment
mkdir -p src/utils
mkdir -p src/assets/models
mkdir -p src/assets/textures

# Create Cursor rules directory and copy rules files
echo "Setting up Cursor rules..."
mkdir -p .cursor/rules

# Copy r3f.mdc and related files from the script directory
PROJECT_DIR="$(pwd)"
echo "Project directory: $PROJECT_DIR"
echo "Copying rule files from $SCRIPT_DIR to $PROJECT_DIR/.cursor/rules/"

# Copy with verbose output for debugging
cp -v "$SCRIPT_DIR/r3f.mdc" "$PROJECT_DIR/.cursor/rules/"
cp -v "$SCRIPT_DIR/model-component.jsx" "$PROJECT_DIR/.cursor/rules/"
cp -v "$SCRIPT_DIR/ui-component.jsx" "$PROJECT_DIR/.cursor/rules/"
cp -v "$SCRIPT_DIR/zustand-store.js" "$PROJECT_DIR/.cursor/rules/"
cp -v "$SCRIPT_DIR/vertex-shader.glsl" "$PROJECT_DIR/.cursor/rules/"
cp -v "$SCRIPT_DIR/fragment-shader.glsl" "$PROJECT_DIR/.cursor/rules/"

# Check if files were copied successfully
if [ -f "$PROJECT_DIR/.cursor/rules/r3f.mdc" ]; then
  echo "Cursor rules installed successfully."
  ls -la "$PROJECT_DIR/.cursor/rules/"
else
  echo "Warning: Failed to copy rule files. Please copy them manually."
fi

# Interactive menu function
show_menu() {
  echo ""
  echo "Setup complete! What would you like to do next?"
  echo "1) Run the development server"
  echo "2) Exit"
  echo ""
  read -p "Enter your choice (1-2): " choice

  case $choice in
    1)
      echo "Starting the development server..."
      npm run dev
      ;;
    2)
      echo "Exiting. To start the development server later, run:"
      echo "  cd $PROJECT_NAME"
      echo "  npm run dev"
      exit 0
      ;;
    *)
      echo "Invalid choice. Exiting."
      exit 1
      ;;
  esac
}

if [ "$USE_LATEST" = true ]; then
  echo ""
  echo "You've installed the latest versions of all dependencies."
  echo "To update dependencies in the future, run: npm run update-deps"
else
  echo ""
  echo "You've installed specific versions of dependencies for stability."
  echo "To update to the latest versions in the future, run: npm run update-deps"
fi

# Show the interactive menu
show_menu