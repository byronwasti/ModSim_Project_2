function IbuprofenTimeSeries();
   
    clf;
    
    fasted = csvread('FastedDigital.csv',6,0);
    light = csvread('LightBreakfastDigital.csv',6,0);
    heavy = csvread('HeavyBreakfastDigital.csv',6,0);
    fasteds = csvread('FastedStomach.csv',6,0);
    lights = csvread('LightStomach.csv',6,0);
    heavys = csvread('HeavyStomach.csv',6,0);
    
    y1_init = 800;  % Digestive system concentration of Ibuprofen, Bolus input
                    % 800mg of Ibuprofen conecntration in tablet
    y2_init = 0;  % Blood Plasma concentration of Ibuprofen in ug/ml
    y3_init = 0;
    
    hour = 60*60;
    
    %=============
    % Graphing Variables
    axisStomach = [ -1 25 -10 800 ];
    axisFood = [ -1 25 0 20 ];
    axisBlood = [ -1 25 0 125 ];
    
    % ============
    % Gastric emptying rate
%    alpha = .0138; % The rate at which the gastric emptying happens
    alpha = .00003
    loss = .3 % The amount of ibuprofen lost per stock shift
    
    
    % ============
    % Food ibu. concentration
    beta = .0033; % Food elimination rate
    y2crit = 40;
    
    % ============
    % Blood Ibuprofen Concentration
    gamma = .00004; % Rate of eliminatio..n
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plotting
    
    % Plotting Ibu with fasting
    pf = 0;
    [T,M] = ode45(@deriv,[0 25*hour],[y1_init; y2_init; y3_init]); 
    hours = T/hour;
    
    subplot(3,3,1)
    title('Ibuprofen in Stomach','FontSize',14);
    hold all
    plot(fasteds(:,1),fasteds(:,2)*8,'rx','LineWidth',3);
    plot(hours, M(:,1),'b','LineWidth',2);
    axis(axisStomach)
    
    subplot(3,3,2)
    title('Ibuprofen in Food','FontSize',14)
    hold all;
    plot(hours, M(:,2),'b','LineWidth',2);
    axis(axisFood)
    
    subplot(3,3,3)
    title('Ibuprofen in Blood Plasma','FontSize',14)
    hold all
    plot(fasted(:,1),fasted(:,2)*5,'rx','LineWidth',3);
    plot(hours,M(:,3),'b','LineWidth',2)
    axis(axisBlood)
    

    
    %=====================================
    %Plotting Ibuprofen light breakfast
    pf = .07;
    
    [T,M] = ode45(@deriv,[0 25*hour],[y1_init; y2_init; y3_init]); 
    hours = T/hour;
    
    subplot(3,3,4)
    hold all
    plot(lights(:,1),lights(:,2)*8,'rx','LineWidth',3);
    plot(hours, M(:,1),'b','LineWidth',2);
    ylabel('Mg of Ibuprofen in Stomach','FontSize',12)
    axis(axisStomach)

    subplot(3,3,5)
    plot(hours, M(:,2),'b','LineWidth',2);
    axis(axisFood)
    
    subplot(3,3,6)
    hold all
    ylabel('Mg of Ibuprofen in Blood Plasma','FontSize',12)
    plot(light(:,1),light(:,2)*5,'rx','LineWidth',3);
    plot(hours,M(:,3),'b','LineWidth',2)
    axis(axisBlood)
    
    % ====================================
    % Plotting Ibuprof Heavy breakfast
    pf = .33
    
    [T,M] = ode45(@deriv,[0 25*hour],[y1_init; y2_init; y3_init]); 
    hours = T/hour;
    
    subplot(3,3,7)
    hold all
    plot(heavys(:,1),heavys(:,2)*8,'rx','LineWidth',3);
    plot(hours, M(:,1),'b','LineWidth',2);
    axis(axisStomach)
    xlabel('Time in Hours','FontSize',12)
    
    
    subplot(3,3,8)
    plot(hours, M(:,2),'b','LineWidth',2);
    xlabel('Time in Hours', 'FontSize',12);
    axis(axisFood);
    
    
    subplot(3,3,9)
    hold all
    plot(heavy(:,1),heavy(:,2)*5,'rx','LineWidth',3);
    plot(hours,M(:,3),'b','LineWidth',2)
    axis(axisBlood)
    xlabel('Time in Hours','FontSize',12)
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Functions

    function res = deriv(t,Y);
        y1 = Y(1);
        y2 = Y(2);
        y3 = Y(3);
        
        
        dy1dt = -alpha*y1; % -.00138 for linear slope
        
%         if y1 < 0;  % Never can get negative concentrations in stomach
%             dy1dt = 0;
%         end
        fddig = beta*(y2/y2crit) % Food digestion, elimnation of food
        dy2dt = -dy1dt*(pf)*loss - fddig; 
        
        dy3dt = -dy1dt*(1 - pf)*loss + fddig -gamma*y3;
        
        
        res = [dy1dt;dy2dt;dy3dt];      
    end  
end