
library(dplyr)
clientes <- read.csv("clientes.csv")
compras <- read.csv("compras.csv")  

fusionado <- merge(clientes, compras, by = "id_cliente", all = TRUE)

duplicados <- fusionado %>% group_by(id_cliente) %>% filter(n() > 1)
print(duplicados)
# Verificar valores faltantes
faltantes <- colSums(is.na(fusionado))
print(faltantes)
resumen <- fusionado %>%
  group_by(id_cliente) %>%
  summarise(total_compras = n(),
            monto_total = sum(monto, na.rm = TRUE))

print(resumen)

