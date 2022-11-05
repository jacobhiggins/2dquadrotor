classdef Quadrotor < handle
    properties
        x; % State = [py, pz, theta, vy, vz, thetadot]^T
        m = 1; % Quadrotor mass
        L = 1; % Quadrotor arm length
        I = 1; % Quadrotor moment of inertia
    end
    methods
        function obj = Quadrotor()
            obj.x = [0 0 0 0 0 0]'; % Initialize state at origin
        end
        function xdot = EOM(obj,t,x,u)
            
            %    u2            u1
            %   ---           ---
            %    |             | 
            %     -------------
            
            % Equations of motion:
            % ydot = vy
            % zdot = vz
            % thetadot = thetadot
            % yddot = (u1 + u2)*sin(theta) / m
            % zddot = ( (u1 + u2)*cos(theta) - g ) / m
            % thetaddot = (u1 - u2)*l / I
            xdot = zeros(6,1); % Initialize state time derivative
            
            g = 9.8; % Acceleration due to gravity
            
            xdot(1) = x(4);
            xdot(2) = x(5);
            xdot(3) = x(6);
            xdot(4) = -(u(1) + u(2))*sin(x(3))/obj.m;
            xdot(5) = ( (u(1) + u(2))*cos(x(3)) )/obj.m - g;
            xdot(6) = (u(1)-u(2))*obj.L/obj.I;
        end
        function motionStep(obj,u,dt)
            [ts,xs] = ode45(@(t,x) obj.EOM(t,x,u),[0 dt],obj.x);
            obj.x = xs(end,:)';
        end
    end
end