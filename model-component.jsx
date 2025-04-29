import { useRef } from 'react'
import { useFrame } from '@react-three/fiber'
import { useGLTF } from '@react-three/drei'
import * as THREE from 'three'
import { useStore } from '../store/useStore'

// Optional shader imports
import vertexShader from '../shaders/vertex/myShader.glsl'
import fragmentShader from '../shaders/fragment/myShader.glsl'

export function ModelComponent({ position = [0, 0, 0], scale = 1 }) {
  // Refs for meshes and animations
  const groupRef = useRef()
  const materialRef = useRef()
  
  // Load model data
  const { nodes, materials } = useGLTF('/models/model.glb')
  
  // Access store if needed
  const { someState } = useStore()
  
  // Animation loop
  useFrame((state, delta) => {
    if (!groupRef.current) return
    
    // Animation code
    groupRef.current.rotation.y += delta * 0.5
    
    // Update shader uniforms if using shaders
    if (materialRef.current) {
      materialRef.current.uniforms.uTime.value += delta
    }
  })
  
  return (
    <group ref={groupRef} position={position} scale={scale}>
      <mesh 
        geometry={nodes.Object.geometry} 
        castShadow 
        receiveShadow
      >
        {/* Use standard material or custom shader material */}
        <meshStandardMaterial 
          color="#fc0398"
          roughness={0.4}
          metalness={0.6}
        />
        
        {/* Alternative: Custom shader material */}
        {/* 
        <shaderMaterial
          ref={materialRef}
          vertexShader={vertexShader}
          fragmentShader={fragmentShader}
          uniforms={{
            uTime: { value: 0 },
            uColor: { value: new THREE.Color('#fc0398') }
          }}
        />
        */}
      </mesh>
    </group>
  )
} 