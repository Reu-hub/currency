
# starts: -----------------------------------------------------------------


# ugshs - usd: -------------------------------------------------------------
# get data
ugshs_usd <- function(){
  ugshs_usd_url = "https://finance.yahoo.com/quote/UGX%3DX/history/"
  
  # getting link with data
  ugshs_usd_historic_url <- data.frame(
    link = read_html(x = ugshs_usd_url) %>% html_nodes("a") %>% html_attr("href")
  ) %>% 
    filter(
      grepl(pattern = "download", x = link)
    ) %>% 
    pull(link)
  
  # read data
  ugshs_usd_data_raw = read_csv(file = ugshs_usd_historic_url) %>% 
    mutate(currency = read_html(x = ugshs_usd_url) %>% html_node("h1") %>% html_text()) %>% 
    clean_names() %>% 
    arrange(desc(date)) %>% 
    mutate(across(c("open", "high", "low", "close", "adj_close", "volume"),as.numeric))
  # export data
  write_csv(x = ugshs_usd_data_raw, file = "data_raw/ugshs_usd_data_raw.csv")
  write_rds(x = ugshs_usd_data_raw, file = "data_raw/ugshs_usd_data_raw.rds", compress = "xz")
  # return results
  return(ugshs_usd_data_raw)
}

# export data
ugshs_usd_data_final <- function(){
  if (file.exists("data_processed/ugshs_usd_data_final.rds")) {
    ugshs_usd_data_raw_previous <- readRDS(file = "data_processed/ugshs_usd_data_final.rds")
    ugshs_usd_data_raw_today <- readRDS(file = "data_raw/ugshs_usd_data_raw.rds") 
    # final data
    ugshs_usd_data_final <- rbind(ugshs_usd_data_raw_today,ugshs_usd_data_raw_previous) %>% distinct() %>% arrange(desc(date))
    # exporting data
    write_csv(x = ugshs_usd_data_final, file = "data_processed/ugshs_usd_data_final.csv")
    write_rds(x = ugshs_usd_data_final, file = "data_processed/ugshs_usd_data_final.rds", compress = "xz")
    
  }else{
    ugshs_usd_data_raw_today <- readRDS(file = "data_raw/ugshs_usd_data_raw.rds") 
    # final data
    ugshs_usd_data_final <- ugshs_usd_data_raw_today %>% arrange(desc(date))
    # exporting data
    write_csv(x = ugshs_usd_data_final, file = "data_processed/ugshs_usd_data_final.csv")
    write_rds(x = ugshs_usd_data_final, file = "data_processed/ugshs_usd_data_final.rds", compress = "xz")
  }
}

# ends: -------------------------------------------------------------------


