**STATUS**
- Proper way to launch the game
- Pixel collisions working
- Player and Asteroid GameObjects fully functionnal

**What choices did you make ?**
- Made Sprite classes singletons so no memory issue.
- Took off processes from GameObjects, global gameloop process handled by GameManager.
- Use of double dispatch to handle collisions

**What's next ?**
- Implement a way to instantiate Asteroids randomly. 
- Add score and other information on UI.
- Handle username and leaderboard ?
- Shooting system

**Questions**
- Use of design patterns
- Is there a way to impose display order ?
