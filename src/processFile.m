function [imgFilenames, labels] = processFile(filename)
    imgFilenames = readtable(filename);
    labels = table2array(imgFilenames(:,2));
    imgFilenames(:,2)  = [];
    imgFilenames = table2cell(imgFilenames);
end