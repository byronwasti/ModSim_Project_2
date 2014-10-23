function plotter(s,i,b)
    clf
    hold on
    load DataIbu.csv;
    plot(DataIbu(:,1), DataIbu(:,2), 'LineWidth', 2);
    hold on;
    
    C1 = [.5, .5, .5];
    C2 = [.2, .1, .4];
    C3 = [.3, .6, .2];
    
    plot(s, 'LineWidth', 2,'Color',C1)
    plot(i, 'LineWidth',2,'Color',C2)
    plot(b, 'LineWidth',2, 'Color',C3)
    
    xlabel('Time (hours) ');
    ylabel('Concentration (mg/L)');
    title('Ibuprofen Absorption and Elimination');
    legend('Experimental Data', 'Stomach', 'Small Intestine', 'Blood Conc');
    
end