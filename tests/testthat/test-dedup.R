context("dedup functions")

test_that("coord_* passing lat/long vars works", {
  skip_on_cran()

  df <- sample_data_1
  smalldf <- df[1:20, ]
  smalldf <- rbind(smalldf, smalldf[10,])
  smalldf[21, "key"] <- 1088954555
  dp <- dframe(smalldf) %>% dedup()
  dups <- attr(dp, "dups")

  expect_is(df, "data.frame")
  expect_is(smalldf, "data.frame")
  expect_is(dp, "tbl_df")
  expect_is(dups, "tbl_df")
  expect_lt(NROW(dp), NROW(smalldf))
  expect_equal(NROW(dups), 1)
  expect_named(attributes(dp), c('names', 'row.names', '.internal.selfref',
                                 'class', 'dups'))
})
