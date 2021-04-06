plan <- drake_plan(
  tree_import = GetTreeWithNameProcessing("R/data/Primate_tree.tre"),
  data_import = read.csv("R/data/primate_data.csv", row.names = 1, strip.white=TRUE, ), # Data of Ape biomass
  primate_diet = diet(data_import),
  unique_primate = find_unique(primate_diet),
  diet_binary = as.matrix(clean_up_diet(unique_primate)),
  match_datatree = CleanData(tree_import, data_import)
  #tree = match_datatree$phy,
  #data = match_datatree$data
)




