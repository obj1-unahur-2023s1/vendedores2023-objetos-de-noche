import provincia.*
import certificaciones.*

class VendedorFijo {
	const property ciudad
	const property certificaciones = []
	
	method provincia() = ciudad.provincia()
	method puedeTrabajar(unaCiudad) = ciudad == unaCiudad
	method esVersatil() = certificaciones.size() >= 3 && 
						  certificaciones.any({c=>c.esProducto()}) &&
						  certificaciones.any({c=>!c.esProducto()})
//	method esFirme() = certificaciones.sum({c=>c.puntos()}) >= 30
	method esFirme() = certificaciones.map({c=>c.puntos()}).sum() >= 30
	method esInfluyente() = false
}

class VendedorViajante {
	const property provincias = []
	//const property ciudad
	const property certificaciones = []
	
	method puedeTrabajar(unaCiudad) = provincias.contains(unaCiudad.provincia())
	method esVersatil() = certificaciones.size() >= 3 && 
						  certificaciones.any({c=>c.esProducto()}) &&
						  certificaciones.any({c=>!c.esProducto()})
	method esFirme() = certificaciones.sum({c=>c.puntos()}) >= 30
	method esInfluyente() = provincias.sum({p=>p.poblacion()}) >= 10
}

class ComercioCorresponsal {
	const property ciudad = []
	const property certificaciones = []

	method puedeTrabajar(unaCiudad) = ciudad.contains(unaCiudad)
	method agregarCiudad(unaCiudad) {ciudad.add(unaCiudad)}
	method esVersatil() = certificaciones.size() >= 3 && 
						  certificaciones.any({c=>c.esProducto()}) &&
						  certificaciones.any({c=>!c.esProducto()})
	method esFirme() = certificaciones.sum({c=>c.puntos()}) >= 30
	method esInfluyente() = ciudad.size() >= 5 || 
							self.provinciasConSucursales().size() >= 3
//separar en metodos						
	method provinciasConSucursales() = ciudad.map({c=>c.provincia()}).asSet()
}

