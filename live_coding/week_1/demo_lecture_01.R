# MA22019 - Lecture 1 Live Demo
# "The Magic Trick"

# 1. Load Packages --------------------------------------------------------
library(tidyverse)
library(janitor) # for clean_names()
library(tidytext) # for word clouds
library(wordcloud)

# 2. Read Data ------------------------------------------------------------
# STEP: Download Excel/CSV from Microsoft Forms
# STEP: Save it as "responses.csv" in this folder!

# Check if file exists to avoid embarrassing error
if (!file.exists("responses.csv")) {
    stop("⚠️  responses.csv not found! Did you download the form data?")
}

# Read it in
raw_data <- read_csv("responses.csv")

# Show the MESS
glimpse(raw_data)
# Point out:
# - Long terrible column names
# - Weird spaces
# - Timestamps we don't need

# 3. Validating / Cleaning ------------------------------------------------
survey_data <- raw_data %>%
    clean_names() %>%
    rename(
        sleep = how_many_hours_did_you_sleep_last_night,
        confidence = on_a_scale_of_1_10_how_confident_are_you_with_r,
        prob_word = what_is_your_favorite_probability_word,
        ai_usage = have_you_used_chat_gpt_ai_for_coding_before,
        tv_show = what_is_your_favorite_tv_show_movie_right_now
    )

# Show the CLEAN data
glimpse(survey_data)

# 4. Question 1: Sleep Analysis (Histogram) -------------------------------
# "Are we a tired class?"

ggplot(survey_data, aes(x = sleep)) +
    geom_histogram(binwidth = 1, fill = "steelblue", color = "white") +
    theme_minimal() +
    labs(
        title = "Class Sleep Distribution",
        subtitle = "Welcome to Week 1...",
        x = "Hours of Sleep",
        y = "Count"
    )

# 5. Question 2: AI Usage (Bar Plot) --------------------------------------
# "How many robots are here?"

ggplot(survey_data, aes(x = ai_usage, fill = ai_usage)) +
    geom_bar(show.legend = FALSE) +
    theme_minimal() +
    scale_fill_brewer(palette = "Set2") +
    labs(title = "AI Usage in the Class")

# 6. Question 3: Probability Word Cloud -----------------------------------
# "What's on your mind?"

survey_data %>%
    unnest_tokens(word, prob_word) %>%
    count(word, sort = TRUE) %>%
    with(wordcloud(word, n, max.words = 50, colors = brewer.pal(8, "Dark2")))
