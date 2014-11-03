function [T,M] = IbuprofenTimeSeries();
   
    fasted = csvread('FastedDigital.csv',6,0);
    light = csvread('LightBreakfastDigital.csv',6,0);
    heavy = csvread('HeavyBreakfastDigital.csv',6,0);
    fasteds = csvread('FastedStomach.csv',6,0);
    lights = csvread('LightStomach.csv',6,0);
    heavys = csvread('HeavyStomach.csv',6,0);
    
    y1_init = 100;  % Digestive system concentration of Ibuprofen, Bolus input
                    % 800mg of Ibuprofen conecntration in tablet
    y2_init = 0;  % Blood Plasma concentration of Ibuprofen in ug/ml
    
    hour = 60*60;
    
    % ============
    % Gastric emptying rate
    alpha = 0.00003; % The rate at which the gastric emptying happens
    
    % ============
    % Blood Ipubrofen Concentration
    beta = 33; % The negative perabola making parameter
    gamma = .000015 % 
    protein = 0 % Protein and fat parameter
    
    
    [T,M] = ode45(@deriv,[0 25*hour],[y1_init; y2_init]); 
    hours = T/hour;
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plotting
    
    % Plotting Ibu in stomach
    
    subplot(3,2,1)
    title('Tablet in Stomach','FontSize',14);
    hold all
    plot(fasteds(:,1),fasteds(:,2),'rx','LineWidth',3);
    plot(hours, M(:,1),'b','LineWidth',2);
    xlim([0,25])
    
    subplot(3,2,3)
    hold all
    plot(lights(:,1),lights(:,2),'rx','LineWidth',3);
    plot(hours, M(:,1),'b','LineWidth',2);
    ylabel('% Disintegration of Tablet in Stomach','FontSize',12)
    xlim([0,25])
    
    subplot(3,2,5)
    hold all
    plot(heavys(:,1),heavys(:,2),'rx','LineWidth',3);
    plot(hours, M(:,1),'b','LineWidth',2);
    xlim([0,25])
    xlabel('Time in Hours','FontSize',12)
    
    % ====================================
    % Plotting Ibuprof in Blod
    
    
    subplot(3,2,2)
    title('Ibuprofen Concentration','FontSize',14)
    hold all
    plot(fasted(:,1),fasted(:,2),'rx','LineWidth',3);
    plot(hours,M(:,2),'b','LineWidth',2)
    xlim([0,25])
    ylim([0,25])
    
    subplot(3,2,4)
    hold all
    ylabel('Ibuprofen in Plasma (ug/ml)','FontSize',12)
    plot(light(:,1),light(:,2),'rx','LineWidth',3);
    plot(hours,M(:,2),'b','LineWidth',2)
    xlim([0,25])
    ylim([0,25])
    
    subplot(3,2,6)
    hold all
    plot(heavy(:,1),heavy(:,2),'rx','LineWidth',3);
    
    %jank code spot
    protein = 0;
    gamma = 0.00002
    
    [T,M] = ode45(@deriv,[0 25*hour],[y1_init; y2_init]); 
    %end of jank code spot
    
    plot(hours+3,M(:,2),'b','LineWidth',2)
    xlim([0,25])
    ylim([0,25])
    xlabel('Time in Hours','FontSize',12)
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Functions
    
    
    function res = deriv(t,Y);
        y1 = Y(1);
        y2 = Y(2);
        
        dy1dt = -alpha*y1; % -.00138 for complete linearity slope
        dy2dt = gamma*(y1 - beta - protein);
        
        res = [dy1dt;dy2dt];      
    end  
end