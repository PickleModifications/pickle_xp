import React, { useState, useEffect } from 'react'
import CategoryCard from './CategoryCard'

function post(type, data) {
  fetch(`https://pickle_xp/${type}`, {
    method: 'post',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(data || {}),
  })
    .then(() => {})
    .catch(() => {})
}

export default function App() {
  const [categories, setCategories] = useState({})
  const [visible, setVisible] = useState(false)

  useEffect(() => {
    function handleMessage(ev) {
      const event = ev.data
      if (event.type === 'show') {
        setCategories(event.data)
        setVisible(true)
      } else if (event.type === 'hide') {
        setVisible(false)
      }
    }

    window.addEventListener('message', handleMessage)
    return () => window.removeEventListener('message', handleMessage)
  }, [])

  function handleExit() {
    setVisible(false)
    post('hide')
  }

  return (
    <div
      className="container"
      style={{ display: visible ? 'flex' : 'none' }}
    >
      <div className="top-section">
        <span
          className="exit mdi mdi-close"
          onClick={handleExit}
        />
        <h1>Pickle's XP System</h1>
      </div>
      <div className="middle-section">
        {Object.entries(categories).map(([key, value]) => (
          <CategoryCard key={key} category={value} />
        ))}
      </div>
      <div className="bottom-section" />
    </div>
  )
}
