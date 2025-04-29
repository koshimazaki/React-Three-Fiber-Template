// src/store/useStore.js
import { create } from 'zustand'

export const useStore = create((set) => ({
  // Scene parameters
  sceneParams: {
    intensity: 1.0,
    color: '#ffffff',
    parameter: 0.5
  },
  
  // Update scene parameters
  updateScene: (params) => set((state) => ({
    sceneParams: {
      ...state.sceneParams,
      ...params
    }
  })),
  
  // Reset all parameters
  resetScene: () => set({
    sceneParams: {
      intensity: 1.0,
      color: '#ffffff',
      parameter: 0.5
    }
  })
})) 