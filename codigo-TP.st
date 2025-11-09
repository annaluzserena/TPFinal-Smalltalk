| col nom barrio anio cantper biblio seguir dicOp op choice aniopub genero codigo stock cant seg smod valido libro choicemod ops cant |

Transcript clear.

valido:=false.
[valido] whileFalse: [
	nom:=(Prompter prompt: 'Ingrese nombre de la biblioteca')asUppercase.
	(nom notEmpty) ifFalse: [MessageBox notify: 'El nombre no puede estar vacio'.] ifTrue: [valido:=true.].
].
valido:=false.
[valido] whileFalse: [
	barrio:=(Prompter prompt:'Ingrese barrio de la biblioteca')asUppercase.
	(barrio notEmpty) ifFalse: [MessageBox notify: 'El barrio no puede estar vacio'.] ifTrue: [valido:=true.].
].
valido:=false.
[valido] whileFalse: [
	anio:= Prompter prompt: 'Ingrese anio de creacion'.
	((anio allSatisfy: [:c | c isDigit]) and: [anio asNumber <= Date today year]) ifFalse: [MessageBox notify: 'El anio de creacion debe ser un numero y no puede ser mayor al anio actual'.] ifTrue: [anio:= anio asNumber. valido:=true.].
].
valido:=false.
[valido] whileFalse: [
	cantper:=Prompter prompt: 'Ingrese cantidad de personal de la biblioteca'.
	((cantper allSatisfy: [:c | c isDigit]) and: [cantper asNumber >= 0]) ifFalse: [MessageBox notify: 'La cantidad de personal debe ser un numero y no puede ser negativa'.] ifTrue: [cantper:= cantper asNumber. valido:=true.].
].

biblio:= Biblioteca crearBiblioNom: nom anio:anio barrio:barrio personal: cantper.

"Bloque de codigo reutilizable para listar los datos de un libro"
listar:= [ :libro |
				Transcript show: 'Titulo: ',(libro verTitulo); cr ;
				show: 'Genero: ', (libro verGenero) ; cr;
				show: 'Anio de creacion: ',(libro verAnio displayString); cr;
				show: 'Copias disponibles: ', (libro verCopias displayString); cr.
				((libro class class) == (LibroRegular class)) ifTrue: [tipo:='Regular'.] ifFalse: [tipo:='Manual'. Transcript show: 'Cantidad de veces solicitado: ',(libro verSolicitado displayString); cr.].
				Transcript show: 'Tipo: ',tipo ; cr; cr.]. 

"Menu usando un diccionario para que retorne un numero y no un string con la opcion completa"
dicOp:= OrderedDictionary new.
dicOp 
        at: 1 put: '1 - Cargar libros';
	at: 2 put: '2 - Buscar libro (Modificar/Eliminar)';
	at: 3 put: '3 - Listar libros con mas de 5 copias';
	at: 4 put: '4 - Listar libros ochentosos';
	at: 5 put: '5 - Listar cantidad de libros por genero';
	at: 6 put: '6 - Eliminar libros sin copias disponibles';
	at: 0 put: '0 - Salir';
	yourself.

seguir:= true.

