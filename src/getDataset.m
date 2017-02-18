function data = getDataset(imgFilenames, vocabulary, sizeThr, K, cPercent, ...
                                uTriIndices, textFilters, diskFilters)
    ftNumber = (K*3) * (K*3 + 1) / 2;
    n = length(imgFilenames);
    data = zeros(n, ftNumber);
    for i=1:n
        disp(i)
        data(i, :) = extractFeaturesForTextonSizeDiff(imgFilenames{i}, vocabulary, textFilters, K, diskFilters, sizeThr, cPercent, uTriIndices);
    end
end