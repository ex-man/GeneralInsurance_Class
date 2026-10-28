# Gives every R chunk in Lessons/*/Exercises/*.Rmd a label cell_01, cell_02, ...
# Numbering restarts in each file. Existing labels are replaced, chunk options are kept.
# Safe to re-run (e.g. after inserting a chunk). Line endings (CRLF / LF) are preserved.
#
# Usage (from the repo root): Rscript tools/label_chunks.R

files <- Sys.glob("Lessons/*/Exercises/*.Rmd")

header_re <- "^(\\s*`{3,}\\s*\\{r)(.*)(\\}\\s*\\r?)$"

relabel <- function(file) {
  raw <- readBin(file, "raw", file.info(file)$size)
  txt <- rawToChar(raw)
  Encoding(txt) <- "UTF-8"
  lines <- strsplit(txt, "\n", fixed = TRUE)[[1]] # a trailing \r stays on the line
  n <- 0
  for (i in grep(header_re, lines, perl = TRUE)) {
    m <- regmatches(lines[i], regexec(header_re, lines[i], perl = TRUE))[[1]]
    inner <- trimws(m[3])
    if (startsWith(inner, ",")) {
      opts <- trimws(sub("^,", "", inner))
    } else if (inner == "") {
      opts <- ""
    } else {
      first <- trimws(sub(",.*$", "", inner))
      if (grepl("=", first, fixed = TRUE)) {
        opts <- inner # no label, only options
      } else {
        opts <- trimws(sub("^[^,]*,?", "", inner)) # drop the old label
      }
    }
    n <- n + 1
    label <- sprintf("cell_%02d", n)
    new_inner <- if (nzchar(opts)) paste0(" ", label, ", ", opts) else paste0(" ", label)
    lines[i] <- paste0(m[2], new_inner, m[4])
  }
  out <- paste(lines, collapse = "\n")
  if (endsWith(txt, "\n")) out <- paste0(out, "\n")
  writeBin(charToRaw(out), file)
  cat(sprintf("%-75s %2d chunks\n", file, n))
}

invisible(lapply(files, relabel))
