GetSingleGenusSpecies <- function(x) {
  return(paste(strsplit(x, " |_")[[1]][1:2], collapse=" "))
}

GetAllGenusSpecies <- function(x) {
  sapply(x, GetSingleGenusSpecies)
}

CleanData <- function(phy, data) {
  clean <- geiger::treedata(phy, data)
}

GetTreeWithNameProcessing <- function(treefile) {
  raw <- readLines(treefile)
  raw <- gsub(" CSM", "", raw)
  raw <- gsub(" ", "_", raw)
  phy <- ape::read.tree(text=raw)
  phy$tip.label <- unname(GetAllGenusSpecies(phy$tip.label))
  phy
}

diet <- function(data){
  gen_spe <- unite(data, genus_species, c("genus", "species_name"), sep = " ", remove = FALSE)
  sub <- gen_spe[,c("genus_species", "diet")]
  #abun2 <- unite(abun, bin.taxa.name, c(1, 7:13), sep=", ", remove=FALSE)
  return(sub)
}


find_unique <-  function(diet_data){
  x <- unique(diet_data)
  return(x)
} 


clean_up_diet <- function(unique_data){
  unique_data$diet_binary <- ifelse(unique_data$diet == "insectivore, omnivore" | unique_data$diet == "insectivore, herbivore" |
                                      unique_data$diet == "insectivore, frugivore" | unique_data$diet =="insectivore, carnivore" |
                                      unique_data$diet == "insectivore" | unique_data$diet == "omnivore", 1, 0)
  rownames(unique_data) <- unique_data[, "genus_species"]
  return(unique_data[,-1])
}






VisualizeData <- function(treedata) {
  return(plot(treedata$phy))
  print(treedata$data)
}
