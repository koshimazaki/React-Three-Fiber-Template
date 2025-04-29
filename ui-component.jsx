import { useState } from 'react'
import { 
  Box, 
  Typography, 
  Slider, 
  Button 
} from '@mui/material'
import { useStore } from '../store/useStore'

export function ControlPanel() {
  const [value, setValue] = useState(0.5)
  const { updateScene } = useStore()
  
  function handleChange(e, newValue) {
    setValue(newValue)
    updateScene({ parameter: newValue })
  }
  
  return (
    <Box
      sx={{
        position: 'absolute',
        bottom: 24,
        right: 24,
        width: 300,
        p: 2,
        bgcolor: 'rgba(0, 0, 0, 0.5)',
        color: 'white',
        borderRadius: 2,
        zIndex: 100
      }}
    >
      <Typography variant="h6" gutterBottom>
        Controls
      </Typography>
      
      <Typography id="parameter-slider">
        Parameter: {value.toFixed(2)}
      </Typography>
      
      <Slider
        value={value}
        onChange={handleChange}
        min={0}
        max={1}
        step={0.01}
        aria-labelledby="parameter-slider"
        sx={{ my: 2 }}
      />
      
      <Button 
        variant="contained" 
        color="primary"
        fullWidth
        onClick={() => setValue(0.5)}
      >
        Reset
      </Button>
    </Box>
  )
} 