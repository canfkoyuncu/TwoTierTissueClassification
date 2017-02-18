
%% Variable discs are using and sum is zero
function sigma = findBlobScale(img, cpercent, diskFilters)
    imgAreaSum = sum(img(:));
    img = double(img);
    for sigma=13:4:121
		if (sigma>size(img,1) || sigma>size(img,2))
			break;
		end 
		
        r = (sigma-1)/4;
		convImg = conv2(img, diskFilters{r}, 'same');
		%convImg=round(convImg);

        resultSum = sum(convImg(:));
        ratio = resultSum/imgAreaSum;
        if (ratio>=cpercent)
           break;
        end		
    end   
end
