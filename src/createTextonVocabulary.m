%% Belirlenen traininset imagelarini filterBank ile convolve ederek clusterin vektorlerini bulan kod
%% Her bir clusterNumber parametresi icin targetClusterNumber parametresi degistirilerek sadece bir kere hesaplaniyor.
%% 2,4,6,8 ve 10 clusterlar icin zaten hesaplanmis durumda yeniden hesaplanmasina gerek yok.
%% Bunlarin disinda bir clusterNumber icin test yapilmasi gerekirse kullanilacak.
function vocabulary = createTextonVocabulary (imgFilenames, labels, K, filters)
    classCount = length(unique(labels)); %normal, low-level, high-level, assuming class labels starting from 1 to N.
    elementCountPerClass = 10; %samples from each class for vocabulary calculation
    
    selectedExamples = zeros(classCount, elementCountPerClass);
    for i=1:classCount
        ind = find(labels==i);
        r = randi(length(ind), 1, elementCountPerClass);
        selectedExamples(i, :) = ind(r)';
    end

    ftCount = size(filters,3);
    fName = imgFilenames{1, 1};
    I = imread(fName);
    img_n = size(I,1) * size(I,2);
            
    delta = 5; %for faster calculation
    pix_per_img = img_n/delta;
    pixelArray = zeros(pix_per_img*elementCountPerClass*classCount, ftCount);
    ind = 1;
    for classId = 1:classCount
        disp(classId);
        for t=1:elementCountPerClass
            tic;
            fName = imgFilenames{selectedExamples(classId, t)};
            I = imread(fName);
            fResponses = calculateFeatures4SingleImage (I, filters, delta);
            pixelArray(ind:ind+pix_per_img-1, :) = fResponses;
            ind = ind + pix_per_img;
            toc;
        end
    end

    [dummy, vocabulary] = kmeans(pixelArray, K, 'emptyaction', 'singleton');
end