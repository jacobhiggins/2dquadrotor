classdef SingleSegTraj1D < handle
    properties
        duration;
        coeffs; % t^0, t^1, t^2, t^3, t^4, t^5 
    end
    methods
        function obj = SingleSegTraj1D(duration,boundaryConds)
            obj.duration = duration;
            obj.coeffs = obj.getCoeffs(boundaryConds);
        end
        function coeffs = getCoeffs(obj,boundaryConds)
            % Solve for coeffs using boundary conditions
            % boundaryConds = [p(0),v(0),a(0),p(T),v(T),a(T)]'
            % p(t) = c0 + c1*t + c2*t^2/2 + c3*t^3/3! + c4*t^4/4! + c5*t^5/5!
            
            T = obj.duration;
            
            A = [1 0 0 0 0 0; % p(0) = c0
                 0 1 0 0 0 0; % v(0) = c1  
                 0 0 1 0 0 0; % a(0) = c2
                 1 T T^2/2 T^3/6 T^4/24 T^5/120; % p(T) = c0 + c1*T + c2*T^2/2 + c3*T^3/6 + c4*T^4/24 + c5*T^5/120
                 0 1 T T^2/2 T^3/6 T^4/24; % v(T) = c1 + c2*T + c3*T^2/2 + c4*T^3/6 + c5*T^4/24
                 0 0 1 T T^2/2 T^3/6]; % a(T) = c2 + c3*T + c4*T^2/2 + c5*T^3/6
             
            coeffs = A \ boundaryConds; 
        end
        function [pos,vel,acc,ts] = getPoints(obj,dt)

            c0 = obj.coeffs(1); c1 = obj.coeffs(2); c2 = obj.coeffs(3);
            c3 = obj.coeffs(4); c4 = obj.coeffs(5); c5 = obj.coeffs(6);
            % Coeff matrix
            cm = [c0 c1 c2 c3 c4 c5;
                  c1 c2 c3 c4 c5 0;
                  c2 c3 c4 c5 0  0];
            % Time matrix
            N = int16(obj.duration/dt); % Number of points from start to end
            ts = NaN(6,N);
            for i = 1:(N+1)
                t = double((i-1))*dt;
                ts(:,i) = [t^0;
                           t^1;
                           t^2/2;
                           t^3/6;
                           t^4/24;
                           t^5/120];
            end
            
            pos = cm(1,:)*ts;
            vel = cm(2,:)*ts;
            acc = cm(3,:)*ts;
        end
    end
end