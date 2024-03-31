
# starts: -----------------------------------------------------------------


# rwanda - usd: -------------------------------------------------------------
# get data
rwanda_usd <- function(){
  rwanda_usd_url = "https://finance.yahoo.com/quote/RWF%3DX/history/"
  
  # getting link with data
  rwanda_usd_historic_url <- data.frame(
    link = read_html(x = rwanda_usd_url) %>% html_nodes("a") %>% html_attr("href")
  ) %>% 
    filter(
      grepl(pattern = "download", x = link)
    ) %>% 
    pull(link)
  
  # read data
  rwanda_usd_data_raw = read_csv(file = rwanda_usd_historic_url) %>% 
    mutate(currency = read_html(x = rwanda_usd_url) %>% html_node("h1") %>% html_text()) %>% 
    clean_names() %>% 
    arrange(desc(date)) %>% 
    mutate(across(c("open", "high", "low", "close", "adj_close", "volume"),as.numeric))
  # export data
  write_csv(x = rwanda_usd_data_raw, file = "data_raw/rwanda_usd_data_raw.csv")
  write_rds(x = rwanda_usd_data_raw, file = "data_raw/rwanda_usd_data_raw.rds", compress = "xz")
  # return results
  return(rwanda_usd_data_raw)
}

# export data
rwanda_usd_data_final <- function(){
  if (file.exists("data_processed/rwanda_usd_data_final.rds")) {
    rwanda_usd_data_raw_previous <- readRDS(file = "data_processed/rwanda_usd_data_final.rds")
    rwanda_usd_data_raw_today <- readRDS(file = "data_raw/rwanda_usd_data_raw.rds") 
    # final data
    rwanda_usd_data_final <- rbind(rwanda_usd_data_raw_today,rwanda_usd_data_raw_previous) %>% distinct() %>% arrange(desc(date))
    # exporting data
    write_csv(x = rwanda_usd_data_final, file = "data_processed/rwanda_usd_data_final.csv")
    write_rds(x = rwanda_usd_data_final, file = "data_processed/rwanda_usd_data_final.rds", compress = "xz")
    
  }else{
    rwanda_usd_data_raw_today <- readRDS(file = "data_raw/rwanda_usd_data_raw.rds") 
    # final data
    rwanda_usd_data_final <- rwanda_usd_data_raw_today %>% arrange(desc(date))
    # exporting data
    write_csv(x = rwanda_usd_data_final, file = "data_processed/rwanda_usd_data_final.csv")
    write_rds(x = rwanda_usd_data_final, file = "data_processed/rwanda_usd_data_final.rds", compress = "xz")
  }
}

# ends: -------------------------------------------------------------------


