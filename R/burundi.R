
# starts: -----------------------------------------------------------------


# burundi - usd: -------------------------------------------------------------
# get data
burundi_usd <- function(){
  burundi_usd_url = "https://finance.yahoo.com/quote/UGX%3DX/history/"
  
  # getting link with data
  burundi_usd_historic_url <- data.frame(
    link = read_html(x = burundi_usd_url) %>% html_nodes("a") %>% html_attr("href")
  ) %>% 
    filter(
      grepl(pattern = "download", x = link)
    ) %>% 
    pull(link)
  
  # read data
  burundi_usd_data_raw = read_csv(file = burundi_usd_historic_url) %>% 
    mutate(currency = read_html(x = burundi_usd_url) %>% html_node("h1") %>% html_text()) %>% 
    clean_names() %>% 
    arrange(desc(date)) %>% 
    mutate(across(c("open", "high", "low", "close", "adj_close", "volume"),as.numeric))
  # export data
  write_csv(x = burundi_usd_data_raw, file = "data_raw/burundi_usd_data_raw.csv")
  write_rds(x = burundi_usd_data_raw, file = "data_raw/burundi_usd_data_raw.rds", compress = "xz")
  # return results
  return(burundi_usd_data_raw)
}

# export data
burundi_usd_data_final <- function(){
  if (file.exists("data_processed/burundi_usd_data_final.rds")) {
    burundi_usd_data_raw_previous <- readRDS(file = "data_processed/burundi_usd_data_final.rds")
    burundi_usd_data_raw_today <- readRDS(file = "data_raw/burundi_usd_data_raw.rds") 
    # final data
    burundi_usd_data_final <- rbind(burundi_usd_data_raw_today,burundi_usd_data_raw_previous) %>% distinct() %>% arrange(desc(date))
    # exporting data
    write_csv(x = burundi_usd_data_final, file = "data_processed/burundi_usd_data_final.csv")
    write_rds(x = burundi_usd_data_final, file = "data_processed/burundi_usd_data_final.rds", compress = "xz")
    
  }else{
    burundi_usd_data_raw_today <- readRDS(file = "data_raw/burundi_usd_data_raw.rds") 
    # final data
    burundi_usd_data_final <- burundi_usd_data_raw_today %>% arrange(desc(date))
    # exporting data
    write_csv(x = burundi_usd_data_final, file = "data_processed/burundi_usd_data_final.csv")
    write_rds(x = burundi_usd_data_final, file = "data_processed/burundi_usd_data_final.rds", compress = "xz")
  }
}

# ends: -------------------------------------------------------------------


