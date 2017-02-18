function fts = extractFeaturesForTextonSizeDiff(filename,vocabulary,textFilters,K,diskFilters,sizeThr,cPercent,uppTrIndices)
    im = imread(filename);
    ks = getTextonComponents(im, vocabulary, textFilters);

    scales      = [];
    r_centroids = [];
    c_centroids = [];
    
    for kk=1:K
        [scale, r_centroid, c_centroid] = getObjects(ks==kk, diskFilters, 1000*(kk-1), sizeThr, cPercent);
        scales      = cat(1, scales, scale);
        r_centroids = cat(1, r_centroids, r_centroid);
        c_centroids = cat(1, c_centroids, c_centroid);
    end

    tri = delaunay(r_centroids,c_centroids);
    AdjMatrix = zeros(size(r_centroids,1),size(r_centroids,1));
    for t=1:size(tri,1)
        node1 = tri(t,1);
        node2 = tri(t,2);
        node3 = tri(t,3);

        AdjMatrix(node1,node2) = 1;
        AdjMatrix(node1,node3) = 1;
        AdjMatrix(node2,node1) = 1;
        AdjMatrix(node2,node3) = 1;
        AdjMatrix(node3,node1) = 1;
        AdjMatrix(node3,node2) = 1;
    end
	
	% DBS degerleri 3'e quantize edildigi icin (3*clusterCount(6))x(3*clusterCount(6)) cooccurrence matrix olusur.
	coOccurenceMatrix = zeros(K*3);
    for t=1:size(scales,1)
        currentScale = scales(t);

        idx = find(AdjMatrix(t,:));
        for i=1:size(idx,2)
            targetScale = scales(idx(i));
            cnt = coOccurenceMatrix(currentScale,targetScale);
            coOccurenceMatrix(currentScale,targetScale) = cnt + 1;
        end
    end
	
    fts = coOccurenceMatrix(uppTrIndices)';
end

function [scales,r_centroids,c_centroids] = getObjects(result, diskFilters, clustCode, sizeThr, cPercent)
	regions = regionprops(result, 'Area', 'Image', 'Centroid');
    ids = find([regions(:).Area] > sizeThr);
    
	scales       = zeros(length(ids), 1);
    r_centroids  = zeros(length(ids), 1);
    c_centroids  = zeros(length(ids), 1);
    for i=1:length(ids)
        id = ids(i);
        
        sigma = findBlobScale(regions(id).Image, cPercent, diskFilters);
        newScale    = quantizeDbs((clustCode + sigma), sizeThr);
        centroid = regions(id).Centroid;

        scales(i) = newScale;
        r_centroids(i)  = centroid(2);
        c_centroids(i)  = centroid(1);
    end
end

function [newScale] = quantizeDbs(currentScale,sizeThr)
	
	dbs = mod(currentScale,1000);
	r = (dbs-1)/4;

	if (sizeThr<30)
        split1= 6;
        split2 = 16;
    end
    if (sizeThr==30)
        split1 = 6;
        split2 = 17;
    end
    if (sizeThr==35)
        split1 = 7;
        split2 = 17;
    end
    if (sizeThr==40)
        split1 = 7;
        split2 = 18;
    end
    if (sizeThr==45)
        split1 = 7;
        split2 = 18;
    end
    if (sizeThr==50)
        split1 = 7;
        split2 = 19;
    end
    if (sizeThr==55)
        split1 = 7;
        split2 = 19;
    end
    if (sizeThr==60)
        split1 = 7;
        split2 = 19;
    end
    
    if (sizeThr==100)
        split1 = 9;
        split2 = 21;
    end
    if (sizeThr==150)
        split1 = 10;
        split2 = 22;
    end
    if (sizeThr==200)
        split1 = 10;
        split2 = 22;
    end
    if (sizeThr==250)
        split1 = 11;
        split2 = 23;
    end
    if (sizeThr==300)
        split1 = 11;
        split2 = 23;
    end
    if (sizeThr==350)
        split1 = 11;
        split2 = 23;
    end
    if (sizeThr==400)
        split1 = 12;
        split2 = 23;
    end
    if (sizeThr==450)
        split1 = 12;
        split2 = 24;
    end
    if (sizeThr==500)
        split1 = 12;
        split2 = 24;
    end
	if (sizeThr==550)
        split1 = 13;
        split2 = 24;
    end
	if (sizeThr==600)
        split1 = 13;
        split2 = 24;
    end
	if (sizeThr==650)
        split1 = 13;
        split2 = 25;
    end
	if (sizeThr==700)
        split1 = 13;
        split2 = 25;
    end
	if (sizeThr==750)
        split1 = 13;
        split2 = 25;
    end
	if (sizeThr==800)
        split1 = 14;
        split2 = 25;
    end
	if (sizeThr==850)
        split1 = 14;
        split2 = 25;
    end
    if (sizeThr==900)
        split1 = 14;
        split2 = 25;
    end
	if (sizeThr==950)
        split1 = 14;
        split2 = 25;
    end
	if (sizeThr==1000)
        split1 = 14;
        split2 = 25;
    end

    if (r<=split1)
        newDbs = 1;
    end

    if (r>=(split1+1)) && (r<=(split2-1))
        newDbs = 2;
    end

    if (r>=split2) 
        newDbs = 3;
    end
	
	if (currentScale<1000)
		newScale = newDbs;
	end
	if (currentScale>1000) && (currentScale<2000)
		newScale = 3+newDbs;
	end
	if (currentScale>2000) && (currentScale<3000)
		newScale = 6+newDbs;
	end
	if (currentScale>3000) && (currentScale<4000)
		newScale = 9+newDbs;
	end
	if (currentScale>4000) && (currentScale<5000)
		newScale = 12+newDbs;
	end
	if (currentScale>5000) && (currentScale<6000)
		newScale = 15+newDbs;
	end
	if (currentScale>6000) && (currentScale<7000)
		newScale = 18+newDbs;
	end
	if (currentScale>7000) && (currentScale<8000)
		newScale = 21+newDbs;
	end
	if (currentScale>8000) && (currentScale<9000)
		newScale = 24+newDbs;
	end
	if (currentScale>9000) && (currentScale<10000)
		newScale = 27+newDbs;
	end
end