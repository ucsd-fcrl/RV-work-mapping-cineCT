function [MWCT,ESRSCT,minRSCT] = getPatientPerformance(work,strain,vols,lids,wall_pts,check)
    if istable(lids)
        lid_array = table2array(lids);
    else
        lid_array = lids;
    end

    %work
    if istable(work)
        MWCT = table2array(work(:,2));
    else
        MWCT = work(:,2);
    end

    %strain
    if istable(strain)
        RSCT = table2array(strain(:,2:end));
    else
        RSCT = strain;
    end
    %volumes
    if istable(vols)
        vol_array = table2array(vols);
    else
        vol_array = vols;
    end
    [~,ESindx] = min(vol_array);
    ES = [RSCT(:,ESindx-1) RSCT(:,ESindx) RSCT(:,ESindx+1)];
    ESRSCT = min(ES,[],2);
    [minRSCT,minRSCT_idx] = min(RSCT,[],2);

    if ~isempty(wall_pts)
        wall_pts = table2array(wall_pts);
        %remove the points that intersect with the other wall
        if ~isempty(check)
            wall_pts(check) = [];
        else
        end

        if isempty(intersect(lid_array,wall_pts))
             MWCT = MWCT(wall_pts);
             ESRSCT = ESRSCT(wall_pts);
             minRSCT = minRSCT(wall_pts);
             minRSCT_idx = minRSCT_idx(wall_pts);
        else
            int_pts = intersect(lid_array,wall_pts);
            for k = 1:length(int_pts)
                int_wall_idx(k) = find(wall_pts == int_pts(k));
            end
            wall_pts(int_wall_idx) = [];
            MWCT = MWCT(wall_pts);
            ESRSCT = ESRSCT(wall_pts);
            minRSCT = minRSCT(wall_pts);
            minRSCT_idx = minRSCT_idx(wall_pts);
        end  
        
    else
        MWCT(lid_array) = [];
        ESRSCT(lid_array) = [];
        minRSCT(lid_array) = [];
        minRSCT_idx(lid_array) = [];
    end
 

end