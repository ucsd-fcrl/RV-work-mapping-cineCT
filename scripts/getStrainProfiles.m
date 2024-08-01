function [strain_profile,strain_profile_indx] = getStrainProfiles(strain)
    strain_profile_indx = zeros(length(strain),1);
    for i = 1:length(strain)
        if strain(i) >= 0.05 %stretch
            strain_profile_indx(i) = 1;
        elseif strain(i) >= -0.05 && strain(i) < 0.05 %akinetic
            strain_profile_indx(i) = 2;
        elseif strain(i) >= -0.15 && strain(i) < -0.05 %hypokinetic
            strain_profile_indx(i) = 3;
        elseif strain(i) >= -0.25 && strain(i) < -0.15 %expected_low
            strain_profile_indx(i) = 4;
        elseif strain(i) >= -0.35 && strain(i) < -0.15 %expected_high
            strain_profile_indx(i) = 5;
        elseif strain(i) < -0.35 %hyperkinetic
            strain_profile_indx(i) = 6;  
        end
    end
    strain_profile = [sum(strain_profile_indx == 1) sum(strain_profile_indx == 2)...
        sum(strain_profile_indx == 3) sum(strain_profile_indx == 4)...
        sum(strain_profile_indx == 5) sum(strain_profile_indx == 6)]./numel(strain_profile_indx).*100;
end