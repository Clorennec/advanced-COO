Class {
	#name : 'GameObject',
	#superclass : 'Object',
	#instVars : [
		'sprite',
		'currentPosition',
		'velocityVector',
		'blElement',
		'currentFrame',
		'exploded'
	],
	#category : 'Boum-object',
	#package : 'Boum',
	#tag : 'object'
}

{ #category : 'accessing' }
GameObject >> blElement [
	^blElement 
]

{ #category : 'as yet unclassified' }
GameObject >> collideWith: anObject [
	^ self subclassResponsibility 
]

{ #category : 'as yet unclassified' }
GameObject >> collidesPixelPerfectWith: anotherObject [

	| boundingBoxA boundingBoxB overlapArea x y colorA colorB |
	boundingBoxA := self blElement boundsInSpace.
	boundingBoxB := anotherObject blElement boundsInSpace.

	overlapArea := boundingBoxA intersect: boundingBoxB.

	overlapArea isZero ifTrue: [ ^ false ].

	overlapArea origin x to: overlapArea corner x do: [ :overlapX |
		overlapArea origin y to: overlapArea corner y do: [ :overlapY |
			x := overlapX - self currentPosition x.
			y := overlapY - self currentPosition y.
			colorA := (sprite at: currentFrame) colorAt: x @ y.

			x := overlapX - anotherObject currentPosition x.
			y := overlapY - anotherObject currentPosition y.
			colorB := (anotherObject sprite at: anotherObject currentFrame)
				          colorAt: x @ y.

			(colorA alpha > 0 and: [ colorB alpha > 0 ]) ifTrue: [ ^ true ] ] ].
	^false
]

{ #category : 'accessing' }
GameObject >> currentFrame [ 
	^currentFrame 
]

{ #category : 'initialization' }
GameObject >> currentPosition [ 
	^ currentPosition .
]

{ #category : 'initialization' }
GameObject >> currentPosition: aPosition [
	currentPosition := aPosition.
	blElement position: self currentPosition.
]

{ #category : 'as yet unclassified' }
GameObject >> explode [

	| pos |
	pos := currentPosition.
	sprite := ExplosionSprite uniqueInstance images.
	currentFrame := 1.
	exploded := true.
	self currentPosition:
		pos - ((sprite at: currentFrame) extent - blElement extent / 2).
	blElement extent: (sprite at: currentFrame) extent
]

{ #category : 'accessing' }
GameObject >> exploded [
	^exploded 
]

{ #category : 'initialization' }
GameObject >> initialize [

	currentFrame := 1.
	currentPosition := 0 @ 0.
	velocityVector := 0 @ 0.
	blElement := BlElement new.
	exploded := false.
]

{ #category : 'accessing' }
GameObject >> move [

	self currentPosition: currentPosition + velocityVector.
]

{ #category : 'accessing' }
GameObject >> sprite [
	^ sprite 
]

{ #category : 'updating' }
GameObject >> update [
	self updateFrame.
	self move.
]

{ #category : 'as yet unclassified' }
GameObject >> updateFrame [
	currentFrame < sprite size ifTrue: [ currentFrame := currentFrame + 1 ] ifFalse: [ currentFrame := 1 ].
	blElement background: (sprite at: currentFrame)
]

{ #category : 'accessing' }
GameObject >> velocity [
	^velocityVector 
]

{ #category : 'accessing' }
GameObject >> velocity: aVector [
	velocityVector := aVector 
]
