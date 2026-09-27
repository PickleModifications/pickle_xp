import React from 'react'

export default function CategoryCard({ category }) {
  const { label, level, xp, level_xp } = category
  const clampedXp = Math.min(xp, level_xp)
  const progress = Math.ceil((clampedXp / level_xp) * 100)

  return (
    <div>
      <div>
        <div>
          <span>{label}</span>
          <div>
            <span>Level {level}</span>
            <span>XP {clampedXp} / {level_xp}</span>
          </div>
        </div>
        <div className="progress-bar">
          <div className="progress-value" style={{ width: `${progress}%` }} />
        </div>
      </div>
    </div>
  )
}
