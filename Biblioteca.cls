"Filed out from Dolphin Smalltalk"!

Object subclass: #Biblioteca
	instanceVariableNames: 'nombre barrio anio personal conjLibros'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!

Biblioteca guid: (GUID fromString: '{14560dd0-6dd5-4ebd-9d68-2ea4589c63c9}')!

Biblioteca comment: ''!

!Biblioteca categoriesForClass!Kernel-Objects! !

!Biblioteca methodsFor!

agregarLibro:unLibro
"Agrega un libro a la Biblioteca"
conjLibros add:unLibro.

!

anio
	^anio!

barrio
	^barrio!

cantidadLibros
"Retorna el total de libros de la biblioteca"
^ conjLibros size.

!

eliminarLibro:unLibro
"Elimina un libro de la Biblioteca"
conjLibros remove:unLibro.

!

esVacia
"Retorna true si la Biblioteca no tiene libros, false en caso contrario"
^ conjLibros isEmpty.

!

existeLibro:unLibro
"Retorna true si el libro está en la Biblioteca, falso en caso contrario"
^ conjLibros includes:unLibro.

!

iniBiblioNom: unnom anio:unanio barrio:unbarrio personal:uncant
"Inicializa la instancia de biblioteca"
nombre:=unnom.
anio:=unanio.
barrio:=unbarrio.
personal:=uncant.
conjLibros:=OrderedCollection new.

!

modAnio: anObject
	anio := anObject!

modBarrio: anObject
	barrio := anObject!

modNombre: anObject
	nombre := anObject!

modPersonal: anObject
	personal := anObject!

nombre
	^nombre!

personal
	^personal!

recuperarLibro: i
"Retorne el libro de la posición i-ésima de la Biblioteca"
^ conjLibros at:i.

!

verTodos
"Retorna una coleccion con todos los libros de la biblioteca"

^conjLibros.! !

!Biblioteca categoriesForMethods!
agregarLibro:!public! !
anio!accessing!public! !
barrio!accessing!public! !
cantidadLibros!public! !
eliminarLibro:!public! !
esVacia!public! !
existeLibro:!public! !
iniBiblioNom:anio:barrio:personal:!public! !
modAnio:!accessing!public! !
modBarrio:!accessing!public! !
modNombre:!accessing!public! !
modPersonal:!accessing!public! !
nombre!accessing!public! !
personal!accessing!public! !
recuperarLibro:!public! !
verTodos!public! !
!

!Biblioteca class methodsFor!

crearBiblioNom:unnom anio:unanio barrio:unbarrio personal:uncant
"crea y retorna una instancia de biblioteca inicializada"
^(self new) iniBiblioNom: unnom anio:unanio barrio:unbarrio personal:uncant.
! !

!Biblioteca class categoriesForMethods!
crearBiblioNom:anio:barrio:personal:!public! !
!

