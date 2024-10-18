Class {
	#name : 'App',
	#superclass : 'Object',
	#instVars : [
		'animation',
		'space'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'running' }
App >> run [
       space := BlSpace new.
       animation := Animation new.

       1 to: 10 do: [ :i |
           | asteroid |
           asteroid := SpriteElement new.
           asteroid initializeWith: (SpriteCollection path: 'C:\Users\louis\Downloads\o001Sp.png' size: 10 numberOfImages: 100).
           asteroid position: (i * 50)@0.
           asteroid velocity: (5@5).
           animation addSprite: asteroid.
           space root addChild: asteroid.
           asteroid startAnimation.
       ].

       animation start.
       space show.
]
