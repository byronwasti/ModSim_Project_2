function Q = IbuprofenTimeSeries3(pf,calories);
   
    %clf;
    
    fasted = csvread('FastedDigital.csv',6,0);
    light = csvread('LightBreakfastDigital.csv',6,0);
    heavy = csvread('HeavyBreakfastDigital.csv',6,0);
    fasteds = csvread('FastedStomach.csv',6,0);
    lights = csvread('LightStomach.csv',6,0);
    heavys = csvread('HeavyStomach.csv',6,0);
    
    y1_init = 800;  % Digestive system concentration of Ibuprofen, Bolus input
                    % 800mg of Ibuprofen conecntration in tablet
                    % Also starting amount of ibuprofen not disintegrated
    y2_init = 800;  % Starting stomach concentration of ibuprofen (Since a bolus input of 800 mg)
    y3_init = 0; % Food concentration of Ibuprofen in ug/ml
    y4_init = 0; % Intestine initial 
    y5_init = 0; % Blood plasma initial 
    
    hour = 60*60;
    
    %=============
    % Graphing Variables

    axisIbuprof = [ -1 25 0 800 ];
    axisFood = [ -1 25 0 200 ];
    axisInt = [-1 25 0 800 ];
    axisBlood = [ -1 25 0 155 ];
    axisStomach = [-1 25 0 800 ];
    
    [T,M] = ode45(@deriv,[0 25*hour],[y1_init; y2_init; y3_init; y4_init; y5_init]); 
    Q = M;
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plotting
    
