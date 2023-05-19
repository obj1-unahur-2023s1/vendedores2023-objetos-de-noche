import vendedores.*

class Cliente {
	const property tipoCliente 
	
	method puedeSerAtendido(unVendedor) = tipoCliente.puedeSerAtendido(unVendedor)
	
}

object inseguro {
	
	method puedeSerAtendido(unVendedor) = unVendedor.esVersatil() && unVendedor.esFirme()
}

object detallista {
	
	method puedeSerAtendido(unVendedor) = unVendedor.certificaciones().count({c=>c.esProducto()})
}

object humanista {
	
	method puedeSerAtendido(unVendedor) = unVendedor.esPersonaFisica()
}

