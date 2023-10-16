vol_qry <- function(id, from, to){
  id_str <- glue::glue("\"{id}\"")
  from_str <- glue::glue("\"{from}\"")
  to_str <- glue::glue("\"{to}\"")
  glue::glue("
{
  trafficData(trafficRegistrationPointId: <<id_str>>) {
    volume {
      byHour(from: <<from_str>>, to: <<to_str>>) {
        edges {
          node {
            from
            to
            total {
              volumeNumbers {
                volume
              }
            }
          }
        }
      }
    }
  }
}
  ", .open = "<<", .close = ">>")
}