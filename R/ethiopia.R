
# starts: -----------------------------------------------------------------


# ethiopia - usd: -------------------------------------------------------------
# get data
ethiopia_usd <- function(){
  ethiopia_usd_url = "https://finance.yahoo.com/quote/ETB%3DX/history/"
  
  # getting link with data
  ethiopia_usd_historic_url <- data.frame(
    link = read_html(x = ethiopia_usd_url) %>% html_nodes("a") %>% html_attr("href")
  ) %>% 
    filter(
      grepl(pattern = "download", x = link)
    ) %>% 
    pull(link)
  
  # read data
  ethiopia_usd_data_raw = read_csv(file = ethiopia_usd_historic_url) %>% 
    mutate(currency = read_html(x = ethiopia_usd_url) %>% html_node("h1") %>% html_text()) %>% 
    clean_names() %>% 
    arrange(desc(date)) %>% 
    mutate(across(c("open", "high", "low", "close", "adj_close", "volume"),as.numeric))
  # export data
  write_csv(x = ethiopia_usd_data_raw, file = "data_raw/ethiopia_usd_data_raw.csv")
  write_rds(x = ethiopia_usd_data_raw, file = "data_raw/ethiopia_usd_data_raw.rds", compress = "xz")
  # return results
  return(ethiopia_usd_data_raw)
}

# export data
ethiopia_usd_data_final <- function(){
  if (file.exists("data_processed/ethiopia_usd_data_final.rds")) {
    ethiopia_usd_data_raw_previous <- readRDS(file = "data_processed/ethiopia_usd_data_final.rds")
    ethiopia_usd_data_raw_today <- readRDS(file = "data_raw/ethiopia_usd_data_raw.rds") 
    # final data
    ethiopia_usd_data_final <- rbind(ethiopia_usd_data_raw_today,ethiopia_usd_data_raw_previous) %>% distinct() %>% arrange(desc(date))
    # exporting data
    write_csv(x = ethiopia_usd_data_final, file = "data_processed/ethiopia_usd_data_final.csv")
    write_rds(x = ethiopia_usd_data_final, file = "data_processed/ethiopia_usd_data_final.rds", compress = "xz")
    
  }else{
    ethiopia_usd_data_raw_today <- readRDS(file = "data_raw/ethiopia_usd_data_raw.rds") 
    # final data
    ethiopia_usd_data_final <- ethiopia_usd_data_raw_today %>% arrange(desc(date))
    # exporting data
    write_csv(x = ethiopia_usd_data_final, file = "data_processed/ethiopia_usd_data_final.csv")
    write_rds(x = ethiopia_usd_data_final, file = "data_processed/ethiopia_usd_data_final.rds", compress = "xz")
  }
}

# ends: -------------------------------------------------------------------


