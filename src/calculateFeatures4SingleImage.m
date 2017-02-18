% inputs
% filename          : image filename
% filters           : filters used for obtaining pixels' features
% delta             : sample rate
function fResponses = calculateFeatures4SingleImage (im, filters, offset)
    gray                = normalizedGrayValues(im);
    fResponses          = getTextonResponses(gray, filters);
    fResponses          = sampleResult(fResponses, offset);
end
% --------------------------------------%
% --------------------------------------%
% --------------------------------------%
function gray = normalizedGrayValues(im)
    gray = rgb2gray(im);
    gray = double(gray);
    gray = (gray - mean2(gray))./std2(gray);
end
% --------------------------------------%
% --------------------------------------%
% --------------------------------------%
function R = sampleResult(R, delta)
    [r, c, f] = size(R);
    R = reshape(R, r*c, f);
    indices = 1:delta:r*c;
    R = R(indices, :);
end
% --------------------------------------%
% --------------------------------------%
% --------------------------------------%
function R = getTextonResponses(gray, F)
    [r, c] = size(gray);
    R = zeros(r, c, size(F,3));
    for i=1:size(R,3)
        R(:,:, i) = conv2(gray, F(:,:,i), 'same');
    end
end