
# get data from world bank --------
# written by        : Vikram Singh Rawat
# date written      : 21-mar-2021
# purpose           : get data from world bank api of a perticular country
# desc              : using webstat package generating regex to send in API

get_wbi_count <- function(
  indicator,
  country_id
){
  
  regex_chr <- sprintf(
    fmt = "%s.*%s",
    indicator,
    country_id) |>
    toupper()
  
  indicators <- wb_search(
    pattern = regex_chr,
    cache = new_wb_cache,
    ignore.case = FALSE)
  
  country_data <- wb_data(
    indicator = indicators$indicator_id,
    country = "IN")
  
  return(country_data)
  
}
