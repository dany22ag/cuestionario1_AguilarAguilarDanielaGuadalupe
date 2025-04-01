
data <- read.csv("data.csv")
# Identificar valores faltantes
print(summary(data)) # Muestra un resumen de las columnas, incluyendo cuántos NA hay en cada una
print(is.na(data))  # Devuelve una matriz booleana indicando dónde están los NA

# Manejar valores faltantes media
for (col in colnames(data)) {
  if (any(is.na(data[[col]]))) {
    if (is.numeric(data[[col]])) {
      media_col <- mean(data[[col]], na.rm = TRUE)
      data[[col]] <- ifelse(is.na(data[[col]]), media_col, data[[col]])
    } else {
      # Si no es numérico, imputar con la moda 
      tabla_freq <- table(data[[col]])
      moda_col <- names(tabla_freq[which.max(tabla_freq)])
      data[[col]] <- ifelse(is.na(data[[col]]), moda_col, data[[col]])
    }
  }
}

print(duplicated(data)) # Devuelve un vector booleano indicando si cada fila es duplicada

# Eliminar valores duplicados
data_sin_duplicados <- distinct(data) # Usando la función distinct() del paquete dplyr

# Estandarizar nombres convertir a minúsculas y eliminar espacios extra)
if ("nombre_producto" %in% colnames(data)) {
  data$nombre_producto <- tolower(trimws(data$nombre_producto))
}

