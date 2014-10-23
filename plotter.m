function plotter(s,tf1,i,tf2,b,tf3)
    clf
    hold on
    
    C1 = [.5, .5, .5];
    C2 = [.2, .1, .4];
    C3 = [.3, .6, .2];
    
    if tf1 == 1
        plot(s, 'LineWidth', 2,'Color',C1)
    end
    if tf2 == 1
        plot(i, 'LineWidth',2,'Color',C2)
    end
    if tf3 == 1
        plot(b, 'LineWidth',2, 'Color',C3)
    end
    
    xlabel('Time (hours) ');
    ylabel('Concentration (%)');
    title('Ibuprofen Absorption and Elimination');
    
end