[seguir] whileTrue: [
	"Menu implementado con un diccionario que devuelve un numero (dependiendo la opcion) en vez de un string"
	op:= dicOp keyAtValue: (ChoicePrompter choices: (dicOp values asOrderedCollection) caption: 'Menu - Gestion de libros de la biblioteca').
        
	(op==1) ifTrue: [
		seg:=true.
		[seg] whileTrue: [
			choice := ChoicePrompter choices: #('Regular' 'Manual') caption: 'Elija el tipo de libro' .
			valido:=false.
			[valido] whileFalse: [
				nom:= (Prompter prompt:'Ingrese titulo del libro')asUppercase.
				(nom notEmpty) ifFalse: [MessageBox notify: 'El titulo no puede estar vacio'.] ifTrue: [valido:=true.].
			].
			valido:=false.
			[valido] whileFalse: [
				aniopub:= Prompter prompt: 'Ingrese anio de publicacion del libro'.
				((aniopub allSatisfy: [:c | c isDigit]) and: [aniopub asNumber <= Date today year]) ifFalse: [MessageBox notify: 'El anio de publicacion debe ser un numero y no puede ser mayor al anio actual'.] ifTrue: [aniopub:=aniopub asNumber. valido:=true.].
			].
			valido:=false.
			[valido] whileFalse: [
				genero:=(Prompter prompt:  'Ingrese genero del libro')asUppercase.
				(genero notEmpty) ifFalse: [MessageBox notify: 'El genero no puede estar vacio'.] ifTrue: [valido:=true.].
			].
			valido:=false.
			[valido] whileFalse: [
				codigo:=Prompter prompt:  'Ingrese codigo de identificacion del libro'.
				(codigo allSatisfy: [:c | c isDigit]) ifTrue: [
					codigo:=codigo asNumber.
					(biblio esVacia) ifFalse: [
						col:= biblio verTodos collect: [:l | l verCodigo].
						(col includes: codigo) ifTrue: [MessageBox notify: 'El codigo ya esta registrado en otro libro'.] ifFalse: [valido:=true.].
					] ifTrue: [valido:=true.].
				] ifFalse: [MessageBox notify: 'El codigo debe ser un numero'.].
			].
			valido:=false.
			[valido] whileFalse: [
				stock:=Prompter prompt: 'Ingrese cantidad de copias disponibles'.
				((stock allSatisfy: [:c | c isDigit]) and: [stock asNumber >= 0]) ifFalse: [MessageBox notify: 'La cantidad de copias debe ser un numero y no puede ser negativa'.] ifTrue: [stock:= stock asNumber. valido:=true.].
			].
			(choice='Regular') ifTrue: [
				libro:= LibroRegular crearLib: nom con: aniopub con: genero con: codigo con: stock.
			].
			(choice='Manual') ifTrue: [
				solicitado:= Prompter prompt: 'Ingrese cantidad de veces que fue solicitado'.
				((solicitado allSatisfy: [:c | c isDigit]) and: [solicitado asNumber >= 0]) ifFalse: [MessageBox notify: 'La cantidad de veces que fue solicitado debe ser un numero y no puede ser negativa'.] ifTrue: [valido:=true.].
				libro:=LibroManual crearLib: nom con: aniopub con: genero con: codigo con: stock con: solicitado.
			].
			biblio agregarLibro: libro.
			seg:=MessageBox confirm: 'Desea cargar otro libro?'.
			].
		].
	(op==2)  ifTrue: [ 
		(biblio esVacia) ifTrue: [MessageBox notify: 'No hay libros en la biblioteca'. seg:=false.] ifFalse: [seg:=true].
		[seg] whileTrue: [ 
			codigo:= Prompter prompt: 'Ingrese codigo del libro'.
			valido:=false.
			[valido] whileFalse: [
				(codigo allSatisfy: [:c | c isDigit]) ifTrue: [codigo:=codigo asNumber. valido:=true.] ifFalse: [MessageBox notify: 'El codigo debe ser un numero'.].
			].
			libro:= biblio verTodos detect: [:libro | (libro verCodigo) == codigo ] ifNone: [nil].
			(libro isNil) ifFalse: [
				Transcript clear; show; show: 'DATOS DEL LIBRO CON CODIGO ',(codigo displayString); cr; cr.
				listar value: libro.
	
			choice := ChoicePrompter choices: #('Modificar' 'Eliminar' 'Salir') caption: 'Que desea hacer con el libro?'.
			(choice= 'Modificar') ifTrue: [ 
				smod:=true.
				ops:= (libro class class == LibroRegular class) ifTrue: [#('Titulo' 'Genero' 'Codigo' 'Copias' 'Anio' 'Salir')] ifFalse: [#('Titulo' 'Genero' 'Codigo' 'Copias' 'Anio' 'Solicitado' 'Salir')].
				[smod] whileTrue: [ choicemod  := ChoicePrompter choices: ops caption: 'Que desea modificar?'.
				(choicemod= 'Titulo') ifTrue: [ 
										valido:=false.
										[valido] whileFalse: [
											nomnuevo:= (Prompter prompt:'Ingrese el nuevo titulo del libro')asUppercase.
											(nomnuevo notEmpty) ifFalse: [MessageBox notify: 'El titulo no puede estar vacio'.] ifTrue: [valido:=true.].
										].
										libro modTitulo: nomnuevo.
										Transcript show: 'Se ha cambiado el titulo con exito'; cr.
				].
				(choicemod= 'Genero') ifTrue: [
									valido:=false.
									[valido] whileFalse: [
										generonuevo:=(Prompter prompt:  'Ingrese el nuevo genero del libro')asUppercase.
										(generonuevo notEmpty) ifFalse: [MessageBox notify: 'El genero no puede estar vacio'.] ifTrue: [valido:=true.].
									].
									libro modGenero: generonuevo.
									Transcript show: 'Se ha cambiado el titulo con exito'; cr.
				].
				(choicemod= 'Codigo') ifTrue: [
									valido:=false.
									[valido] whileFalse: [
									codigonuevo:=Prompter prompt:  'Ingrese codigo de identificacion del libro'.
									(codigonuevo allSatisfy: [:c | c isDigit]) ifTrue: [
										codigonuevo:=codigonuevo asNumber.
										col:= biblio verTodos collect: [:l | l verCodigo].
										(col includes: codigonuevo) ifTrue: [MessageBox notify: 'El codigo ya esta registrado en otro libro'.] ifFalse: [valido:=true.].
									] ifFalse: [MessageBox notify: 'El codigo debe ser un numero'.].
									].
									libro modId: codigonuevo. 
									Transcript show: 'Se ha cambiado el codigo con exito'; cr. 
				].

				(choicemod='Copias') ifTrue: [
									valido:=false.
									[valido] whileFalse: [
										stocknuevo:=Prompter prompt: 'Ingrese la nueva cantidad de copias disponibles'.
										((stocknuevo allSatisfy: [:c | c isDigit]) and: [stocknuevo asNumber >= 0]) ifFalse: [MessageBox notify: 'La cantidad de copias debe ser un numero y no puede ser negativa'.] ifTrue: [valido:=true.].
									].
									libro modCopias: stocknuevo asNumber. 
									Transcript show: 'Se ha cambiado la cantidad de copias disponibles con exito'; cr.
				].
				(choicemod= 'Anio') ifTrue: [
									valido:=false.
									[valido] whileFalse: [
										anionuevo:= Prompter prompt: 'Ingrese el nuevo anio de publicacion del libro'.
										((anionuevo allSatisfy: [:c | c isDigit]) and: [anionuevo asNumber <= Date today year]) ifFalse: [MessageBox notify: 'El anio de publicacion debe ser un numero y no puede ser mayor al anio actual'.] ifTrue: [anionuevo:=anionuevo asNumber. valido:=true.].
									].
									libro modAnio: anionuevo. 
									Transcript show: 'Se a cambiado el anio con exito'; cr.
				].
				(choicemod='Solicitado') ifTrue: [
									valido:=false.
									[valido] whileFalse: [
										solnuevo:=Prompter prompt: 'Ingrese la nueva cantidad de veces que fue solicitado'.
										((solnuevo allSatisfy: [:c | c isDigit]) and: [solnuevo asNumber >= 0]) ifFalse: [MessageBox notify: 'La cantidad de veces que fue solicitado debe ser un numero y no puede ser negativa'.] ifTrue: [valido:=true.].
									].
									libro modSolicitado: solnuevo. 
									Transcript show: 'Se ha cambiado la cantidad de veces que fue solicitado con exito'; cr.
				].
				(choicemod='Salir') ifTrue: [smod:=false. ].
				].
			].
			(choice= 'Eliminar') ifTrue: [ biblio eliminarLibro: libro.
								Transcript show:'Libro eliminado con exito'; cr. 
			].
			(biblio esVacia) ifTrue: [seg:=false.] ifFalse: [seg:=MessageBox confirm: 'Desea buscar otro libro?'.].
			] ifTrue: [MessageBox notify: 'No existe un libro con ese codigo'.].
			
		].
	].


	(op==3) ifTrue: [ 
		(biblio esVacia) ifFalse: [ 	 
			col:= biblio verTodos.
			listarmasdecinco:= col select:[: libro | (libro verCopias) > 5].
			((listarmasdecinco size) > 0) ifTrue:[
				Transcript clear; show; show: 'LIBROS CON MAS DE 5 COPIAS DISPONIBLES:'; cr; cr.
				listarmasdecinco do: [: libro | listar value: libro.].
			] ifFalse:[MessageBox notify:'Error: No se encontraron libros que tengan una cantidad de copias mayor a 5']
		.] ifTrue:[MessageBox notify:'Error: La biblioteca esta vacia'].
	]. 

	(op==4) ifTrue: [
		(biblio esVacia) ifFalse: [ 	 
			col:= biblio verTodos.
			listarochentoso:= col select:[: libro | (libro verAnio) >= 1980 and: [(libro verAnio) <=1990]].
			((listarochentoso size) > 0) ifTrue:[ 
				Transcript clear; show; show: 'LIBROS OCHENTOSOS:'; cr; cr.
				listarochentoso do: [: libro | listar value: libro.].
			]ifFalse:[MessageBox notify:'Error: No hay libros ochentosos en la biblioteca'].
		] ifTrue:[MessageBox notify:'Error: La biblioteca esta vacia'].
    ]. 

	(op==5) ifTrue:[
		(biblio esVacia) ifFalse: [ 
			d:=Dictionary new.
			col:= biblio verTodos.
			genero:= col collect:[:libro | libro verGenero].
			generosinrepe:= genero asSet.
			Transcript clear; show; show: 'CANTIDAD DE LIBROS POR GENERO'; cr; cr.
			generosinrepe do:[: a | d at:a put:(genero occurrencesOf: a).
			Transcript show:('GENERO: ',a,' CANTIDAD: ', (d at:a) displayString); cr. ].
		]ifTrue:[MessageBox notify:'Error:No se puede buscar datos sobre el genero del libro, la biblioteca esta vacia'].
	]. 

	(op==6) ifTrue:[
		(biblio esVacia) ifFalse: [ 
			col:= biblio verTodos.
			sincopias:= col select:[: libro | (libro verCopias) = 0].
			((sincopias size) > 0) ifTrue: [
				Transcript clear; show; show: 'LIBROS SIN COPIAS:'; cr; cr.
				sincopias do:[: libro | listar value: libro.
							biblio eliminarLibro:libro.
							Transcript show:'Se ha eliminado el libro con exito';cr.].
			] ifFalse: [MessageBox notify: 'Error: No hay libros sin copias en la biblioteca'.].
		]ifTrue:[MessageBox notify:'Error: La biblioteca esta vacia'.].
	].

	 (op==0) ifTrue: [
		seguir:=false.
	].

].




