library(ggplot2)
library(tidyr)

datos <- read.csv("C:/Users/DANIELAGUADALUPEAGUI/OneDrive - TECNOLOGICO DE ESTUDIOS SUPERIORES DE IXTAPALUCA/Documentos/TESI/OCTAVO SEMESTRE/ANALISIS Y MODELADO DE DATOS/equipo/empresa.csv")
head(datos)

#aqui pongo codigo para estandarizar datos con la funcion de scale()
columnas_numericas <- datos[, c("Ingresos", "utilidadNeta", "margenNeto", "ROE", "Liquidez", "Endeudamiento", "PERatio")]
datos_estandarizados <- as.data.frame(scale(columnas_numericas))
head(datos_estandarizados)

#aqui pongo codigo para aplicar normalizacion utilizando la formula
normalizar <- function(x) {
  (x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))
}
datos_normalizados <- as.data.frame(lapply(columnas_numericas, normalizar))
head(datos_normalizados)

#aqui voy a hacer la compracion entre ambos metodos utilizados recientemente
resumen_estandarizado <- summary(datos_estandarizados)
resumen_normalizado <- summary(datos_normalizados)

cat("Estadísticas descriptivas de datos estandarizados:\n")
print(resumen_estandarizado)

cat("\nEstadísticas descriptivas de datos normalizados:\n")
print(resumen_normalizado)

df_comparacion <- data.frame(
  Original = columnas_numericas$Ingresos,
  Estandarizado = datos_estandarizados$Ingresos,
  Normalizado = datos_normalizados$Ingresos
)

df_largo <- pivot_longer(df_comparacion, cols = everything(), names_to = "Método", values_to = "Valores")

ggplot(df_largo, aes(x = Valores, fill = Método)) +
  geom_density(alpha = 0.5) +
  labs(title = "Distribución: Estandarización vs. Normalización", x = "Valores", y = "Densidad") +
  theme_minimal()

