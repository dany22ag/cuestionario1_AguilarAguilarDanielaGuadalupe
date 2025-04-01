library(dplyr)

clientes <- read.csv("clientes.csv")  # Cargar dataset de clientes
compras <- read.csv("compras.csv")    # Cargar dataset de compras

fusionado <- left_join(clientes, compras, by = "id_cliente")

fusionado <- fusionado %>% distinct()

# Verificar claves duplicadas
duplicados <- fusionado %>% group_by(id_cliente) %>% filter(n() > 1)
print(duplicados)

# Verificar valores faltantes
faltantes <- colSums(is.na(fusionado))
print(faltantes)

# Consulta de resumen
resumen <- fusionado %>%
  group_by(id_cliente) %>%
  summarise(total_compras = n(),
            monto_total = sum(monto, na.rm = TRUE))

print(resumen)
