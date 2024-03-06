
# starts: -----------------------------------------------------------------


# kshs - usd: -------------------------------------------------------------

kshs_usd <- function(){
  kshs_usd_url = "https://finance.yahoo.com/quote/KES%3DX/history/"
  
  # getting link with data
  kshs_usd_historic_url <- data.frame(
    link = read_html(x = kshs_usd_url) %>% html_nodes("a") %>% html_attr("href")
  ) %>% 
    filter(
      grepl(pattern = "download", x = link)
    ) %>% 
    pull(link)
  
  # read data
  kshs_usd_data_raw = read_csv(file = kshs_usd_historic_url) %>% 
    mutate(currency = read_html(x = kshs_usd_url) %>% html_node("h1") %>% html_text()) %>% 
    clean_names() %>% 
    arrange(desc(date))
  # export data
  write_csv(x = kshs_usd_data_raw, file = "data_raw/kshs_usd_data_raw.csv")
  write_rds(x = kshs_usd_data_raw, file = "data_raw/kshs_usd_data_raw.rds", compress = "xz")
  # return results
  return(kshs_usd_data_raw)
}


# ends: -------------------------------------------------------------------


