Class {
	#name : 'Animation',
	#superclass : 'Object',
	#instVars : [
		'sprites',
		'explosionSprites'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'initialization' }
Animation >> addSprite: aSprite [
       sprites add: aSprite.
]

{ #category : 'initialization' }
Animation >> checkCollisions [

	sprites do: [ :sprite1 |
		sprites do: [ :sprite2 |
			(sprite1 ~= sprite2 and: [
				self detectCollisionBetween: sprite1 and: sprite2 ]) ifTrue: [
				self triggerExplosionAt: sprite1 position.
				self triggerExplosionAt: sprite2 position.
				sprite1 stopAnimation.
				sprite2 stopAnimation ] ] ]
]

{ #category : 'initialization' }
Animation >> createExplosionSpriteCollection [ 
       ^ SpriteCollection path: 'C:\Users\louis\Downloads\expl001Sp_Fire_fixed.png' size: 6 numberOfImages: 42.
]

{ #category : 'initialization' }
Animation >> detectCollisionBetween: sprite1 and: sprite2 [
       ^ sprite1 bounds intersects: sprite2 bounds
]

{ #category : 'initialization' }
Animation >> initialize [

	sprites := OrderedCollection new.
	explosionSprites := OrderedCollection new
]

{ #category : 'initialization' }
Animation >> start [
       [
           [ true ] whileTrue: [
               self checkCollisions.
               10 milliSeconds wait.
           ].
       ] fork.
]

{ #category : 'initialization' }
Animation >> triggerExplosionAt: aPosition [
       | explosionSprite |
       explosionSprite := SpriteElement new.
       explosionSprite initializeWith: (self createExplosionSpriteCollection).
       explosionSprite position: aPosition.
       explosionSprite startAnimation.
       explosionSprites add: explosionSprite.
]
