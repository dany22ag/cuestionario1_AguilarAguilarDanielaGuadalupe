
library(dplyr)
red<-read.csv("C:/Users/DANIELAGUADALUPEAGUI/OneDrive - TECNOLOGICO DE ESTUDIOS SUPERIORES DE IXTAPALUCA/Documentos/TESI/OCTAVO SEMESTRE/ANALISIS Y MODELADO DE DATOS/equipo/redesociales.csv")
str(red)

#aqui pongo codigo para conversion de variables categoricas en factores
red$tipoInteraccion <- as.factor(red$tipoInteraccion)
red$plataforma <- as.factor(red$plataforma)
red$nombreUsuario <- as.factor(red$nombreUsuario)
red$contenido <- as.factor(red$contenido)

#aqui pongo el codigo para la conversion de la fecha a un formato adecuado
if (!inherits(red$fecha, "Date")) {
  red$fecha <- as.Date(red$fecha, tryFormats = c("%d/%m/%Y", "%Y-%m-%d", "%m/%d/%Y"))
}

#aqui pongo el codigo para realizar la normalizacion de valores numericos
normalizar_minmax <- function(x) {
  return((x - min(x, na.rm=TRUE)) / (max(x, na.rm=TRUE) - min(x, na.rm=TRUE)))
}

red$numeroInteracciones <- normalizar_minmax(red$numeroInteracciones)

summary(red$numeroInteracciones)

#aqui pongo el codigo para la creacion de variables derivadas
red$diaSemana <- weekdays(red$fecha)
red$mes <- format(red$fecha, "%m")
red$anio <- format(red$fecha, "%Y")
red$diasDesdePrimera <- as.numeric(red$fecha - min(red$fecha, na.rm=TRUE))

if (sum(!is.na(red$numeroInteracciones)) > 0) {
  red$numeroInteraccionesNorm <- normalizar_minmax(red$numeroInteracciones)
}

if (sum(!is.na(red$numeroInteracciones)) > 0) {
  red$nivelInteraccion <- ifelse(
    red$numeroInteracciones > median(red$numeroInteracciones, na.rm=TRUE), 
    "Alta", "Baja"
  )
  red$nivelInteraccion <- as.factor(red$nivelInteraccion)
}

red$longitudContenido <- ifelse(is.na(red$contenido), NA, nchar(as.character(red$contenido)))

red$palabrasContenido <- ifelse(is.na(red$contenido), NA, sapply(strsplit(as.character(red$contenido), " "), length))

red <- red %>%
  group_by(nombreUsuario) %>%
  mutate(frecuenciaInteraccion = sum(!is.na(nombreUsuario))) %>%
  ungroup()

