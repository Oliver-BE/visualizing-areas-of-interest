raw_apex_df <- gsheet2tbl("https://docs.google.com/spreadsheets/d/1v40AgpaoRrA3v5eEjztB5Rw_OGKRHw3L56hhJdzdqAs/edit#gid=13184181") 

# initial cleaning: get rid of rows with all NAs, clean up survival time, etc. 
apex_df <- filter(raw_apex_df, rowSums(is.na(raw_apex_df)) != ncol(raw_apex_df)) %>% 
  mutate(Timestamp_raw = parse_date_time(Timestamp, orders = "mdy HMS", tz = "EST"),
         Timestamp = as.character(Timestamp_raw),
         survival_time_dt = strptime(`Survival Time`, format = "%M:%S"),
         `Survival Time (min)` = round(minute(survival_time_dt) + second(survival_time_dt) / 60, digits = 2)) %>% 
  select(-c(X9, X10, survival_time_dt, `Survival Time`)) # %>%
  # arrange(desc(Timestamp))  

# summary stats df
summary_stats_df <- apex_df %>% 
  group_by(Player) %>% 
  summarize(`Num Games Played` = n(),
            `Num Wins` = sum(ifelse(`Squad Placed` == 1, TRUE, FALSE)),
            `Total Damage` = sum(Damage),
            `Total Kills` = sum(Kills),
            `Total Assists` = sum(Assists),
            `Total Knocks` = sum(Knocks),
            `Total Survival Time` = sum(`Survival Time (min)`),
            `KDR` = round(`Total Kills` / `Num Games Played`, 2),
            `Damage Per Game` = round(`Total Damage` / `Num Games Played`, 0),
            `Damage Per Minute` = round(`Total Damage` / `Total Survival Time`, 1)) %>% 
  arrange(desc(`Num Games Played`))

leaderboard_df <- rbind(top_n(apex_df, 1, Damage) %>% 
                          mutate(Statistic = "Most Damage"),
                        top_n(apex_df, 1, Kills) %>% 
                          mutate(Statistic = "Most Kills"),
                        top_n(apex_df, 1, Assists) %>% 
                          mutate(Statistic = "Most Assists"),
                        top_n(apex_df, 1, Knocks) %>% 
                          mutate(Statistic = "Most Knocks")) %>% 
  select(-c(Timestamp_raw))
  
test <- apex_df %>% 
  filter(Player == "Oliver") %>% 
  mutate(`Game Number` = row_number())

test <- cbind(test, "Cumulative Damage" = cumsum(test$Damage)) 

damage_over_time <- plot_ly(test, x = ~`Timestamp_raw`, y = ~`Cumulative Damage`,
                            type = 'scatter', mode = 'lines')  %>% 
                    layout(title = paste("Damage over time by Oliver"),  showlegend = T,
                           xaxis = list(title = "Date"),
                           yaxis = list(title = "Cumulative Damage"))
damage_over_time

oliver_df <- apex_df %>% 
  filter(Player == "Oliver") %>% 
  mutate(`Game Number` = row_number())
oliver_df <- cbind(oliver_df, "Cumulative Damage" = cumsum(oliver_df$Damage))

connor_df <- apex_df %>% 
  filter(Player == "Connor") %>% 
  mutate(`Game Number` = row_number())
connor_df <- cbind(connor_df, "Cumulative Damage" = cumsum(connor_df$Damage))

isaac_df <- apex_df %>% 
  filter(Player == "Isaac") %>% 
  mutate(`Game Number` = row_number())
isaac_df <- cbind(isaac_df, "Cumulative Damage" = cumsum(isaac_df$Damage))

nat_df <- apex_df %>% 
  filter(Player == "Nat") %>% 
  mutate(`Game Number` = row_number())
nat_df <- cbind(nat_df, "Cumulative Damage" = cumsum(nat_df$Damage))

thomas_df <- apex_df %>% 
  filter(Player == "Thomas") %>% 
  mutate(`Game Number` = row_number())
thomas_df <- cbind(thomas_df, "Cumulative Damage" = cumsum(thomas_df$Damage))

final_df <- rbind(oliver_df, connor_df, isaac_df, nat_df, thomas_df) 
