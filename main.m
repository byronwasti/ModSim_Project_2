function main()
    
    stop = 12;
    s = zeros(stop,1);  % Stomach vector setup
    m = zeros(stop,1);  % Small Intestine vector setup
    b = zeros(stop,1);  % Blood vector setup
   
    s(1) = 24;
    for i = 1:stop
        s(i+1) = s(i) - sdiff(s(i),m(i),b(i));
        m(i+1) = m(i) - idiff(s(i),m(i),b(i));
    end
    
    function res = sdiff(s,m,b)
        alpha = .1;
        res = s*alpha;
    end

    function res = idiff(s,m,b)
        res = 0;
    end

    function res = bdiff(s,m,b)
        res = 0;
    end
        
    plotter(s,1,m,0,b,0); % 1 is plot, 0 is not plot
end