%     % Plotting Ibu with fasting
%     pf = 0;
%     calories = 1;
%     [T,M] = ode45(@deriv,[0 25*hour],[y1_init; y2_init; y3_init; y4_init; y5_init]); 
%     hours = T/hour;
%     
%     subplot(3,5,1)
%     title('Ibuprofen Disintegration','FontSize',14);
%     hold all
%     plot(fasteds(:,1),fasteds(:,2)*8,'rx','LineWidth',3);
%     plot(hours, M(:,1),'b','LineWidth',2);
%     axis(axisIbuprof)
%     
%     subplot(3,5,2)
%     hold all
%     title('Ibuprofen in Stomach','FontSize',14)
%     plot(hours, M(:,2));
%     axis(axisStomach);
%     
%     subplot(3,5,3)
%     title('Ibuprofen in Food','FontSize',14)
%     hold all;
%     plot(hours, M(:,3),'b','LineWidth',2);
%     axis(axisFood)
%     
%     subplot(3,5,4)
%     title('Ibuprofen in Intestine','FontSize',14)
%     hold all;
%     plot(hours,M(:,4),'b','LineWidth',2)
%     axis(axisInt)
%     
%     subplot(3,5,5)
%     title('Ibuprofen in Blood Plasma','FontSize',14)
%     hold all
%     plot(fasted(:,1),fasted(:,2)*5,'rx','LineWidth',3);
%     plot(hours,M(:,5),'b','LineWidth',2)
%     axis(axisBlood)
%     
% 
%     
%     %=====================================
%     %Plotting Ibuprofen light breakfast
%     pf = .07;
%     calories = 646 ;
%     
%     [T,M] = ode45(@deriv,[0 25*hour],[y1_init; y2_init; y3_init; y4_init; y5_init]); 
%     hours = T/hour;
%     
%     subplot(3,5,6)
%     hold all
%     plot(lights(:,1),lights(:,2)*8,'rx','LineWidth',3);
%     plot(hours, M(:,1),'b','LineWidth',2);
%     ylabel('Mg of Ibuprofen in Stomach','FontSize',12)
%     axis(axisIbuprof)
%     
%     subplot(3,5,7)
%     plot(hours, M(:,2));
%     axis(axisStomach)
% 
%     subplot(3,5,8)
%     plot(hours, M(:,3),'b','LineWidth',2);
%     axis(axisFood)
%     
%     subplot(3,5,9)
%     plot(hours,M(:,4),'b','LineWidth',2)
%     axis(axisInt)
%     
%     subplot(3,5,10)
%     hold all
%     ylabel('Mg of Ibuprofen in Blood Plasma','FontSize',12)
%     plot(light(:,1),light(:,2)*5,'rx','LineWidth',3);
%     plot(hours,M(:,5),'b','LineWidth',2)
%     axis(axisBlood)
%     
%     % ====================================
%     % Plotting Ibuprof Heavy breakfast
%     pf = .66;
%     calories = 3327;
%     
%     [T,M] = ode45(@deriv,[0 25*hour],[y1_init; y2_init; y3_init; y4_init; y5_init]); 
%     hours = T/hour;
%     
%     subplot(3,5,11)
%     hold all
%     plot(heavys(:,1),heavys(:,2)*8,'rx','LineWidth',3);
%     plot(hours, M(:,1),'b','LineWidth',2);
%     axis(axisIbuprof)
%     xlabel('Time in Hours','FontSize',12)
%     
%     subplot(3,5,12)
%     plot(hours,M(:,2))
%     axis(axisStomach)
%     
%     subplot(3,5,13)
%     plot(hours, M(:,3),'b','LineWidth',2);
%     xlabel('Time in Hours', 'FontSize',12);
%     axis(axisFood);
%     
%     subplot(3,5,14)
%     plot(hours,M(:,4),'b','LineWidth',2)
%     axis(axisInt)
%     
%     subplot(3,5,15)
%     hold all
%     plot(heavy(:,1),heavy(:,2)*5,'rx','LineWidth',3);
%     plot(hours,M(:,5),'b','LineWidth',2)
%     axis(axisBlood)
%     xlabel('Time in Hours','FontSize',12)
%     %disp(T)
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Functions

    function res = deriv(t,Y);
        
        % ============
        % Disintegration of Ibuprofen
    %   alpha = .0138; % The rate at which the gastric emptying happens
        a1 = .000025; % The rate of disintegration of tablet at more than 50% tablet size
        a2 = 0.00005; % The rate of disintegratiioin of tablet at less than 50% tablet size
        
        % ============
        % Stomach Ibuprofen Concentration
        b1 = 0.0001;
        b2 = 0.00001;

        % ============
        % Food ibu. concentration
        c1 = .1;
        c2 = 0.0005;
        loss = 0.5;
        
        % ============
        % Intestine Conecentration
        d1 = 0.0001;
        d2 = 0.00005;

        % ============
        % Blood Ibuprofen Concentration
        e1 = 0.00016;
   
        
        
        
        y1 = Y(1);
        y2 = Y(2);
        y3 = Y(3);
        y4 = Y(4);
        y5 = Y(5);
        thour = t/(24*3600);
        
        a = a1;
        if y1 < 400
            a = a2;
        end
        
        %IBUPROFEN ------------------------------
        dy1dt = -a*y1;
        
        %STOMACH ------------------------------
        sdrain = b1*y2 *(3000/(calories+300));
        sadsorb = b2*(y2/y1)*(1-pf)*a;
        if sadsorb < 0
            sadsorb = 0;
        end
        dy2dt = -sdrain ; 
        
        % FOOD ------------------------------
        fadsorb = pf*c1*(y2/y1);
        fdrain = c2 * y3;
        dy3dt= fadsorb-fdrain; 
        
        % INTESTINE ------------------------------
        iadsorb = ((y4)/(y1))*a*y1;
        if iadsorb < 0
            iadsorb = 0;
        end
        dy4dt= sdrain + loss*fdrain - d2*y4; 
        
        % BLOOD PLASMA ------------------------------
        dy5dt= sadsorb + iadsorb - e1 * y5; 

        
        res = [dy1dt;dy2dt;dy3dt;dy4dt;dy5dt];     
        
    end 
end