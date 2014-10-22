function plotter(s,i,b)
    clf
    hold on
    plot(s, 'LineWidth', 2)
    %plot(i)
    %plot(b)
    
    xlabel('Time (hours) ');
    ylabel('Concentration (%)');
    title('Ibuprofen Absorption and Elimination');
    
end