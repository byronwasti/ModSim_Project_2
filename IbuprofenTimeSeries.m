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
    y2_init = 0;  % Food concentration of Ibuprofen in ug/ml
    y3_init = 0; % Intestine initial 
    y4_init = 0; % Blood plasma initial
    
    hour = 60*60;
    
    %=============
    % Graphing Variables
    axisStomach = [ -1 25 -10 800 ];
    axisFood = [ -1 25 0 800 ];
    axisInt = [-1 25 0 100 ];
    axisBlood = [ -1 25 0 155 ];
    
    % ============
    % Gastric emptying rate
%    alpha = .0138; % The rate at which the gastric emptying happens
    alpha1 = .000025; % The rate of disintegration of tablet at more than 50% tablet size
    alpha2 = .00005; % The rate of disintegratiioin of tablet at less than 50% tablet size
    lossf = 1; %.7; % The amount of ibuprofen lost per stock shift to food
    lossb = 1; %.3; % The amount of ibuprofen lost per stock shift blood
    
    
    % ============
    % Food ibu. concentration
    beta = .000010; % Food elimination rate
    beta2 = .0000000;
    y2crit = 20;
    
    % ============
    % Intestine Conecentration
    delta = 0.0003;
    dint = 0.8; % The amount of Ibuprofen going to the intestine
    
    % ============
    % Blood Ibuprofen Concentration
    %gamma = .00016; % Rate of eliminatio..n
    gamma = 0.00016
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plotting
    
    % Plotting Ibu with fasting
    pf = 0;
    [T,M] = ode45(@deriv,[0 25*hour],[y1_init; y2_init; y3_init; y4_init]); 
    hours = T/hour;
    
    subplot(3,4,1)
    title('Ibuprofen Disintegration','FontSize',14);
    hold all
    plot(fasteds(:,1),fasteds(:,2)*8,'rx','LineWidth',3);
    plot(hours, M(:,1),'b','LineWidth',2);
    axis(axisStomach)
    
    subplot(3,4,2)
    title('Ibuprofen in Food','FontSize',14)
    hold all;
    plot(hours, M(:,2),'b','LineWidth',2);
    axis(axisFood)
    
    subplot(3,4,3)
    title('Ibuprofen in Intestine','FontSize',14)
    hold all;
    plot(hours,M(:,3),'b','LineWidth',2)
    
    subplot(3,4,4)
    title('Ibuprofen in Blood Plasma','FontSize',14)
    hold all
    plot(fasted(:,1),fasted(:,2)*5,'rx','LineWidth',3);
    plot(hours,M(:,4),'b','LineWidth',2)
    axis(axisBlood)
    

    
    %=====================================
    %Plotting Ibuprofen light breakfast
    pf = .07;
    
    [T,M] = ode45(@deriv,[0 25*hour],[y1_init; y2_init; y3_init; y4_init]); 
    hours = T/hour;
    
    subplot(3,4,5)
    hold all
    plot(lights(:,1),lights(:,2)*8,'rx','LineWidth',3);
    plot(hours, M(:,1),'b','LineWidth',2);
    ylabel('Mg of Ibuprofen in Stomach','FontSize',12)
    axis(axisStomach)

    subplot(3,4,6)
    plot(hours, M(:,2),'b','LineWidth',2);
    axis(axisFood)
    
    subplot(3,4,7)
    plot(hours,M(:,3),'b','LineWidth',2)
    
    subplot(3,4,8)
    hold all
    ylabel('Mg of Ibuprofen in Blood Plasma','FontSize',12)
    plot(light(:,1),light(:,2)*5,'rx','LineWidth',3);
    plot(hours,M(:,4),'b','LineWidth',2)
    axis(axisBlood)
    
    % ====================================
    % Plotting Ibuprof Heavy breakfast
    pf = .63;
    
    [T,M] = ode45(@deriv,[0 25*hour],[y1_init; y2_init; y3_init; y4_init]); 
    hours = T/hour;
    
    subplot(3,4,9)
    hold all
    plot(heavys(:,1),heavys(:,2)*8,'rx','LineWidth',3);
    plot(hours, M(:,1),'b','LineWidth',2);
    axis(axisStomach)
    xlabel('Time in Hours','FontSize',12)
    
    
    subplot(3,4,10)
    plot(hours, M(:,2),'b','LineWidth',2);
    xlabel('Time in Hours', 'FontSize',12);
    axis(axisFood);
    
    subplot(3,4,11)
    plot(hours,M(:,3),'b','LineWidth',2)
    
    subplot(3,4,12)
    hold all
    plot(heavy(:,1),heavy(:,2)*5,'rx','LineWidth',3);
    plot(hours,M(:,4),'b','LineWidth',2)
    axis(axisBlood)
    xlabel('Time in Hours','FontSize',12)
    %disp(T)
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Functions

    function res = deriv(t,Y);
        y1 = Y(1);
        y2 = Y(2);
        y3 = Y(3);
        y4 = Y(4);
        alpha = alpha1;
        if y1 < 300
            alpha = alpha2;
        end
        dy1dt = -alpha*y1; %*y1; % -.00138 for linear slope

        
%         if y1 < 0;  % Never can get negative concentrations in stomach
%             dy1dt = 0;
%         end
        fddig = beta*y2; % Food digestion, elimnation of food
        dy2dt = -dy1dt*(pf)*lossf - fddig; 
        dy3dt = -dy1dt*(dint) + fddig - delta*y3; % Intestine differential eqn
        
        dy4dt = -dy1dt*(1-pf)*lossb*(1-dint) + delta*y3 -gamma*y4; %*y4; % Have to add in y2 variation, 1-pf and loss
        
        
        res = [dy1dt;dy2dt;dy3dt;dy4dt];      
    end  
end