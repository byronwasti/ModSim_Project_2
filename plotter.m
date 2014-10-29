function plotter(s,tf1,i,tf2,b,tf3)
    clf
    hold on
    data_before_meal = csvread('DataIbu.csv'); % Data from Science Direct
    data_after_meal = csvread('
    
    plot(data_before_meal(:,1), data_before_meal(:,2), 'LineWidth', 2);
    hold on;
    
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
    
    xlabel('Time (hours)','FontSize',12);
    ylabel('Concentration (mg/L) of Ibuprofen','FontSize',12);
    title('Ibuprofen Absorption and Elimination','FontSize',14);
    legend('Experimental Data', 'Stomach', 'Small Intestine', 'Blood Conc');
    
end