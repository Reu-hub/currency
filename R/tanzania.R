
# starts: -----------------------------------------------------------------


# tzshs - usd: -------------------------------------------------------------
# get data
tzshs_usd <- function(){
  tzshs_usd_url = "https://finance.yahoo.com/quote/UGX%3DX/history/"
  
  # getting link with data
  tzshs_usd_historic_url <- data.frame(
    link = read_html(x = tzshs_usd_url) %>% html_nodes("a") %>% html_attr("href")
  ) %>% 
    filter(
      grepl(pattern = "download", x = link)
    ) %>% 
    pull(link)
  
  # read data
  tzshs_usd_data_raw = read_csv(file = tzshs_usd_historic_url) %>% 
    mutate(currency = read_html(x = tzshs_usd_url) %>% html_node("h1") %>% html_text()) %>% 
    clean_names() %>% 
    arrange(desc(date)) %>% 
    mutate(across(c("open", "high", "low", "close", "adj_close", "volume"),as.numeric))
  # export data
  write_csv(x = tzshs_usd_data_raw, file = "data_raw/tzshs_usd_data_raw.csv")
  write_rds(x = tzshs_usd_data_raw, file = "data_raw/tzshs_usd_data_raw.rds", compress = "xz")
  # return results
  return(tzshs_usd_data_raw)
}

# export data
tzshs_usd_data_final <- function(){
  if (file.exists("data_processed/tzshs_usd_data_final.rds")) {
    tzshs_usd_data_raw_previous <- readRDS(file = "data_processed/tzshs_usd_data_final.rds")
    tzshs_usd_data_raw_today <- readRDS(file = "data_raw/tzshs_usd_data_raw.rds") 
    # final data
    tzshs_usd_data_final <- rbind(tzshs_usd_data_raw_today,tzshs_usd_data_raw_previous) %>% distinct() %>% arrange(desc(date))
    # exporting data
    write_csv(x = tzshs_usd_data_final, file = "data_processed/tzshs_usd_data_final.csv")
    write_rds(x = tzshs_usd_data_final, file = "data_processed/tzshs_usd_data_final.rds", compress = "xz")
    
  }else{
    tzshs_usd_data_raw_today <- readRDS(file = "data_raw/tzshs_usd_data_raw.rds") 
    # final data
    tzshs_usd_data_final <- tzshs_usd_data_raw_today %>% arrange(desc(date))
    # exporting data
    write_csv(x = tzshs_usd_data_final, file = "data_processed/tzshs_usd_data_final.csv")
    write_rds(x = tzshs_usd_data_final, file = "data_processed/tzshs_usd_data_final.rds", compress = "xz")
  }
}

# ends: -------------------------------------------------------------------


