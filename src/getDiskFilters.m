function diskFilters = getDiskFilters()

    diskFilters = [];
    diskFilters=cat(1,diskFilters,cell(1));
    diskFilters=cat(1,diskFilters,cell(1));
    for r=3:30
        r2 = 2*r;
        windowSize = 4*r + 1;
        window=zeros(windowSize,windowSize);
        center = 2*r+1;
        for i=1:windowSize
            for j=1:windowSize
                if ((((center-i)*(center-i))+((center-j)*(center-j)))<=(r*r))
                    window(i,j) = 11;
                else
                    if ((((center-i)*(center-i))+((center-j)*(center-j)))<=(r2*r2))
                        window(i,j) = 22;
                    end
                end
            end
        end
        onesCount = size(window(window==11),1);
        twosCount = size(window(window==22),1);
        %zerosCount = (windowSize*windowSize)-onesCount-twosCount;
        window(window==11) = 1/onesCount;
        window(window==22) = -1/twosCount;
        
        tmp=cell(1);
        tmp{1} = window;
        diskFilters=cat(1,diskFilters,tmp);
        
    end

end