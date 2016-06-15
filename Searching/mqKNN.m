function [] = mqKNN()
global NUMBER_NEAREST_NEIGHBORS;
table_of_features = load('table_of_features.mat');
table_of_names = load('table_of_names.mat');
Mdl = fitcknn(table_of_features, table_of_names,'NumNeighbors',NUMBER_NEAREST_NEIGHBORS);
Mdl
end