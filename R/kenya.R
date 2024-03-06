
# starts: -----------------------------------------------------------------


# kshs - usd: -------------------------------------------------------------
# get data
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

# export data
kshs_usd_data_final <- function(){
  if (file.exists("data_processed/kshs_usd_data_final.rds")) {
    kshs_usd_data_raw_previous <- readRDS(file = "data_processed/kshs_usd_data_final.rds")
    kshs_usd_data_raw_today <- readRDS(file = "data_raw/kshs_usd_data_raw.rds") 
    # final data
    kshs_usd_data_final <- rbind(kshs_usd_data_raw_today,kshs_usd_data_raw_previous) %>% distinct() %>% arrange(desc(date))
    # exporting data
    write_csv(x = kshs_usd_data_final, file = "data_processed/kshs_usd_data_final.csv")
    write_rds(x = kshs_usd_data_final, file = "data_processed/kshs_usd_data_final.rds", compress = "xz")
    
  }else{
    kshs_usd_data_raw_today <- readRDS(file = "data_raw/kshs_usd_data_raw.rds") 
    # final data
    kshs_usd_data_final <- kshs_usd_data_raw_today %>% arrange(desc(date))
    # exporting data
    write_csv(x = kshs_usd_data_final, file = "data_processed/kshs_usd_data_final.csv")
    write_rds(x = kshs_usd_data_final, file = "data_processed/kshs_usd_data_final.rds", compress = "xz")
  }
}

# ends: -------------------------------------------------------------------


