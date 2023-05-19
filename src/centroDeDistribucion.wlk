class CentroDeDistribucion {
	const property ciudad
	const property vendedores = []
	
	method agregarVendedor(vendedor) {
		if (!vendedores.contains(vendedor)) {vendedores.add(vendedor)}
		else {vendedor.error("este vendedor ya está registrado")}
	}
	method vendedorEstrella() = vendedores.max({v=>v.puntaje()})
	method puedeCubrir(unaCiudad) = vendedores.any({v=>v.puedeTrabajar(unaCiudad)})
	method vendedoresGenericos() = vendedores.filter({v=>v.tieneCertificacionNoProducto()})
	method esRobusto() = vendedores.count({v=>v.esFirme()}) >=3
	method repartirCertificacion(unaCertificacion) {vendedores.forEach({v=>v.agregarCertificacion(unaCertificacion)})}
	
}
