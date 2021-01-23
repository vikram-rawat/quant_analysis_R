
# load_library ------------------------------------------------------------

library(rvest)
library(magrittr)
library(data.table)
library(quanteda)
library(quanteda.corpora)
library(quanteda.dictionaries)
library(quanteda.textmodels)
library(stm)

# set defaults ------------------------------------------------------------

setDTthreads(0L)

# get data ----------------------------------------------------------------

reg_date <- Sys.Date()
year <- year(reg_date)
month <- month(reg_date)
mday <- data.table::mday(reg_date)

url <- sprintf(
  "https://www.dailyfx.com/forex/market_alert/%02d/%02d/%02d/Risk-Events-for-January-Why-the-Georgia-Senate-Runoff-is-Key-for-Financial-Markets.html",
  year,
  month,
  4
)

news_text <- read_html(url) |> 
  html_node(css = ".dfx-articleBody .dfx-articleBody__content") |> 
  html_text()

sec_token <- news_text |>
  corpus() |>
  tokens(
    what = "word",
    remove_punct = TRUE,
    remove_symbols = TRUE,
    remove_numbers = FALSE,
    remove_url = TRUE,
    remove_separators = TRUE,
    split_hyphens = TRUE,
    include_docvars = TRUE,
    padding = TRUE,
    verbose = quanteda_options("verbose")
  ) |>
  tokens_tolower() |>
  tokens_wordstem(
    language = "english"
  )

sec_dfm <- sec_token |>
  dfm(
    remove_numbers = FALSE, 
    remove_punct = TRUE, 
    remove_symbols = TRUE, 
    remove = stopwords("english")
  ) |>
  dfm_trim(
    # min_docfreq = 0.05, 
    # max_docfreq = 0.90, 
    docfreq_type = "prop"
  )

topic_count <- 2

sec_stm <- sec_dfm |>
  convert(
    to = "stm"
  )

stm_model_sec <- stm(
  documents = sec_stm$documents,
  vocab = sec_stm$vocab,
  K = topic_count,
  data = sec_stm$meta,
  init.type = "Random")

stm_model_sec$version

# plot(stm_model_sec,
#      type = "perspectives",
#      text.cex = 0.5)

