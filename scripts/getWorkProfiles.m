function [work_profile,work_profile_indx] = getWorkProfiles(work)
    work_profile_indx = zeros(length(work),1);
    for i = 1:length(work)
        if work(i) <= 0 %stretch
            work_profile_indx(i) = 1;
        elseif work(i) <= 5 && work(i) > 0 %akinetic
            work_profile_indx(i) = 2;
        elseif work(i) <= 10 && work(i) > 5 %hypokinetic
            work_profile_indx(i) = 3;
        elseif work(i) <= 15 && work(i) > 10 %expected_low
            work_profile_indx(i) = 4;
        elseif work(i) <= 20 && work(i) > 15 %expected_high
            work_profile_indx(i) = 5;
        elseif work(i) > 20 %hyperkinetic
            work_profile_indx(i) = 6;  
        end
    end

    work_profile = [sum(work_profile_indx == 1) sum(work_profile_indx == 2)...
        sum(work_profile_indx == 3) sum(work_profile_indx == 4)...
        sum(work_profile_indx == 5) sum(work_profile_indx == 6)]./numel(work_profile_indx).*100;
end