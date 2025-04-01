Library(tidyverse)
Library(VIM)
Library(naniar)
File.choose()
Hospital=read.csv(“C:\\Users\\edgar\\OneDrive\\Escritorio\\Custionario\\LOPEZ
                   JAIMESEDGARFELIPE\\hospital.csv”)
View(hospital)
# Verificar cuántos valores faltantes hay en todo el dataset
Sum(is.na(hospital)) # Total de valores faltantes en el dataset
# Verificar cuántos valores faltantes hay en cada columna
colSums(is.na(hospital)) # Cantidad de valores faltantes por columna
# Resumen estadístico del dataset, incluyendo los valores faltantes
Summary(hospital)
# Eliminar registros con valores faltantes
Hospital_limpio_naomit <- na.omit(hospital)
# Ver el resultado
View(hospital_limpio_naomit)
# Imputación con la media paara las columnas de interés
Hospital_imputado_media <- hospital %>%
  Mutate(
    Presion_arterial = replace_na(Presion_arterial, mean(Presion_arterial, na.rm
                                                         = TRUE)),
    Glucosa = replace_na(Glucosa, mean(Glucosa, na.rm = TRUE))
  )
# Ver los datos después de imputar con la media
Cat(“Número de registros después de la imputación: “,
     nrow(hospital_imputado_media), “\n”)
View(hospital_imputado_media)
} else {
  Cat(“Las columnas ‘Presion_arterial’ y ‘Glucosa’ no están presentes en el
       dataset.\n”)
}