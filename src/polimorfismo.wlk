object paquete {

	var property cantidadPersonas = 1 
	var property servicioOfrecido = servicioCombinado 
	var property premium = false 
	var reservado = false

	method estaReservado() {
		return reservado
	}

	method sePuedeReservar() {
		return not self.estaReservado() and servicioOfrecido.sePuedeReservar(self)
	}

	method reservar() {
		servicioOfrecido.reservar(self)
		reservado = true
	}

}

object hotel {

	var property camasDisponibles = 30 
	var property estrellas = 1 
	var property spaDisponible = true 
	
	method sePuedeReservar(_paquete) {

		return self.camasDisponibles() >= _paquete.cantidadPersonas() and 
					(not _paquete.premium() or (self.estrellas() >= 4 and self.spaDisponible())) 
	}	
	
	method reservar(_paquete) {
		self.camasDisponibles(self.camasDisponibles() - _paquete.cantidadPersonas())
		if (_paquete.premium()) {
				self.reservarSpa()
		}		
	}

	method reservarSpa() {
		spaDisponible = false
	}
}

object vehiculo {
	
	var property asientosDisponibles = 10 
	var property aireAcondicionado = false 
	var property vtv = true 
	
	method sePuedeReservar(_paquete) {
		return self.asientosDisponibles() >= _paquete.cantidadPersonas() 
				and self.tieneVTV() and (not _paquete.premium() or self.tieneAireAcondicionado())	
	}
	
	method reservar(_paquete) {
		self.asientosDisponibles(self.asientosDisponibles() - _paquete.cantidadPersonas())
	}

	method tieneAireAcondicionado() {
		return aireAcondicionado
	}

	method tieneVTV() {
		return vtv
	}
}

object servicioCombinado {

	var property servicioHotel = hotel
	var property traslado = vehiculo

	method sePuedeReservar(_paquete) {
		
		return servicioHotel.sePuedeReservar(_paquete) and 
				traslado.sePuedeReservar(_paquete)
	}

	method reservar(_paquete) {
		traslado.reservar(_paquete)
		servicioHotel.reservar(_paquete)
	}
}

