library(hash)

alphabet <- c('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z')

sortedArray <- function(array) {
  return(sort(array))
}

generateRandomIntArray <- function(size) {
  set.seed(123)  # Setting seed for reproducibility
  return(sample(1:50, size, replace = TRUE))
}

createIntervalMap <- function(sortedArray, alphabetPower) {
  intervalMap <- list()

  intervalSize <- length(sortedArray) %/% alphabetPower
  pointer <- 0
  for (i in 1:length(sortedArray)) {
    if ((i - 1) %% intervalSize == 0 && i != 1) {
      pointer <- pointer + 1
    }
    intervalMap[[sortedArray[i]]] <- alphabet[pointer + 1]
  }
  return(intervalMap)
}


mapValuesToChars <- function(intervalMap, array) {
  return(unlist(lapply(array, function(x) intervalMap[[x]])))
}

generateMatrix <- function(characters) {
  uniqueChars <- unique(characters)
  charIndexMap <- list()

  index <- 0
  for (c in uniqueChars) {
    charIndexMap[[as.character(c)]] <- index
    index <- index + 1
  }

  num_chars <- length(charIndexMap)
  matrix <- matrix(0, nrow = num_chars, ncol = num_chars,
                   dimnames = list(names(charIndexMap), names(charIndexMap)))

  for (i in 1:(length(characters) - 1)) {
    rowChar <- as.character(characters[i])
    colChar <- as.character(characters[i + 1])

    rowIndex <- charIndexMap[[rowChar]] + 1
    colIndex <- charIndexMap[[colChar]] + 1

    matrix[rowIndex, colIndex] <- matrix[rowIndex, colIndex] + 1
  }
  return(matrix)
}


array <- c(9, 1, 6, 7, 3, 4, 5, 10)

sortedArray <- sortedArray(array)
alphabetPower <- 4
intervalMap <- createIntervalMap(sortedArray, alphabetPower)
chars <- mapValuesToChars(intervalMap, array)
matrix <- generateMatrix(chars)
cat("Initial array:", "\n", array, "\n")
cat("Sorted array:", "\n", sortedArray, "\n")
cat("Chars: ", "\n" ,chars, "\n")
cat("Matrix: ", "\n")
print(matrix)

