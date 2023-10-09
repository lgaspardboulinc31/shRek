#' @title Quotes
#' @description List of quotes
#' @export
#'
quotes <- read.csv("./data/quotes_all.csv", sep=";")



#' @title Quote someone
#' @description Randomly quote one line
#' @export
#'
#'

echo_shrek <- function(who=c("Shrek","Donkey", None), type=c("Funny","Mean","Sweet",None)){
  # Math arg
  who <- match.arg(who)
  type <- match.arg(type)

  # Available people
  people=c("Shrek","Donkey")
  types = c("Funny","Mean","Sweet",None)

  if (who == None){
    who = sample(people,1)
  }

  if (type == None){
    type = sample(types,1)
  }

  q <- quotes[quotes$who == who & quotes$type == type,]

  print(q$quote)

}
