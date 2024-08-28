locals {
    // Generamos la variable environments si no hay varios entornos definidos
  environments = var.environments != null ? var.environments : {
    main = {
        name = ""
    }
  }
}