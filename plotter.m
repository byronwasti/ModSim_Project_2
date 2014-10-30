function plotter(s,tf1,i,tf2,b,tf3)
    clf
    hold on
    load DataIbu.csv;
    load FastingData.csv;
    load AfterMealData.csv;
    %plot(DataIbu(:,1), DataIbu(:,2), 'LineWidth', 2);
    plot(FastingData(:,1), FastingData(:,2), 'b', 'LineWidth', 2);
    plot(AfterMealData(:,1), AfterMealData(:,2), 'r', 'LineWidth', 2);

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

    xlabel('Time (hours) ');
    ylabel('Concentration (mg/L)');
    title('Ibuprofen Absorption and Elimination');
    legend('Fasting Data', 'After Meal Data', 'Stomach', 'Small Intestine', 'Blood Conc');
    
end