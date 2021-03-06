#------------------------------------------------------------------------------
# list of community with df of most said keywords
#------------------------------------------------------------------------------
count_keyword_freq_foreach_bccommunity <- function(WOS_table) {
  library(plyr)
  community_quantity <- max(WOS_table$record_community,na.rm =T)
  keyword_per_X_community        <- as.list(1:community_quantity)
  for (i in 1:community_quantity) {
    sub_WOS_table <- subset(WOS_table, record_community == i)
    keyword_current_bccom <- tolower(unlist(strsplit(unlist(sub_WOS_table$DE), "[;][ ]")))
    keyword_current_bccom2 <- tolower(unlist(strsplit(unlist(sub_WOS_table$ID), "[;][ ]")))
    keyword_current_bccom3 <- c(keyword_current_bccom,keyword_current_bccom2)
    keyword_current_bccom3 <- as.factor(keyword_current_bccom3)
    freq_table_keyword <- count(keyword_current_bccom3)
    ordering_command               <- with(freq_table_keyword, order(-freq))
    freq_table_keyword              <- freq_table_keyword[ordering_command, ]
    names(freq_table_keyword) <- c("Keyword", "Frequency")
    keyword_per_X_community[[i]] <- freq_table_keyword
  }
  keyword_total <- c(tolower(unlist(strsplit(unlist(WOS_table$DE), "[;][ ]"))),
                        tolower(unlist(strsplit(unlist(WOS_table$ID), "[;][ ]"))))
  keyword_total <- as.factor(keyword_total)
  freq_table_keyword <- count(keyword_total)
  ordering_command               <- with(freq_table_keyword, order(-freq))
  freq_table_keyword              <- freq_table_keyword[ordering_command, ]
  names(freq_table_keyword) <- c("Keyword", "Frequency")
  keyword_per_X_community[[community_quantity+1]] <- freq_table_keyword
  return(keyword_per_X_community)
}
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
