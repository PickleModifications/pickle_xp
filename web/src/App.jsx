import React, { useState, useEffect, useCallback } from 'react'

/**
 * Post a NUI callback to the resource.
 * Falls back to a no-op when running outside FiveM (e.g. during dev preview).
 */
function fetchNui(type, data) {
  const resourceName =
    typeof GetParentResourceName === 'function'
      ? GetParentResourceName()
      : 'pickle_xp'

  fetch(`https://${resourceName}/${type}`, {
    method: 'POST',
    headers: {
      Accept: 'application/json',
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(data ?? {}),
  }).catch(() => {})
}

/**
 * Clamp xp to level_xp then compute progress percentage (ceiling).
 * Mirrors the logic in the original main.js lines 41-46.
 */
function computeProgress(xp, level_xp) {
  const clampedXp = xp > level_xp ? level_xp : xp
  return { clampedXp, progress: Math.ceil((clampedXp / level_xp) * 100) }
}

function CategoryCard({ category }) {
  const { clampedXp, progress } = computeProgress(
    category.xp,
    category.level_xp,
  )

  return (
    <div>
      <div>
        {/* First child — label + level/xp info */}
        <div>
          <span>{category.label}</span>
          <div>
            <span>Level {category.level}</span>
            <span>
              XP {clampedXp} / {category.level_xp}
            </span>
          </div>
        </div>
        {/* Progress bar */}
        <div className="progress-bar">
          <div
            className="progress-value"
            style={{ width: `${progress}%` }}
          />
        </div>
      </div>
    </div>
  )
}

export default function App() {
  const [visible, setVisible] = useState(false)
  const [categories, setCategories] = useState({})

  const show = useCallback((data) => {
    setCategories(data)
    setVisible(true)
  }, [])

  const hide = useCallback(() => {
    setVisible(false)
  }, [])

  const handleClose = useCallback(() => {
    hide()
    fetchNui('hide')
  }, [hide])

  useEffect(() => {
    function onMessage(ev) {
      const event = ev.data
      if (event.type === 'show') {
        show(event.data)
      } else if (event.type === 'hide') {
        hide()
      }
    }

    window.addEventListener('message', onMessage)
    return () => window.removeEventListener('message', onMessage)
  }, [show, hide])

  return (
    <div
      id="container"
      className={`container${visible ? ' container--visible' : ''}`}
    >
      <div id="top" className="top-section">
        <span
          className="exit mdi mdi-close"
          onClick={handleClose}
          role="button"
          aria-label="Close"
        />
        <h1>Pickle&#39;s XP System</h1>
      </div>

      <div id="middle" className="middle-section">
        {Object.entries(categories).map(([key, value]) => (
          <CategoryCard key={key} category={value} />
        ))}
      </div>

      <div id="bottom" className="bottom-section" />
    </div>
  )
}
