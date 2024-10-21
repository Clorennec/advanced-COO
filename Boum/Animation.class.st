Class {
	#name : 'Animation',
	#superclass : 'Object',
	#instVars : [
		'asteroids',
		'explosions',
		'process',
		'space'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'initialization' }
Animation >> addAsteroid: aSprite [

	asteroids add: aSprite
]

{ #category : 'initialization' }
Animation >> checkCollisions [

	| toExplode |
	toExplode := Set new.
	asteroids withIndexDo: [ :sprite1 :i |
		i + 1 to: asteroids size do: [ :j |
			| sprite2 |
			sprite2 := asteroids at: j.
			(self detectCollisionBetween: sprite1 and: sprite2) ifTrue: [
				toExplode add: sprite1.
				toExplode add: sprite2 ] ].
		(self isTooFarFromScreen: sprite1) ifTrue: [
			toExplode add: sprite1.
		].].
	toExplode do: [ :e |
		self triggerExplosionAt: e position.
		e stopAnimation.
		asteroids remove: e.
		space root removeChild: e ].
	
]

{ #category : 'initialization' }
Animation >> checkCollisionsAndBoundaries [

	| toExplode |
	toExplode := Set new.
	asteroids withIndexDo: [ :sprite1 :i |
		i + 1 to: asteroids size do: [ :j |
			| sprite2 |
			sprite2 := asteroids at: j.
			(self detectCollisionBetween: sprite1 and: sprite2) ifTrue: [
				toExplode add: sprite1.
				toExplode add: sprite2 ] ].
		(self isTooFarFromScreen: sprite1) ifTrue: [
			toExplode add: sprite1.
		].].
	toExplode do: [ :e |
		self triggerExplosionAt: e position.
		e stopAnimation.
		asteroids remove: e.
		space root removeChild: e ].
	
]

{ #category : 'initialization' }
Animation >> detectCollisionBetween: sprite1 and: sprite2 [

	| overlap |
	overlap := self detectHitboxCollisionBetween: sprite1 and: sprite2.
	overlap isZero ifTrue: [ ^ false ] ifFalse: [
		^ self
			  detectPixelCollision: overlap
			  sprite1: sprite1
			  sprite2: sprite2 ]
]

{ #category : 'initialization' }
Animation >> detectHitboxCollisionBetween: sprite1 and: sprite2 [

	| bounds1 bounds2 |
	bounds1 := sprite1 boundsInSpace.
	bounds2 := sprite2 boundsInSpace.

	^ bounds1 intersect: bounds2
]

{ #category : 'initialization' }
Animation >> detectPixelCollision: overlap [

	| width height image |
	width := overlap extent x.
   height := overlap extent y.
	image := overlap image.

	"Vérifier chaque pixel dans la zone d'intersection"
	0 to: width do: [ :x |
		0 to: height do: [ :y |
			((image pixelValueAt: x@y) alpha) > 0 
				ifTrue: [^true]
			 ]
		 ].
	^ false
]

{ #category : 'initialization' }
Animation >> detectPixelCollision: overlap sprite1: sprite1 sprite2: sprite2 [

	| relativePosition1 relativePosition2 sprite1Image sprite2Image |
	"Obtenir les images des sprites"
	sprite1Image := sprite1 background image.
	sprite2Image := sprite2 background image.

	"Calculer les positions relatives dans la zone d'intersection"
	relativePosition1 := overlap origin - sprite1 boundsInSpace origin.
	relativePosition2 := overlap origin - sprite2 boundsInSpace origin.

	"Vérifier chaque pixel dans la zone d'intersection"
	0 to: (overlap extent y - 1) do: [ :y |
        0 to: (overlap extent x - 1) do: [ :x |
            | pixel1 pixel2 |
            "Utiliser isTransparent au lieu de pixelValueAt"
            pixel1 := sprite1Image isTransparentAt: (relativePosition1 + (x @ y)).
            pixel2 := sprite2Image isTransparentAt: (relativePosition2 + (x @ y)).

            "Vérifier si les deux pixels ne sont pas transparents"
            (pixel1 not and: [ pixel2 not ]) ifTrue: [ ^ true ].
        ].
    ].

	^ false
]

{ #category : 'initialization' }
Animation >> detectPixelCollisionBetween: sprite1 and: sprite2 [
    | overlapRect relativePosition1 relativePosition2 sprite1Image sprite2Image |

    "Déterminer la zone d'intersection des deux sprites"
    overlapRect := sprite1 bounds intersect: sprite2 bounds.
    overlapRect isEmpty ifTrue: [ ^ false ].

    "Obtenir les images des sprites"
    sprite1Image := sprite1 background.
    sprite2Image := sprite2 background.

    "Calculer les positions relatives dans la zone d'intersection"
    relativePosition1 := overlapRect origin - sprite1 bounds origin.
    relativePosition2 := overlapRect origin - sprite2 bounds origin.

    "Vérifier chaque pixel dans la zone d'intersection"
    0 to: (overlapRect extent y - 1) do: [ :y |
        0 to: (overlapRect extent x - 1) do: [ :x |
            | pixel1 pixel2 |
            pixel1 := sprite1Image pixelValueAt: (relativePosition1 + (x @ y)).
            pixel2 := sprite2Image pixelValueAt: (relativePosition2 + (x @ y)).

            "Vérifier si les deux pixels ne sont pas transparents"
            (pixel1 alpha > 0 and: [ pixel2 alpha > 0 ]) ifTrue: [ ^ true ].
        ].
    ].

    ^ false.

]

{ #category : 'initialization' }
Animation >> initialize [

	super initialize.
	space := BlSpace new.
	space root background: Color white.
	asteroids := OrderedCollection new.
	explosions := OrderedCollection new
]

{ #category : 'initialization' }
Animation >> isTooFarFromScreen: anAsteroid [

	| screenBounds |
	screenBounds := (0 @ 0 extent: space root boundsInSpace extent) insetBy: 100. "Espace légèrement au-delà de l'écran"
	^ (anAsteroid boundsInSpace intersects: screenBounds) not
]

{ #category : 'accessing' }
Animation >> space [ 
^space
]

{ #category : 'initialization' }
Animation >> start [

	process := [
	           [ true ] whileTrue: [
		           self checkCollisionsAndBoundaries.
		           50 milliSeconds wait ] ] fork
]

{ #category : 'initialization' }
Animation >> stop [

	process terminate.
	asteroids do: [ :sprite | sprite stopAnimation ]
]

{ #category : 'initialization' }
Animation >> triggerExplosionAt: aPosition [

	| explosion |
	explosion := Explosion new.
	explosion position: aPosition.
	explosions add: explosion.
	space root addChild: explosion.
	explosion startAnimation
]
