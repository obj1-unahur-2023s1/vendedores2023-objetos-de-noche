import provincia.*
import certificaciones.*
import centroDeDistribucion.*

class VendedorFijo {
	const property ciudad = []
	const property certificaciones = []
	
	method puedeTrabajar(unaCiudad) = ciudad == unaCiudad
	method esVersatil() = certificaciones.size() >= 3 && 
						  self.tieneCertificacionProducto() &&
						  self.tieneCertificacionNoProducto()
//	method esFirme() = certificaciones.sum({c=>c.puntos()}) >= 30
	method esFirme() = self.puntaje() >= 30
	method esInfluyente() = false
	method puntaje() = certificaciones.sum({c=>c.puntos()}) 
	method tieneCertificacionProducto() = certificaciones.any({c=>c.esProducto()}) 
	method tieneCertificacionNoProducto() = certificaciones.any({c=>!c.esProducto()})
	method agregarCertificacion(unaCertificacion) {certificaciones.add(unaCertificacion)}
	method tieneAfinidad(unCentro) = self.puedeTrabajar(unCentro.ciudad())
	method esCandidato(unCentro) = self.esVersatil() && self.tieneAfinidad(unCentro)
	method esPersonaFisica() = true
}

class VendedorViajante {
	const property provincias = []
	//const property ciudad
	const property certificaciones = []
	
	method puedeTrabajar(unaCiudad) = provincias.contains(unaCiudad.provincia())
	method esVersatil() = certificaciones.size() >= 3 && 
						  self.tieneCertificacionProducto() &&
						  self.tieneCertificacionNoProducto()
	method esFirme() = self.puntaje() >= 30
	method esInfluyente() = provincias.sum({p=>p.poblacion()}) >= 10
	method puntaje() = certificaciones.sum({c=>c.puntos()})
	method tieneCertificacionProducto() = certificaciones.any({c=>c.esProducto()}) 
	method tieneCertificacionNoProducto() = certificaciones.any({c=>!c.esProducto()})
	method agregarCertificacion(unaCertificacion) {certificaciones.add(unaCertificacion)}
	method tieneAfinidad(unCentro) = self.puedeTrabajar(unCentro.ciudad())
	method esCandidato(unCentro) = self.esVersatil() && self.tieneAfinidad(unCentro)
	method esPersonaFisica() = true
}

class ComercioCorresponsal {
	const property ciudad = []
	const property certificaciones = []

	method puedeTrabajar(unaCiudad) = ciudad.contains(unaCiudad)
	method agregarCiudad(unaCiudad) {ciudad.add(unaCiudad)}
	method esVersatil() = certificaciones.size() >= 3 && 
						  self.tieneCertificacionProducto() &&
						  self.tieneCertificacionNoProducto()
	method esFirme() = self.puntaje() >= 30
	method esInfluyente() = ciudad.size() >= 5 || 
							self.provinciasConSucursales().size() >= 3
//separar en metodos						
	method provinciasConSucursales() = ciudad.map({c=>c.provincia()}).asSet()
	method puntaje() = certificaciones.sum({c=>c.puntos()}) 
	method tieneCertificacionProducto() = certificaciones.any({c=>c.esProducto()}) 
	method tieneCertificacionNoProducto() = certificaciones.any({c=>!c.esProducto()})
	method agregarCertificacion(unaCertificacion) {certificaciones.add(unaCertificacion)}
	method tieneAfinidad(unCentro) = self.puedeTrabajar(unCentro.ciudad()) &&
									 ciudad.any({c=>!unCentro.puedeCubrir(c)})
	method esCandidato(unCentro) = self.esVersatil() && self.tieneAfinidad(unCentro)
	method esPersonaFisica() = false
}

