# Mercenários Espaciais

A top-down action game set in a retro-futuristic universe, developed as an academic project.

---

## About the Game

Mercenários Espaciais is a round-based action game where the player controls a space mercenary attempting to rob a high-security bank owned by his long-time rival.

The player must survive increasingly difficult waves of robotic enemies while avoiding environmental hazards such as spikes. The objective is to eliminate all enemies in each round and escape alive.

---

## Core Gameplay

- Top-down fixed camera
- Round-based enemy system
- Player movement using **WASD**
- Mouse-controlled rotating laser weapon
- Health system based on hearts
- Environmental hazards (spikes)

---

## Technical Implementation

This project was one of my first experiences implementing structured gameplay systems from scratch.

Main implemented systems:

- Round-based enemy spawning system
- Heart-based health management system
- Player input handling (movement + mouse aiming)
- Collision detection (enemies and environment)
- Modular enemy behavior logic

---

## Enemy AI – First Experience

One of the most important learning experiences in this project was implementing a basic enemy AI system.

I developed a simple pursuit behavior where enemies:

- Continuously detect the player's position
- Calculate direction vectors toward the player
- Move dynamically to chase the player
- Apply damage upon collision

This was my first practical experience working with AI-like behavior in games, including:

- Vector-based movement
- Real-time position tracking
- Basic behavior logic
- Gameplay balancing through enemy speed and spawn rate

Although simple, this system was fundamental in helping me understand how game AI logic works in practice.

---

## Challenges

- Implementing smooth and consistent enemy pursuit behavior
- Balancing enemy spawn progression across rounds
- Managing collision detection without breaking gameplay flow
- Structuring systems in an organized and scalable way

---

## What I Learned

- Fundamentals of enemy AI behavior
- Vector math applied to gameplay
- Structuring modular gameplay systems
- Designing increasing difficulty curves
- Translating game design concepts into functional code

---

## Role

This project was developed in collaboration.

I was responsible for all programming and gameplay implementation, including:

- Enemy AI logic
- Player systems
- Round management
- Combat mechanics

All art and visual assets were created by the design team.
