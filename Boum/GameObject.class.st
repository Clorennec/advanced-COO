Class {
	#name : 'GameObject',
	#superclass : 'Object',
	#instVars : [
		'sprite',
		'currentPosition',
		'velocityVector',
		'blElement',
		'currentFrame'
	],
	#category : 'Boum-object',
	#package : 'Boum',
	#tag : 'object'
}

{ #category : 'accessing' }
GameObject >> blElement [
	^blElement 
]

{ #category : 'initialization' }
GameObject >> initialize [
	currentFrame := 1.
	currentPosition := 0 @ 0.
	velocityVector := 0 @ 0.
	blElement := BlElement new
]

{ #category : 'accessing' }
GameObject >> move [

	blElement position: currentPosition + velocityVector.
	currentPosition := currentPosition + velocityVector 
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
