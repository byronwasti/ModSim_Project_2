function main()

    stop = 50;
    s = zeros(stop,1);  % Stomach vector setup
    i = zeros(stop,1);  % Small Intestine vector setup
    b = zeros(stop,1);  % Blood vector setup
   
    
    s(1) = 1;
    for i = 1:stop
        s(i+1) = s(i) - sdiff(s(i));
        
    end
    
    function res = sdiff(s)
        alpha = .05;
        res = s * alpha;
    end

    plotter(s,i,b);
end