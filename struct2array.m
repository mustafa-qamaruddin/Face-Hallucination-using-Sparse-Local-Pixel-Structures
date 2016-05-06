function array = struct2array(struct,subcell)


len = length(struct);
array = zeros(len,1);

subcell_len = length(subcell);
evalstr = ['struct(i)'];
for i = 1:subcell_len
    evalstr = [evalstr '.' subcell{i}];
end

for i = 1:len

    
    array(i) = eval(evalstr);
end