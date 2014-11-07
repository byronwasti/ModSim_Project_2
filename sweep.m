function sweep()
    hold all;
    calories = linspace(0, 5000, 50);
    pf = linspace(0,1,50);
    for j = 1:length(pf)
        
        for i = 1:length(calories)
            M = IbuprofenTimeSeries3(pf(j),calories(i));
            Q(j,i) = max(M(:,5));
        end
        
    end
            
    plot(Q)
    
    
end
