animation := Animation new.

animation space
		addEventHandlerOn: BlSpaceClosedEvent
		do: [ :event | self stop ].
		
height := animation space extent y.
width := animation space extent x.
ast1 := Asteroid new.
ast2 := Asteroid new.
ast1 direction: 0.
ast2 direction: Float pi.
ast1 speed: 1.
ast2 speed: 1.

animation addAsteroid: ast1.
animation addAsteroid: ast2.
animation space root addChild: ast1.
animation space root addChild: ast2.
ast1 position: (0)@(400).
ast2 position: (400)@(400).
"ast1 haltOnCallTo: #position:."
ast1 startAnimation.
animation space show
