function [data, label] = balanceSet(data, label)
    labels = unique(label)';
    datas = cell(length(labels), 1);
    maxClassCnt = 0;
    for i=1:size(datas,1)
        l = labels(i);
        datas{i} = data(label==l,:);
        if size(datas{i},1) > maxClassCnt
            maxClassCnt = size(datas{i},1);
        end
    end

    label = [];
    data = [];
    for i=1:size(datas,1)
        d = datas{i};
        d = repmat(d, floor(maxClassCnt/size(d,1)), 1);
        d = [d; d(1:maxClassCnt-size(d,1), :)];
        l = ones(size(d,1), 1) * labels(i);
        data = [data; d];
        label = [label; l];
    end
end

