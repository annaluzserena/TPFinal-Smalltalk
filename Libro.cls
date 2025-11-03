"Filed out from Dolphin Smalltalk"!

Core.Object
	subclass: #'Core.Libro'
	instanceVariableNames: 'titulo anio genero id copias'
	classVariableNames: ''
	imports: #()
	classInstanceVariableNames: ''
	classConstants: {}!

Core.Libro guid: (Core.GUID fromString: '{7af13fea-e63c-4e29-9b63-136704cd3c96}')!

Core.Libro comment: ''!

!Core.Libro methodsFor!

anio
	^anio!

copias
	^copias!

genero
	^genero!

id
	^id!

iniLib: unTitulo con: unAnio con: unGenero con: unId con: unaCant
"Inicializa una instancia de la clase Libro"

titulo:= unTitulo.
anio:= unAnio.
genero:= unGenero.
id:= unId.
copias:= unaCant.!

modAnio: anObject
	anio := anObject!

modCopias: anObject
	copias := anObject!

modGenero: anObject
	genero := anObject!

modId: anObject
	id := anObject!

modTitulo: anObject
	titulo := anObject!

titulo
	^titulo! !

!Core.Libro categoriesForMethods!
anio!accessing!public! !
copias!accessing!public! !
genero!accessing!public! !
id!accessing!public! !
iniLib:con:con:con:con:!public! !
modAnio:!accessing!public! !
modCopias:!accessing!public! !
modGenero:!accessing!public! !
modId:!accessing!public! !
modTitulo:!accessing!public! !
titulo!accessing!public! !
!

!Core.Libro class methodsFor!

crearLib: unTitulo con: unAnio con: unGenero con: unId con: unaCant
"Crea y retorna una instancia de la clase Libro inicializada"

^(self new) iniLib: unTitulo con: unAnio con: unGenero con: unId con: unaCant.! !

!Core.Libro class categoriesForMethods!
crearLib:con:con:con:con:!public! !
!

