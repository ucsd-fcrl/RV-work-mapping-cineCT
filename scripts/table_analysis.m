function [result_vector,reported_results] = table_analysis(group1,group2,group3,param_type,k)


if param_type==1 % Continuous Varaible
    
    % Check for normality

    % Report mean+-std or median with IQR
    % Compare values across groups
    group1_test = group1(~isnan(group1));
    group2_test = group2(~isnan(group2));
    group3_test = group3(~isnan(group3));
   % 
    nt1=normalitytest(group1_test');
    nt2=normalitytest(group2_test');
    nt3=normalitytest(group3_test');
    nt = [nt1(7,3) nt2(7,3) nt3(7,3)];
    %nt(7,3) = 0;
    
    if any(nt == 0)%nt(7,3)==0
        nt_id = 0;
        
        % Report median and IQR
        val1a=nanmedian(group1);
        val1b=prctile(group1,25);
        val1c=prctile(group1,75);
        
        val2a=nanmedian(group2);
        val2b=prctile(group2,25);
        val2c=prctile(group2,75);
        
        val3a=nanmedian(group3);
        val3b=prctile(group3,25);
        val3c=prctile(group3,75);
        
        
        % Do a non-parametric comparison
        if numel(find(~isnan(group1)))*numel(find(~isnan(group2)))*numel(find(~isnan(group3))) > 0
            for i = 1:sum([length(group1),length(group2),length(group3)]) 
                if i <= length(group1)
                    grp_vec{i} = '1';
                elseif i > length(group1) && i <= sum([length(group1),length(group2)])
                    grp_vec{i} = '2';
                else
                    grp_vec{i} = '3';
                end
            end
       
%             grp_vec(30) = [];
%            grp_vec(22) = [];
%             grp_vec(19) = [];
%             grp_vec(12) = [];
           
            
            gen_vec=[group1; group2; group3];
            [comp1,~,stats]=kruskalwallis(gen_vec,grp_vec,'off');
            close all;
            
        else
            comp1=NaN;
        end
        
    elseif all(nt == 1) %nt(7,3)==1
        nt_id = 1;
        % Report mean and std
        % val1a=mean(group1);
        % val1b=std(group1);
        % val1c=NaN;
        % 
        % val2a=mean(group2);
        % val2b=std(group2);
        % val2c=NaN;
        % 
        % val3a=mean(group3);
        % val3b=std(group3);
        % val3c=NaN;

        val1a=nanmean(group1);
        val1b=nanstd(group1);
        val1c=NaN;
        
        val2a=nanmean(group2);
        val2b=nanstd(group2);
        val2c=NaN;
        
        val3a=nanmean(group3);
        val3b=nanstd(group3);
        val3c=NaN;
        
        % Do a unpaired t-test
        disp('P')
        %grp_vec=[zeros(numel(group1),1); ones(numel(group2),1); 2*ones(numel(group3),1)];
%         for i = 1:39
%             if i <= 8 %1:8
%                 grp_vec{i} = 'TOF';
%             elseif i >= 9 && i <= 17 %9:17
%                 grp_vec{i} = 'CTEPH';
%             else
%                 grp_vec{i} = 'LVAD';
%             end
%         end
%         grp_vec(30) = [];
%         grp_vec(22) = [];
%         grp_vec(19) = [];
%         grp_vec(12) = [];
        for i = 1:sum([length(group1),length(group2),length(group3)])
            if i <= length(group1)
                grp_vec{i} = '1';
            elseif i > length(group1) && i <= sum([length(group1),length(group2)])
                grp_vec{i} = '2';
            else
                grp_vec{i} = '3';
            end
        end
        
        gen_vec=[group1; group2; group3];
        [comp1,~,stats]=anova1(gen_vec,grp_vec,'off');
        
    end
    
    
    if comp1<0.05
        c=multcompare(stats);
        pair_c=c(:,6)<0.05;
        p_vals=c(:,6)';
    else
        pair_c=zeros(3,1);
        p_vals=ones(3,1)';
    end
    
    
    result_vector=[k nt_id val1a val1b val1c val2a val2b val2c val3a val3b val3c comp1 pair_c' p_vals];
    
    reported_results = [nanmedian(group1),prctile(group1,25),prctile(group1,75),...
        nanmedian(group2),prctile(group2,25),prctile(group2,75),...
        nanmedian(group3),prctile(group3,25),prctile(group3,75)];
elseif param_type==2 % Categorical
    
    [result_vector] = prop_table_analysis(group1,group2,group3,k);
    
end