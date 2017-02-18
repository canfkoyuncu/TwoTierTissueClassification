function [train, elimColIds] = eliminateCols(train,thr)
    elimColIds = max(train,[],1) <= thr;
    train(:, elimColIds) = [];
end