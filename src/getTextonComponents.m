function ks = getTextonComponents(rgb, vocabulary, filters)
    [m, n, dummy] = size(rgb);
    fResponses = calculateFeatures4SingleImage (rgb, filters, 1);
    ks = calculateNearestTextonLabel(fResponses,vocabulary);
    ks = reshape(ks, m, n);
end

function labels = calculateNearestTextonLabel(pixelResponses,textonList)
    [m, n] = size(pixelResponses);
    labels = zeros(m,1);
    for t=1:m
        label = predictCluster(pixelResponses(t,:),textonList);
        labels(t) = label;
    end
end

function label = predictCluster(response,texton)
    X = repmat(response, size(texton,1), 1);
    dists = sum((texton - X).^2, 2);
    [dummy, label] = min(dists);
end